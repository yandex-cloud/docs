---
title: Чтение данных из потока в AWS SDK
description: Следуя данной инструкции, вы сможете получить данные из потока в AWS SDK.
---

# Чтение данных из потока в AWS SDK

{% list tabs group=programming_language %}

- Python {#python}

  Для чтения записей из потока данных используется пара методов: `get_shard_iterator` и `get_record/get_records`. При вызове этого метода необходимо указать следующие параметры:
  * Имя потока данных, например `example-stream`.
  * [Идентификатор облака](../../../resource-manager/operations/cloud/get-id.md), в котором находится поток, например `b1gi1kuj2dht********`.
  * Идентификатор базы данных {{ ydb-short-name }} с потоком, например `cc8028jgtuab********`.

  Вам также потребуется [настроить](prepare.md) AWS SDK и [назначить](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль `yds.viewer`.

  Для чтения записей из потока с параметрами, указанными выше:
  1. Создайте файл `stream_get_records.py` и скопируйте в него следующий код:

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