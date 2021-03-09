# Обновление записи

В этой инструкции описано, как внести изменения в уже существующую в таблице запись.

## Безусловное обновление {#update-item}

{% list tabs %}

- Python

  Для изменения существующей записи используется метод `update_item`. С помощью него можно обновить значения существующих атрибутов, добавить или удалить атрибуты.

  В параметре `UpdateExpression` метода `update_item` передаются все обновления, которые применяются к указанной записи. Параметр `ReturnValues` указывает {{ ydb-short-name }} возвращать только обновленные атрибуты (`UPDATED_NEW`).

  В SDK Boto 3 для хранения числовых значений {{ ydb-short-name }} используется класс `Decimal`.

  В примере ниже выполняются следующие обновления:
  * изменяется значение существующего атрибута `release_date`;
  * добавляется новый атрибут `rating`.

  Чтобы обновить данные о сериале в таблице `Series`:

  1. Создайте файл `SeriesItemOps03.py` и скопируйте в него следующий код:

      ```python
      from decimal import Decimal
      from pprint import pprint
      import boto3

      def update_serie(title, series_id, release_date,  rating):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<эндпойнт базы данных>")

          table = ydb_docapi_client.Table('Series')

          response = table.update_item(
              Key = {
                  'series_id': series_id,
                  'title': title
              },
              UpdateExpression = "set info.release_date = :d, info.rating = :r ",
              ExpressionAttributeValues = {
                  ':d': release_date,
                  ':r': Decimal(rating)
              },
              ReturnValues = "UPDATED_NEW"
          )
          return response

      if __name__ == '__main__':
          update_response = update_serie(
              "Supernatural", 3, "2005-09-13", 8)
          print("Данные о сериале обновлены:")
          pprint(update_response, sort_dicts = False)
      ```

  1. Запустите программу:

      ```bash
      python SeriesItemOps03.py
      ```

      Результат выполнения:

      ```bash
      Данные о сериале обновлены:
      {'Attributes': {'info': {'release_date': '2005-09-13',
                              'series_info': 'Supernatural is an American '
                                              'television series created by Eric '
                                              'Kripke',
                              'rating': Decimal('8')}},
      'ResponseMetadata': {'HTTPStatusCode': 200,
                            'HTTPHeaders': {'content-type': 'application/x-amz-json-1.0',
                                            'x-amz-crc32': '672222905',
                                            'x-request-id': '43c12c64-178b-4144-8766-95dbcf2421b8',
                                            'date': 'Sun, 27 Dec 2020 13:01:12 GMT',
                                            'content-length': '175'},
                            'RetryAttempts': 0}}
      ```

{% endlist %}

## Увеличение атомарного счетчика {#increment-ac}

{% list tabs %}

- Python

  {{ ydb-short-name }} поддерживает использование атомарных счетчиков. С их помощью можно увеличить или уменьшить значение существующего атрибута, используя метод `update_item`. При этом все запросы на запись применяются в том порядке, в котором они пришли.

  Следующая программа показывает, как увеличить значение атрибута `rating` для сериала. При каждом запуске она увеличивает этот атрибут на единицу.

  Чтобы изменить значение атрибута `rating` для записи в таблице `Series`:

  1. Создайте файл `SeriesItemOps04.py` и скопируйте в него следующий код:

      ```python
      from decimal import Decimal
      from pprint import pprint
      import boto3

      def increase_rating(title, series_id, rating_increase):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<эндпойнт базы данных>")

          table = ydb_docapi_client.Table('Series')

          response = table.update_item(
              Key = {
                  'series_id': series_id,
                  'title': title
              },
              UpdateExpression = "set info.rating = info.rating + :val",
              ExpressionAttributeValues = {
                  ':val': Decimal(rating_increase)
              },
              ReturnValues = "UPDATED_NEW"
          )
          return response

      if __name__ == '__main__':
          update_response = increase_rating("Supernatural", 3, 1)
          print("Данные о сериале обновлены:")
          pprint(update_response, sort_dicts = False)
      ```

  1. Запустите программу:

      ```bash
      python SeriesItemOps04.py
      ```

      Результат выполнения:

      ```bash
      Данные о сериале обновлены:
      {'Attributes': {'info': {'rating': Decimal('9'),
                              'release_date': '2005-09-13',
                              'series_info': 'Supernatural is an American '
                                              'television series created by Eric '
                                              'Kripke'}},
      'ResponseMetadata': {'HTTPStatusCode': 200,
                            'HTTPHeaders': {'content-type': 'application/x-amz-json-1.0',
                                            'x-amz-crc32': '1351796704',
                                            'x-request-id': 'd5fcf336-c3b1-4d07-aaed-bb59f2a609ed',
                                            'date': 'Sun, 27 Dec 2020 13:35:10 GMT',
                                            'content-length': '175'},
                            'RetryAttempts': 0}}
      ```

