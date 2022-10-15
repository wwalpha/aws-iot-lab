import { DynamoDB } from 'aws-sdk';
import { KinesisStreamEvent } from 'aws-lambda';
import { Tables } from 'typings';

const TABLE_NAME_DEVICE_STATUS = process.env.TABLE_NAME_DEVICE_STATUS as string;
const client = new DynamoDB.DocumentClient();

export const handler = async (event: KinesisStreamEvent): Promise<any> => {
  event.Records.map((item) => console.log(item.kinesis.data));
};
