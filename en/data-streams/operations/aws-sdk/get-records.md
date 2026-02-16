---
title: Reading data from a stream in the AWS SDK
description: Follow this guide to get data from a stream in the AWS SDK.
---

# Reading data from a stream in the AWS SDK

{% list tabs group=programming_language %}

- Python {#python}

  You can get data from a stream using the `get_shard_iterator` and `get_record/get_records` methods. When you invoke this method, specify the following parameters:
  * Stream name., e.g., `example-stream`.
  * [ID of the cloud](../../../resource-manager/operations/cloud/get-id.md) the stream is located in, e.g., `b1gi1kuj2dht********`.
  * ID of the {{ ydb-short-name }} database containing the stream, e.g., `cc8028jgtuab********`.

  You also need to [configure](prepare.md) the AWS SDK and [assign](../../../iam/operations/sa/assign-role-for-sa.md) the service account the `yds.viewer` role.

  To read records from a stream with the above parameters:
  1. Create the `stream_get_records.py` file and paste the following code to it:

     ```python
     import boto3
     from pprint import pprint
     import itertools
    
     def get_records(cloud, database, stream_name):
         client = boto3.client('kinesis', endpoint_url="https://yds.serverless.yandexcloud.net")

         StreamName = "/{{ region-id }}/{cloud}/{database}/{stream}".format(cloud=cloud,
                                                                      database=database,
                                                                      stream=stream_name)
    
    
         describe_stream_result = client.describe_stream(StreamName=StreamName)
         shard_iterators = {}
    
         shards = [shard["ShardId"] for shard in describe_stream_result['StreamDescription']['Shards']]
    
         for shard_id in itertools.cycle(shards):
             if shard_id not in shard_iterators:
                 shard_iterators[shard_id] = client.get_shard_iterator(StreamName=StreamName,
                                                                      ShardId=shard_id,
                                                                      ShardIteratorType='LATEST')['ShardIterator']
                
             record_response = client.get_records(ShardIterator=shard_iterators[shard_id])
             if "Records" in record_response:
                 for record in [record for record in record_response["Records"]]:
                     yield record["Data"]
    
             if "NextShardIterator" in record_response:
                 shard_iterators[shard_id] = record_response["NextShardIterator"]
    
    
     if __name__ == '__main__':
         for record in get_records(cloud="b1gi1kuj2dht********",
                                   database="cc8028jgtuab********",
                                   stream_name="example-stream"):
             pprint(record)    
             print("The record has been read successfully")
     ```

  1. Run the program:

     ```bash
     python3 stream_get_records.py
     ```

     Result:

     ```text
     The record has been read successfully
     b'{"user_id":"user1","score":100}'
     The record has been read successfully
     b'{"user_id":"user1","score":100}'
     ...
     ```

{% endlist %}