{% endlist %}

## Обновление с условием {#update-with-cond}

{% list tabs %}

- Python

  В следующей программе показано, как использовать метод `update_item` с условием. Если условие принимает значение `true`, обновление завершается успешно. Условие обновления указывается в параметре `ConditionExpression`.

  В этом примере к записи добавляется рекомендация о просмотре, если рейтинг сериала выше 9.

  Чтобы выполнить обновление с условием для записи в таблице `Series`:

  1. Создайте файл `SeriesItemOps05.py` и скопируйте в него следующий код:

      ```python
      from pprint import pprint
      import boto3
      from botocore.exceptions import ClientError

      def add_recommend(title, series_id, rating_val):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<эндпойнт базы данных>")

          table = ydb_docapi_client.Table('Series')
          rec = "Recommended for viewing"

          try:
              response = table.update_item(
                  Key = {
                  'series_id': series_id,
                  'title': title
              },
                  UpdateExpression = "set info.recommend = :d ",
                  ConditionExpression = "info.rating > :num",
                  ExpressionAttributeValues = {
                      ':num': rating_val,
                      ':d': rec
              },
                  ReturnValues = "UPDATED_NEW"
              )
          except ClientError as e:
              if e.response['Error']['Code'] == "ConditionalCheckFailedException":
                  print(e.response['Error']['Message'])
              else:
                  raise
          else:
              return response

      if __name__ == '__main__':
          print("Попытка условного обновления...")
          update_response = add_recommend("Supernatural", 3, 9)
          if update_response:
              print("Данные о сериале обновлены:")
              pprint(update_response, sort_dicts = False)
      ```

  1. Для запуска программы выполните команду:

      ```bash
      python SeriesItemOps05.py
      ```

      Результат выполнения:

      ```bash
      Попытка условного обновления записи...
      Condition not satisfied
      ```

      Обновление не удалось, потому что рейтинг сериала равен 9, а условием для обновления является значение рейтинга выше 9.

  1. Измените программу так, чтобы условием для обновления был рейтинг 9 и выше. При этом параметр `ConditionExpression` будет выглядеть следующим образом:

      ```python
      ConditionExpression = "info.rating >= :num" 
      ```

  1. Запустите программу еще раз. Теперь операция обновления должна завершиться успешно.

      Результат выполнения:

      ```bash
      Попытка условного обновления записи...
      Данные о сериале обновлены:
      {'Attributes': {'info': {'release_date': '2005-09-13',
                              'series_info': 'Supernatural is an American '
                                              'television series created by Eric '
                                              'Kripke',
                              'recommend': 'Recommended for viewing',
                              'rating': Decimal('9')}},
      'ResponseMetadata': {'HTTPStatusCode': 200,
                            'HTTPHeaders': {'content-type': 'application/x-amz-json-1.0',
                                            'x-amz-crc32': '1812512314',
                                            'x-request-id': 'dcf97598-51f3-419a-b7ba-0b3ad0f5067e',
                                            'date': 'Wed, 13 Jan 2021 10:26:53 GMT',
                                            'content-length': '219'},
                            'RetryAttempts': 0}}
      ```

{% endlist %}