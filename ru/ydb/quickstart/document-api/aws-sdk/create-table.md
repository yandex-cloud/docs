# Создание таблицы

Для работы со своей базой данных в качестве значения `<эндпойнт базы данных>` укажите Document API эндпоинт, доступный на вкладке Обзор вашей базы данных в [консоли управления]({{ link-console-main }}).

Чтобы создать таблицу с именем `Series`, ключом партицирования `series_id` и ключом сортировки `title`:

{% list tabs %}

- Python

  В коде ниже используется функция `print` из Python 3. Для использования этой функции в версиях Python 2.6 и старше добавьте в начало файла строку `from __future__ import print_function`.

  1. Создайте файл `SeriesCreateTable.py` и скопируйте в него следующий код:

      ```python
      import boto3

      def create_series_table():
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<эндпойнт базы данных>")

          table = ydb_docapi_client.create_table(
              TableName = 'Series', # Series — имя таблицы 
              KeySchema = [
                  {
                      'AttributeName': 'series_id',
                      'KeyType': 'HASH'  # Ключ партицирования
                  },
                  {
                      'AttributeName': 'title',
                      'KeyType': 'RANGE'  # Ключ сортировки
                  }
              ],
              AttributeDefinitions = [
                  {
                      'AttributeName': 'series_id',
                      'AttributeType': 'N'  # Целое число
                  },
                  {
                      'AttributeName': 'title',
                      'AttributeType': 'S'  # Строка
                  },

              ]
          )
          return table

      if __name__ == '__main__':
          series_table = create_series_table()
          print("Статус таблицы:", series_table.table_status)
      ```

  1. Запустите программу:

      ```bash
      python SeriesCreateTable.py
      ```

      Результат выполнения:

      ```bash
      Статус таблицы: ACTIVE
      ```

{% endlist %}