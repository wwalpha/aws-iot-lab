import { KinesisStreamEvent } from 'aws-lambda';

// const TABLE_NAME_DEVICE_STATUS = process.env.TABLE_NAME_DEVICE_STATUS as string;

export const handler = async (event: KinesisStreamEvent): Promise<any> => {
  event.Records.map((item) => console.log(item.kinesis.data));
};
