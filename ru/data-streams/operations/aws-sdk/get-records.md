# Чтение данных из потока

{% list tabs %}

- Python

  Для чтения записей из потока данных используется пара методов: `get_shard_iterator` и `get_record/get_records`. При вызове этого метода необходимо указать следующие параметры:
  * Имя потока данных, например `example-stream`.
  * [Идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором находится поток, например `aoeu1kuj2dhtaupdb5es`.
  * Идентификатор базы данных {{ ydb-full-name }} с потоком, например `cc8028jgtuabcqutgtbv`.

  Для чтения записей из потока с параметрами, указанными выше:
  1. Создайте файл `stream_get_records.py` и скопируйте в него следующий код:

     ```python
     import boto3
     from pprint import pprint
     import itertools
    
     def get_records(folder, database, stream_name):
         client = boto3.client('kinesis', endpoint_url="https://yds.serverless.yandexcloud.net")
    
         StreamName = "/{{ region-id }}/{folder}/{database}/{stream}".format(folder=folder,
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

  1. Запустите программу:

     ```bash
     python3 stream_get_records.py
     ```

     Результат:

     ```text
     The record has been read successfully
     b'{"user_id":"user1","score":100}'
     The record has been read successfully
     b'{"user_id":"user1","score":100}'
     ...
     ```

{% endlist %}