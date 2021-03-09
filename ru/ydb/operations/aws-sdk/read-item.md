# Чтение записи

{% list tabs %}

- Python

  Для чтения записи из таблицы используется метод `get_item`, в котором нужно передать атрибуты первичного ключа нужной записи.

  Чтобы прочитать запись из таблицы `Series`:

  1. Создайте файл `SeriesItemOps02.py` и скопируйте в него следующий код:

      ```python
      from pprint import pprint
      import boto3
      from botocore.exceptions import ClientError

      def get_serie(title, series_id):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<эндпойнт базы данных>")

          table = ydb_docapi_client.Table('Series')

          try:
              response = table.get_item(Key = {'series_id': series_id, 'title': title})
          except ClientError as e:
              print(e.response['Error']['Message'])
          else:
              return response['Item']

      if __name__ == '__main__':
          serie = get_serie("Supernatural", 3,)
          if serie:
              print("Получена запись:")
              pprint(serie, sort_dicts = False)
      ```

  1. Запустите программу:

      ```bash
      python SeriesItemOps02.py
      ```

      Результат выполнения:

      ```bash
      Получена запись:
      {'series_id': Decimal('3'),
      'title': ' Supernatural,
      'info': {'release_date': 2015-09-13',
                'series_info': 'Supernatural is an American television series '
                              'created by Eric Kripke'}}
      ```

{% endlist %}