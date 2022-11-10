# Удаление потока данных в AWS SDK

{% list tabs %}

- Python

  Для удаления [потока данных](../../concepts/glossary.md#stream-concepts) используется метод `delete_stream`.  При вызове этого метода необходимо указать следующие параметры:
  * Имя удаляемого потока данных, например `example-stream`.
  * [Идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором будет удален поток, например `aoeu1kuj2dhtaupdb5es`.
  * Идентификатор базы данных {{ ydb-full-name }} с потоком, например `cc8028jgtuabcqutgtbv`.

  Чтобы удалить поток с параметрами, указанными выше:

  1. Создайте файл `stream_delete.py` и скопируйте в него следующий код:

     ```python
     import boto3
     from pprint import pprint

     def delete_stream(folder, database, stream_name):
       client = boto3.client('kinesis', endpoint_url="https://yds.serverless.yandexcloud.net")
       response = client.delete_stream(
         StreamName="/{{ region-id }}/{folder}/{database}/{stream}".format(folder=folder,
                                                                       database=database,
                                                                       stream=stream_name)
         )
         return response

     if __name__ == '__main__':
       delete_stream_response = delete_stream(
         folder="aoeu1kuj2dhtaupdb5es",
         database="cc8028jgtuabcqutgtbv",
         stream_name="example-stream")

         print("The stream has been deleted successfully")
         pprint(delete_stream_response)
     ```

  1. Запустите программу:

     ```bash
     python3 stream_delete.py
     ```

     Результат:

     ```text
     The stream has been deleted successfully
     {
       'ResponseMetadata': {
         'HTTPHeaders': {
         'connection': 'keep-alive',
         'content-length': '3',
         'content-type': 'application/json',
         'date': ''
         'GMT',
         'server': 'nginx/1.19.5'
         },
       'HTTPStatusCode': 200,
       'RetryAttempts': 0
       }
     }
     ```

{% endlist %}