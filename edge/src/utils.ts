import { iotidentity, mqtt } from 'aws-iot-device-sdk-v2';
import * as fs from 'fs';
import { join } from 'path';
import * as Consts from './consts';

export const execute_keys = async (identity: iotidentity.IotIdentityClient) =>
  new Promise<string>(async (resolve, reject) => {
    try {
      const keysAccepted = (
        error?: iotidentity.IotIdentityError,
        response?: iotidentity.model.CreateKeysAndCertificateResponse
      ) => {
        if (response) {
          console.log('CreateKeysAndCertificateResponse for certificateId=' + response.certificateId);

          // certificate
          if (response.certificatePem) {
            fs.writeFileSync(join(__dirname, Consts.DEVICE_CERTIFICATE_PATH), response.certificatePem);
          }

          // private key
          if (response.privateKey) {
            fs.writeFileSync(join(__dirname, Consts.DEVICE_PRIVATE_KEY_PATH), response.privateKey);
          }
        }

        // error check
        if (error || !response || !response.certificateOwnershipToken) {
          console.log('Error occurred..');
          reject(error);
        } else {
          resolve(response.certificateOwnershipToken);
        }
      };

      const keysRejected = (error?: iotidentity.IotIdentityError, response?: iotidentity.model.ErrorResponse) => {
        if (response) {
          console.log(
            'CreateKeysAndCertificate ErrorResponse for ' +
              ' statusCode=:' +
              response.statusCode +
              ' errorCode=:' +
              response.errorCode +
              ' errorMessage=:' +
              response.errorMessage
          );
        }
        if (error) {
          console.log('Error occurred..');
        }

        reject(error);
      };

      console.log('Subscribing to CreateKeysAndCertificate Accepted and Rejected topics..');

      const keysSubRequest: iotidentity.model.CreateKeysAndCertificateSubscriptionRequest = {};

      await identity.subscribeToCreateKeysAndCertificateAccepted(
        keysSubRequest,
        mqtt.QoS.AtLeastOnce,
        (error, response) => keysAccepted(error, response)
      );

      await identity.subscribeToCreateKeysAndCertificateRejected(
        keysSubRequest,
        mqtt.QoS.AtLeastOnce,
        (error, response) => keysRejected(error, response)
      );

      console.log('Publishing to CreateKeysAndCertificate topic..');

      const keysRequest: iotidentity.model.CreateKeysAndCertificateRequest = {
        toJSON() {
          return {};
        },
      };

      await identity.publishCreateKeysAndCertificate(keysRequest, mqtt.QoS.AtLeastOnce);
    } catch (error) {
      reject(error);
    }
  });

export const execute_register_thing = async (identity: iotidentity.IotIdentityClient, token: string) => {
  return new Promise<void>(async (resolve, reject) => {
    try {
      const registerAccepted = (
        error?: iotidentity.IotIdentityError,
        response?: iotidentity.model.RegisterThingResponse
      ) => {
        if (response) {
          console.log(response);
          console.log('RegisterThingResponse for thingName=' + response.thingName);
        }

        if (error) {
          console.log('Error occurred..');
        }

        resolve();
      };

      const registerRejected = (error?: iotidentity.IotIdentityError, response?: iotidentity.model.ErrorResponse) => {
        if (response) {
          console.log(
            'RegisterThing ErrorResponse for ' +
              'statusCode=:' +
              response.statusCode +
              'errorCode=:' +
              response.errorCode +
              'errorMessage=:' +
              response.errorMessage
          );
        }
        if (error) {
          console.log('Error occurred..');
        }
        resolve();
      };

      console.log('Subscribing to RegisterThing Accepted and Rejected topics..');

      const registerThingSubRequest: iotidentity.model.RegisterThingSubscriptionRequest = {
        templateName: Consts.IOT_TEMPLATE_NAME,
      };

      await identity.subscribeToRegisterThingAccepted(
        registerThingSubRequest,
        mqtt.QoS.AtLeastOnce,
        (error, response) => registerAccepted(error, response)
      );

      await identity.subscribeToRegisterThingRejected(
        registerThingSubRequest,
        mqtt.QoS.AtLeastOnce,
        (error, response) => registerRejected(error, response)
      );

      console.log('Publishing to RegisterThing topic..');

      const parameters: Record<string, string> = {
        SerialNumber: Consts.IOT_DEVICE_SERIAL_NUMBER,
      };

      const registerThing: iotidentity.model.RegisterThingRequest = {
        parameters: parameters,
        templateName: Consts.IOT_TEMPLATE_NAME,
        certificateOwnershipToken: token,
      };

      await identity.publishRegisterThing(registerThing, mqtt.QoS.AtLeastOnce);
    } catch (error) {
      reject(error);
    }
  });
};
