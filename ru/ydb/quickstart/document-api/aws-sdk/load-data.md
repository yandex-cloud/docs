# Загрузка образца данных

Данные о сериалах находятся в файле формата JSON. Для каждого сериала есть номер, название и атрибут с именем `info`. 

{% cut "Как хранятся данные в JSON-формате" %}

Структура JSON-файла c информацией о сериале:

```json
[
   {
      "series_id": ... ,
      "title": ... ,
      "info": { ... }
   },
   {
      "series_id": ...,
      "title": ...,
      "info": { ... }
   },
    ...
]
```

{% note info %}

Атрибуты `series_id` и `title` используются в качестве значений атрибутов первичного ключа таблицы `Series`, остальные данные хранятся в атрибуте `info`.

{% endnote %}

В коде ниже показано, как хранятся данные о сериалах в формате JSON:

```json
[
  {
    "series_id": 1,
    "title": "IT Crowd",
    "info": {
      "release_date": "2006-02-03T00:00:00Z",
      "series_info": "The IT Crowd is a British sitcom produced by Channel 4, written by Graham Linehan, produced by Ash Atalla and starring Chris O'Dowd, Richard Ayoade, Katherine Parkinson, and Matt Berry."
    }
  },
  {
    "series_id": 2,
    "title": "Silicon Valley",
    "info": {
      "release_date": "2014-04-06T00:00:00Z",
      "series_info": "Silicon Valley is an American comedy television series created by Mike Judge, John Altschuler and Dave Krinsky. The series focuses on five young men who founded a startup company in Silicon Valley."
    }
  }
]
```

{% endcut %}

## Подготовка набора данных {#prepare-data}

Создайте в вашем текущем каталоге файл `seriesdata.json` и скопируйте в него следующий код:

```json
[
  {
    "series_id": 1,
    "title": "IT Crowd",
    "info": {
      "release_date": "2006-02-03T00:00:00Z",
      "series_info": "The IT Crowd is a British sitcom produced by Channel 4, written by Graham Linehan, produced by Ash Atalla and starring Chris O'Dowd, Richard Ayoade, Katherine Parkinson, and Matt Berry"
    }
  },
  {
    "series_id": 2,
    "title": "Silicon Valley",
    "info": {
      "release_date": "2014-04-06T00:00:00Z",
      "series_info": "Silicon Valley is an American comedy television series created by Mike Judge, John Altschuler and Dave Krinsky. The series focuses on five young men who founded a startup company in Silicon Valley"
    }
  },
  {
    "series_id": 3,
    "title": "House of Cards",
    "info": {
      "release_date": "2013-02-01T00:00:00Z",
      "series_info": "House of Cards is an American political thriller streaming television series created by Beau Willimon. It is an adaptation of the 1990 BBC miniseries of the same name and based on the 1989 novel of the same name by Michael Dobbs"
    }
  },
  {
    "series_id": 3,
    "title": "The Office",
    "info": {
      "release_date": "2005-03-24T00:00:00Z",
      "series_info": "The Office is an American mockumentary sitcom television series that depicts the everyday work lives of office employees in the Scranton, Pennsylvania, branch of the fictional Dunder Mifflin Paper Company"
    }
  },
  {
    "series_id": 3,
    "title": "True Detective",
    "info": {
      "release_date": "2014-01-12T00:00:00Z",
      "series_info": "True Detective is an American anthology crime drama television series created and written by Nic Pizzolatto. The series, broadcast by the premium cable network HBO in the United States, premiered on January 12, 2014"
    }
  },
  {
    "series_id": 4,
    "title": "The Big Bang Theory",
    "info": {
      "release_date": "2007-09-24T00:00:00Z",
      "series_info": "The Big Bang Theory is an American television sitcom created by Chuck Lorre and Bill Prady, both of whom served as executive producers on the series, along with Steven Molaro"
    }
  },
  {
    "series_id": 5,
    "title": "Twin Peaks",
    "info": {
      "release_date": "1990-04-08T00:00:00Z",
      "series_info": "Twin Peaks is an American mystery horror drama television series created by Mark Frost and David Lynch that premiered on April 8, 1990, on ABC until its cancellation after its second season in 1991 before returning as a limited series in 2017 on Showtime"
    }
  }
]
```

## Загрузка данных в таблицу {#load-into-table}

Чтобы загрузить образец данных в таблицу `Series`:

{% list tabs %}

- Python

  1. Создайте файл `SeriesLoadData.py` и скопируйте в него следующий код:

      ```python
      from decimal import Decimal
      import json
      import boto3

      def load_series(series):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<эндпойнт базы данных>")

          table = ydb_docapi_client.Table('Series')
          for serie in series:
              series_id = int(serie['series_id'])
              title = serie['title']
              print("Добавлен сериал:", series_id, title)
              table.put_item(Item = serie)

      if __name__ == '__main__':
          with open("seriesdata.json") as json_file:
              serie_list = json.load(json_file, parse_float = Decimal)
          load_series(serie_list)
      ```

  1. Запустите программу:
      
      ```bash
      python SeriesLoadData.py
      ```

      Результат выполнения:

      ```bash
      Добавлен сериал: 1 IT Crowd
      Добавлен сериал: 2 Silicon Valley
      ```

{% endlist %}
