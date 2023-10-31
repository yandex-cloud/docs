---
title: "How to send data from {{ ydb-short-name }} to an AWS SDK stream"
description: "In this tutorial, you will learn how to send data from {{ ydb-short-name }} to an AWS SDK stream."
---

# Sending data to a stream in the AWS SDK

{% include [trigger](../../../_includes/data-streams/trigger.md) %}

{% list tabs %}

- Python

  To send data to a data stream, use the `put_record/put_records` method. When you invoke this method, you should specify the following parameters:
  * Name of the stream, e.g., `example-stream`.
  * [ID of the cloud](../../../resource-manager/operations/cloud/get-id.md) the stream is located in, such as `b1gi1kuj2dht********`.
  * {{ ydb-short-name }} database ID with the stream, e.g., `cc8028jgtuab********`.
  * Data being sent, e.g., `message`.

  You also need to [configure](prepare.md) the AWS SDK and [assign](../../../iam/operations/sa/assign-role-for-sa.md) the service account the `yds.writer` role.

  To send data to the stream with the parameters specified above:
  1. Create the `stream_put_record.py` file and copy the following code into it:

      ```python
      import boto3
      from pprint import pprint

      def put_record(cloud, database, stream_name, message):
        client = boto3.client('kinesis', endpoint_url="https://yds.serverless.yandexcloud.net")
        response = client.put_record(
          StreamName="/{{ region-id }}/{cloud}/{database}/{stream}".format(cloud=cloud,
                                                                        database=database,
                                                                        stream=stream_name),
          Data=message,
          PartitionKey=message
        )
        return response

      if __name__ == '__main__':
        put_record_response = put_record(
          cloud="b1gi1kuj2dht********",
          database="cc8028jgtuab********",
          stream_name="example-stream",
          message="message")

        print("The record has been sent successfully")
        pprint(put_record_response)
      ```

  1. Run the program:

      ```bash
      python3 stream_put_record.py
      ```

      Result:

      ```text
      The record has been sent successfully
      {
        'EncryptionType': 'NONE',
        'ResponseMetadata': {
          'HTTPHeaders': {
            'connection': 'keep-alive',
            'content-length': '81',
            'content-type': 'application/json',
            'date': ''
            'GMT',
            'server': 'nginx/1.19.5'
          },
          'HTTPStatusCode': 200,
          'RetryAttempts': 0
        },
        'SequenceNumber': '0',
        'ShardId': 'shard-000000'
      }
      ```

{% endlist %}