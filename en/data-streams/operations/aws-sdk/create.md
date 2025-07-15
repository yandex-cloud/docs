---
title: Creating a stream in the AWS SDK
description: Follow this guide to create a stream in the AWS SDK.
---

# Creating a stream in the AWS SDK

{% list tabs group=programming_language %}

- Python {#python}

  Use the `create_stream` method to create a stream. When you invoke this method, specify the following parameters:
  * Name of a stream being created, e.g., `example-stream`.
  * [ID of the cloud](../../../resource-manager/operations/cloud/get-id.md) to host the stream, e.g., `b1gi1kuj2dht********`.
  * ID of an existing {{ ydb-short-name }} [serverless](../../../ydb/pricing/serverless.md) database, e.g., `cc8028jgtuab********`. Learn how to create a new database in the [{{ ydb-short-name }} documentation](../../../ydb/quickstart.md#create-db).
  * Number of shards, e.g., `1`.

  You also need to [configure](prepare.md) the AWS SDK and [assign](../../../iam/operations/sa/assign-role-for-sa.md) the service account the `yds.editor` role.

  To create a stream with the above parameters:

  1. Create the `stream_create.py` file and paste the following code to it:

      ```python
      import boto3
      from pprint import pprint

      def create_stream(cloud, database, stream_name, shard_count):
          client = boto3.client('kinesis', endpoint_url="https://yds.serverless.yandexcloud.net")
          response = client.create_stream(
            StreamName="/{{ region-id }}/{cloud}/{database}/{stream}".format(cloud=cloud,
                                                                          database=database,
                                                                          stream=stream_name),
            ShardCount=shard_count
          )
          return response

      if __name__ == '__main__':
        create_stream_response = create_stream(
          cloud="b1gi1kuj2dht********",
          database="cc8028jgtuab********",
          stream_name="example-stream",
          shard_count=1)
        print("The stream has been created successfully")
        pprint(create_stream_response)
      ```

  1. Run the program:

     ```bash
     python3 stream_create.py
     ```

     Result:

     ```text
     The stream has been created successfully
     {
       'ResponseMetadata': {
         'HTTPHeaders': {
           'connection': 'keep-alive',
           'content-length': '3',
           'content-type': 'application/json',
           'date': ''
           'GMT',
           'server': 'nginx/1.19.5',
           'HTTPStatusCode': 200,
           'RetryAttempts': 0
         }
       }
     }
     ```

{% endlist %}