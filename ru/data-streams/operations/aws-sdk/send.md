---
title: "Инструкция по отправке данных из {{ ydb-short-name }} в поток в AWS SDK"
description: "Из статьи вы узнаете, как отправить данные из {{ ydb-short-name }} в поток в AWS SDK."
---

# Отправка данных в поток в AWS SDK

{% include [trigger](../../../_includes/data-streams/trigger.md) %}

{% list tabs %}

- Python

  Для отправки данных в поток данных используется метод `put_record/put_records`. При вызове этого метода необходимо указать следующие параметры:
  * Имя потока данных, например `example-stream`.
  * [Идентификатор облака](../../../resource-manager/operations/cloud/get-id.md), в котором находится поток, например `b1gi1kuj2dht********`.
  * Идентификатор базы данных {{ ydb-short-name }} с потоком, например `cc8028jgtuab********`.
  * Отправляемые данные, например `message`.

  Вам также потребуется [настроить](prepare.md) AWS SDK и [назначить](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль `yds.writer`.

  Чтобы отправить данные в поток с параметрами, указанными выше:
  1. Создайте файл `stream_put_record.py` и скопируйте в него следующий код:

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

  1. Запустите программу:

     ```bash
     python3 stream_put_record.py
     ```

     Результат:

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