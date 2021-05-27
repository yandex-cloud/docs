# Удаление записи

{% list tabs %}

- Python

  Для удаления записи используется метод `delete_item`, в котором нужно передать атрибуты первичного ключа нужной записи. При необходимости вы можете задать условие для удаления записи, указав параметр `ConditionExpression`.

  В этом примере выполняется удаление записи, если рейтинг сериала меньше или равен 5.

  Чтобы выполнить удаление записи в таблице `Series`:

  1. Создайте файл `SeriesItemOps06.py` и скопируйте в него следующий код:

      ```python
      from decimal import Decimal
      from pprint import pprint
      import boto3
      from botocore.exceptions import ClientError

      def delete_underrated_serie(title, series_id, rating):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<эндпойнт базы данных>")

          table = ydb_docapi_client.Table('Series')

          try:
              response = table.delete_item(
                  Key = {
                      'series_id': series_id,
                      'title': title
                  },
                  ConditionExpression = "info.rating <= :val",
                  ExpressionAttributeValues = {
                      ":val": Decimal(rating)
                  }
              )
          except ClientError as e:
              if e.response['Error']['Code'] == "ConditionalCheckFailedException":
                  print(e.response['Error']['Message'])
              else:
                  raise
          else:
              return response

      if __name__ == '__main__':
          print("Попытка удаления записи...")
          delete_response = delete_underrated_serie("Supernatural", 3, 5)
          if delete_response:
              print("Данные о сериале удалены:")
              pprint(delete_response, sort_dicts = False)
      ```

  1. Запустите программу:

      ```bash
      python SeriesItemOps06.py
      ```

      Результат выполнения:

      ```bash
      Попытка удаления записи...
      Condition not satisfied
      ```

      Удаление записи не удалось, потому что рейтинг сериала равен 9, а условием для удаления является значение рейтинга меньше или равно 5.

  1. Измените программу так, чтобы удалить условие при вызове метода `delete_item`:

      ```python
      response = table.delete_item(
          Key = {
              'series_id': series_id,
              'title': title
          }
      )
      ```

  1. Запустите программу еще раз. Теперь операция удаления должна завершиться успешно.

      Результат выполнения:

      ```bash
      Попытка удаления записи...
      Данные о сериале удалены:
      {'ResponseMetadata': {'HTTPStatusCode': 200,
                            'HTTPHeaders': {'content-type': 'application/x-amz-json-1.0',
                                            'x-amz-crc32': '2745614147',
                                            'x-request-id': '786fed1d-3c71-4fee-9827-f3f28da0493e',
                                            'date': 'Wed, 13 Jan 2021 11:04:13 GMT',
                                            'content-length': '2'},
                            'RetryAttempts': 0}}
      ```

{% endlist %}