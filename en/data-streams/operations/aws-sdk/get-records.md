# Reading data from a stream

{% list tabs %}

- Python

  You can get data from a stream using the `get_shard_iterator` and `get_record/get_records` methods. When calling this method, specify the following parameters:
  * The name of a stream, for example, `example-stream`.
  * [ID of the folder](../../../resource-manager/operations/folder/get-id.md) in which the stream is located, for example, `aoeu1kuj2dhtaupdb5es`.
  * {{ ydb-full-name }} database ID with the stream, for example, `cc8028jgtuabcqutgtbv`.

  To read records from a stream with the parameters specified above:

  1. Create a file named `stream_get_records.py` and copy the following code into it:

     ```python
     import boto3
     from pprint import pprint
     import itertools
     
     def get_records(folder, database, stream_name):
         client = boto3.client('kinesis', endpoint_url="https://yds.serverless.yandexcloud.net")
     
         StreamName = "/ru-central1/{folder}/{database}/{stream}".format(folder=folder,
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
         for record in get_records(folder="aoeu1kuj2dhtaupdb5es",
                                   database="cc8028jgtuabcqutgtbv",
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
