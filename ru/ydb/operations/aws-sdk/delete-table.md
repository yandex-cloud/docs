# Удаление таблицы

Чтобы удалить таблицу `Series`:

{% list tabs %}

- Python

  1. Создайте файл `SeriesDeleteTable.py` и скопируйте в него следующий код:

      ```python
      import boto3

      def delete_serie_table():
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<эндпойнт базы данных>")

          table = ydb_docapi_client.Table('Series')
          table.delete()

      if __name__ == '__main__':
          delete_serie_table()
          print("Таблица Series удалена")
      ```

  1. Запустите программу:

      ```bash
      python SeriesDeleteTable.py
      ```

      Результат выполнения:

      ```bash
      Таблица Series удалена
      ```

{% endlist %}