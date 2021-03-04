# Поиск и извлечение данных

Для поиска данных в таблице используется метод `query`, в котором нужно передать атрибуты первичного ключа нужной записи. Если ключ составной, то обязательно указывать только ключ партицирования, а ключ сортировки — опционально. В {{ ydb-short-name }} можно также создать один или несколько вторичных индексов для таблицы и сделать запрос с их помощью. Вторичные индексы позволяют делать запросы по неключевым атрибутам.

Первичный ключ таблицы `Series` составной и состоит из следующих атрибутов:

* `series_id` — ключ партицирования (тип атрибута — число);
* `title` — ключ сортировки (тип атрибута — строка).

Чтобы найти все сериалы с ключом партицирования, равным 3, нужно передать это значение в методе `query`. Также можно ограничить выбор по названию сериала, указав условие для ключа сортировки. Например, вы можете найти сериалы с ключом партицирования, равным 3, которые имеют название, начинающееся с буквы T.

В дополнение к методу `query` вы можете использовать метод `scan` для извлечения всех табличных данных.

## Поиск по ключу партицирования {#part-key-find}

{% list tabs %}

- Python

  SDK Boto 3 создает параметр `ConditionExpression` за вас, когда вы используете функции `Key` и `Attr`, импортированные из `boto3.dynamodb.conditions`. Вы также можете указать значение параметра `ConditionExpression` в виде строки.

  Чтобы найти в таблице `Series` все сериалы с ключом партицирования, равным 3:

  1. Создайте файл `SeriesQuery01.py` и скопируйте в него следующий код:

      ```python
      import boto3
      from boto3.dynamodb.conditions import Key

      def query_series(series_id):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<эндпойнт базы данных>")

          table = ydb_docapi_client.Table('Series')
          response = table.query(
              KeyConditionExpression = Key('series_id').eq(series_id)
          )
          return response['Items']

      if __name__ == '__main__':
          query_id = 3
          print(f"Сериалы с id = {query_id}")
          series = query_series(query_id)
          for serie in series:
              print(serie['series_id'], ":", serie['title'])
      ```

  1. Запустите программу:

      ```bash
      python SeriesQuery01.py
      ```

      Результат выполнения:

      ```bash
      Сериалы с id = 3
      3 : House of Cards
      3 : The Office
      3 : True Detective
      ```

{% endlist %}

## Поиск по ключам партицирования и сортировки {#part-sort-key-find}

{% list tabs %}

- Python

  SDK Boto 3 создает параметр `ConditionExpression` за вас, когда вы используете функции `Key` и `Attr`, импортированные из `boto3.dynamodb.conditions`. Вы также можете указать значение параметра `ConditionExpression` в виде строки.

  Чтобы найти в таблице `Series` сериалы с ключом партицирования, равным 3, и названием на букву T:

  1. Создайте файл `SeriesQuery02.py` и скопируйте в него следующий код:

      ```python
      from pprint import pprint
      import boto3
      from boto3.dynamodb.conditions import Key

      def query_and_project_series(series_id, title_range):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<эндпойнт базы данных>")

          table = ydb_docapi_client.Table('Series')
          
          response = table.query(
              ProjectionExpression = "series_id, title, info.release_date",
              KeyConditionExpression = Key('series_id').eq(series_id) & Key('title').begins_with(title_range)
          )
          return response['Items']

      if __name__ == '__main__':
          query_id = 3
          query_range = 'T'
          print(f"Сериалы с id = {query_id} и названием на букву "
                f"{query_range}")
          series = query_and_project_series(query_id, query_range)
          for serie in series:
              print(f"\n{serie['series_id']} : {serie['title']}")
              pprint(serie['info'])
      ```

  1. Запустите программу:

      ```bash
      python SeriesQuery02.py
      ```

      Результат выполнения:

      ```bash
      Сериалы с id = 3 и названием на букву Т
      3 : The Office
      3 : True Detective
      ```

{% endlist %}

## Сканирование {#scanning}

{% list tabs %}

- Python

  Метод `scan` считывает каждую запись в таблице и возвращает найденные данные. Для фильтрации найденных данных вы можете указать необязательный параметр `FilterExpression`, в котором указать условия отбора. Однако фильтрация применяется только после сканирования всей таблицы. В параметре `ProjectionExpression` указываются атрибуты, которые вы хотите получить в результате сканирования. 

  Метод `scan` при каждом вызове возвращает подмножество записей, называемое страницей. Затем значение `LastEvaluatedKey` в ответе передается методу `scan` через параметр `ExclusiveStartKey`. Когда возвращается последняя страница, значение `LastEvaluatedKey` не включается в ответ.

  Чтобы выбрать из таблицы `Series`все сериалы с атрибутом `series_id`, равным от 1 до 3:

  1. Создайте файл `SeriesScan.py` и скопируйте в него следующий код:

      ```python
      from pprint import pprint
      import boto3
      from boto3.dynamodb.conditions import Key

      def scan_series(id_range, display_series):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<эндпойнт базы данных>")

          table = ydb_docapi_client.Table('Series')
          scan_kwargs = {
              'FilterExpression': Key('series_id').between(*id_range),
              'ProjectionExpression': "series_id, title, info.release_date"
          }

          done = False
          start_key = None
          while not done:
              if start_key:
                  scan_kwargs['ExclusiveStartKey'] = start_key
              response = table.scan(**scan_kwargs)
              display_series(response.get('Items', []))
              start_key = response.get('LastEvaluatedKey', None)
              done = start_key is None

      if __name__ == '__main__':
          def print_series(series):
              for serie in series:
                  print(f"\n{serie['series_id']} : {serie['title']}")
                  pprint(serie['info'])

          query_range = (1, 3)
          print(f"Поиск сериалов с id, равным от {query_range[0]} до {query_range[1]}...")
          scan_series(query_range, print_series)
      ```

  1. Запустите программу:

      ```bash
      python SeriesScan.py
      ```

      Результат выполнения:

      ```bash
      Поиск сериалов с id, равным от 1 до 3...

      3 : House of Cards
      {'release_date': '2013-02-01'}

      3 : The Office
      {'release_date': '2005-03-24'}

      3 : True Detective
      {'release_date': '2014-01-12'}

      1 : IT Crowd
      {'release_date': '2006-02-03'}

      2 : Silicon Valley
      {'release_date': '2014-04-06'}
      ```

  Вы также можете использовать метода `scan` для работы с любыми вторичными индексами, созданными в таблице.

{% endlist %}