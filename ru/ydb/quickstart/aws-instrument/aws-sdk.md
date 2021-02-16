# Работа с AWS SDK 

После того как вы [настроили параметры](setup.md) для работы с AWS SDK, попробуйте поработать с таблицей с помощью AWS SDK для Python.

## Создание таблицы {#create}

Чтобы создать таблицу с именем `Series`:

1. Создайте файл `SeriesCreateTable.py` и скопируйте в него следующий код:

  ```python
  import boto3 # Предварительно этот модуль нужно установить 
               # с помощью команды pip install boto3

  def create_series_table(ydb = None):
      if not ydb:
          ydb = boto3.resource('dynamodb', 
                                endpoint_url = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87mbaomkfvsleds/etn02g38m12h9r0cdivp")

      table = ydb.create_table(
          TableName = 'Series', # Series — имя таблицы 
          KeySchema = [
              {
                  'AttributeName': 'series_id',
                  'KeyType': 'HASH'  # Ключ раздела
              },
              {
                  'AttributeName': 'title',
                  'KeyType': 'RANGE'  # Ключ сортировки
              }
          ],
          AttributeDefinitions = [
              {
                  'AttributeName': 'series_id',
                  'AttributeType': 'N'
              },
              {
                  'AttributeName': 'title',
                  'AttributeType': 'S'
              },
          ],
          ProvisionedThroughput = {
              'ReadCapacityUnits': 10,
              'WriteCapacityUnits': 10
          } # Параметр указывается для конфигурации базы данных с выделенными серверами (Dedicated)
      )
      return table

  if __name__ == '__main__':
      series_table = create_series_table()
      print("Статус таблицы:", series_table.table_status)
  ```

   {% note info %}

  Параметр `ProvisionedThroughput` является обязательным для конфигурации базы данных с выделенными серверами (Dedicated). Для базы данных в бессерверной (Serverless) конфигурации этот параметр не указывается.

  {% endnote %}

  Для работы со своей базой данных в качестве значения `endpoint_url` укажите Document API эндпоинт, доступный на вкладке Обзор вашей базы данных в [консоли управления]({{ link-console-main }}).

  В примере используется функция `print` из Python 3. Для использования этой функции в версиях Python 2.6 и старше добавьте в начало файла строку `from __future__ import print_function`.

2. Для запуска программы выполните команду:

  ```
  python SeriesCreateTable.py
  ```

  Результат выполнения:

  ```
  Статус таблицы: ACTIVE
  ```

## Добавление записи {#add}

Чтобы добавить в таблицу новую запись:

1. Создайте файл `SeriesCreateItem.py` и скопируйте в него следующий код:

  ```python
  from pprint import pprint
  import boto3

  def put_serie(series_id, title, release_date, series_info, ydb = None):
      if not ydb:
          ydb = boto3.resource('dynamodb', 
                                endpoint_url = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87mbaomkfvsleds/etn02g38m12h9r0cdivp")

      table = ydb.Table('Series')
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

  {% note info %}
  
  * Первичный ключ необходим. В этом примере добавляется запись с первичным ключом (`series_id`, `title`) и атрибутом `info`. Атрибут `info` содержит дополнительную информацию о сериале.
  * Класс `DecimalEncoder` используется для вывода чисел, хранящихся с помощью класса `Decimal`. В SDK Boto класс `Decimal` используется для хранения числовых значений YDB.

  {% endnote %}

1. Для запуска программы выполните команду:

  ```
  python SeriesCreateItem.py
  ```

  Результат выполнения:

  ```
  Сериал успешно добавлен:
  {'ResponseMetadata': {'HTTPStatusCode': 200,
                        'HTTPHeaders': {'content-type': 'application/x-amz-json-1.0',
                                        'x-amz-crc32': '2745614147',
                                        'x-request-id': '92a5fafe-169c-48e8-8071-4f8c8cca7004',
                                        'date': 'Sat, 26 Dec 2020 17:21:01 GMT',
                                        'content-length': '2'},
                        'RetryAttempts': 0}}
  ```

## Чтение записи {#read}

Для чтения записи из таблицы используется метод `get_item`, в котором нужно передать атрибуты первичного ключа нужной записи.

Чтобы прочитать запись из таблицы:

1. Создайте файл `SeriesReadItem.py` и скопируйте в него следующий код:

  ```python
  from pprint import pprint
  import boto3
  from botocore.exceptions import ClientError

  def get_serie(title, series_id, ydb = None):
      if not ydb:
          ydb = boto3.resource('dynamodb', 
                                endpoint_url = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87mbaomkfvsleds/etn02g38m12h9r0cdivp")

      table = ydb.Table('Series')

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
          pprint(serie, sort_dicts=False)
  ```


1. Для запуска программы выполните команду:

  ```
  python SeriesReadItem.py
  ```

  Результат выполнения:

  ```
  Получена запись:
  {'series_id': Decimal('3'),
  'title': ' Supernatural,
  'info': {'release_date': 2015-09-13',
            'series_info': 'Supernatural is an American television series '
                           'created by Eric Kripke'}}
  ```

## Удаление таблицы {#delete}

{% note warning %}

Удаление таблицы — это необратимая операция.

{% endnote %}

Чтобы удалить таблицу `Series`:

1. Создайте файл `SeriesDeleteTable.py` и скопируйте в него следующий код:

  ```python
  import boto3

  def delete_serie_table(ydb = None):
      if not ydb:
          ydb = boto3.resource('dynamodb', 
                                endpoint_url="https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87mbaomkfvsleds/etn02g38m12h9r0cdivp")

      table = ydb.Table('Series')
      table.delete()

  if __name__ == '__main__':
      delete_serie_table()
      print("Таблица Series удалена")
  ```

1. Для запуска программы выполните команду:

  ```
  python SeriesDeleteTable.py
  ``` 

  Результат выполнения:

  ```
  Таблица Series удалена
  ```

