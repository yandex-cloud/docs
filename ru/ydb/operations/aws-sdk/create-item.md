# Создание записи

{% list tabs %}

- Python

  Для создания записи в таблице используется метод `put_item`. При вызове этого метода необходимо указать первичный ключ для новой записи. В коде ниже добавляется запись с первичным ключом (`series_id`, `title`) и атрибутом `info`. Атрибут `info` содержит дополнительную информацию о сериале.

  Чтобы добавить новую запись в таблицу `Series`:

  1. Создайте файл `SeriesItemOps01.py` и скопируйте в него следующий код:

      ```python
      from pprint import pprint
      import boto3

      def put_serie(series_id, title, release_date, series_info):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<эндпойнт базы данных>")

          table = ydb_docapi_client.Table('Series')
          response = table.put_item(
            Item = {
                  'series_id': series_id,
                  'title': title,
                  'info': {
                      'release_date': release_date,
                      'series_info': series_info
                  }
              }
          )
          return response

      if __name__ == '__main__':
          serie_resp = put_serie(3, "Supernatural", "2015-09-13",
                                "Supernatural is an American television series created by Eric Kripke")
          print("Сериал успешно добавлен:")
          pprint(serie_resp, sort_dicts = False)
      ```

  1. Запустите программу:

      ```bash
      python SeriesItemOps01.py
      ```

      Результат выполнения:

      ```bash
      Сериал успешно добавлен:
      {'ResponseMetadata': {'HTTPStatusCode': 200,
                            'HTTPHeaders': {'content-type': 'application/x-amz-json-1.0',
                                            'x-amz-crc32': '2745614147',
                                            'x-request-id': '92a5fafe-169c-48e8-8071-4f8c8cca7004',
                                            'date': 'Sat, 26 Dec 2020 17:21:01 GMT',
                                            'content-length': '2'},
                            'RetryAttempts': 0}}
      ```

{% endlist %}