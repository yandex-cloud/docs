# Создание потока данных в AWS SDK

{% list tabs %}

- Python

  Для создания потока данных используется метод `create_stream`. При вызове этого метода необходимо указать следующие параметры:
  * Имя создаваемого потока данных, например `example-stream`.
  * [Идентификатор облака](../../../resource-manager/operations/cloud/get-id.md), в котором будет создан поток, например `b1gi1kuj2dhtaupdb5es`.
  * Идентификатор существующей [бессерверной](../../../ydb/pricing/serverless.md) базы данных {{ ydb-full-name }}, например `cc8028jgtuabcqutgtbv`. Как создать новую базу данных, читайте в [документации {{ ydb-short-name }}](../../../ydb/quickstart.md#create-db).
  * Число сегментов, например `1`.

  Чтобы создать поток с параметрами, указанными выше:

  1. Создайте файл `stream_create.py` и скопируйте в него следующий код:

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
         cloud="b1gi1kuj2dhtaupdb5es",
         database="cc8028jgtuabcqutgtbv",
         stream_name="example-stream",
         shard_count=1)
       print("The stream has been created successfully")
       pprint(create_stream_response)
     ```

  1. Запустите программу:

     ```bash
     python3 stream_create.py
     ```

     Результат:

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
           'server': 'nginx/1.19.5'},
           'HTTPStatusCode': 200,
           'RetryAttempts': 0
         }
       }
     }
     ```

{% endlist %}