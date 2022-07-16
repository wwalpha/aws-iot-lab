import { mqtt, iot, iotidentity } from 'aws-iot-device-sdk-v2';
import * as fs from 'fs';
import { join } from 'path';
import * as Consts from './consts';
import { execute_keys, execute_register_thing } from './utils';

const buildConnection = (): mqtt.MqttClientConnection => {
  let builder = iot.AwsIotMqttConnectionConfigBuilder.new_default_builder();

  const initialized = fs.existsSync(join(__dirname, Consts.DEVICE_PRIVATE_KEY_PATH));

  console.log('initialized', initialized, join(__dirname, Consts.DEVICE_PRIVATE_KEY_PATH));

  // 初期化未完了
  if (initialized === false) {
    builder = iot.AwsIotMqttConnectionConfigBuilder.new_mtls_builder_from_path(
      join(__dirname, Consts.DEFAULT_CERTIFICATE_PATH),
      join(__dirname, Consts.DEFAULT_PRIVATE_KEY_PATH)
    );
  } else {
    builder = iot.AwsIotMqttConnectionConfigBuilder.new_mtls_builder_from_path(
      join(__dirname, Consts.DEVICE_CERTIFICATE_PATH),
      join(__dirname, Consts.DEVICE_PRIVATE_KEY_PATH)
    );
  }

  builder.with_certificate_authority_from_path(undefined, join(__dirname, Consts.CA_PEM_PATH));
  builder.with_clean_session(false);
  builder.with_client_id('test-' + Math.floor(Math.random() * 100000000));
  builder.with_endpoint(Consts.IOT_ENDPOINT);

  console.log('start build', builder);

  const config = builder.build();
  console.log('end build', builder);

  const client = new mqtt.MqttClient();
  return client.new_connection(config);
};

/** 初回接続 */
const initialize = async () => {
  const connection = buildConnection();

  console.log('Connecting...');

  await connection.connect();

  const identity = new iotidentity.IotIdentityClient(connection);

  // get private key
  const token = await execute_keys(identity);
  // regist thing
  await execute_register_thing(identity, token);

  await connection.disconnect();

  console.log('Disconnected...');
};

const start = async () => {
  const initialized = fs.existsSync(Consts.DEVICE_PRIVATE_KEY_PATH);

  if (initialized === false) {
    console.log('initialize...');

    await initialize();
  }

  const connection = buildConnection();

  const timer = setInterval(() => {}, 20 * 1000);

  console.log('Connecting...');

  await connection.connect();

  console.log('Connection completed.');
  console.log('Disconnecting...');

  await connection.disconnect();

  console.log('Disconnect completed.');

  // Allow node to die if the promise above resolved
  clearTimeout(timer);
};

start();

process.on('unhandledRejection', (reason: any) => {
  console.log(reason);
});
