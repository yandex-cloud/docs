# Настройка AWS CLI и AWS SDK

Для работы с базой через Document API в режиме совместимости с AWS DynamoDB вы можете использовать инструменты от AWS:
* [AWS CLI](https://aws.amazon.com/ru/cli/) — интерфейс командной строки AWS.
* [AWS SDK](https://aws.amazon.com/ru/tools/#sdk) — инструменты для разработки. 
 
Для корректной работы инструментов AWS необходимо настроить следующие параметры:
* [aws_access_key_id](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-aws_access_key_id.html);
* [aws_secret_access_key](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-aws_secret_access_key.html);
* [region](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-region.html).

## Настройка параметров {#setup}

1. Создайте сервисный аккаунт, от имени которого вы будете работать с базой.

    Сервисный аккаунт должен быть создан в том же каталоге, в котором располагается база данных.
    
    {% list tabs %}
    
    - Консоль управления
    
      {% include [create-sa-via-console](../../_includes/iam/create-sa-via-console.md) %}
    
    - CLI
    
      {% include [default-catalogue](../../_includes/default-catalogue.md) %}
    
      1. Посмотрите описание команды создания сервисного аккаунта:
    
          ```
          $ yc iam service-account create --help
          ```
    
      2. Создайте сервисный аккаунт с именем `my-robot`:
    
          ```
          $ yc iam service-account create --name my-robot
          ```
    
          {% include [name-format](../../_includes/name-format.md) %}
    
    - API
    
      Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md).
    
    {% endlist %}
    
1. Назначьте сервисному аккаунту роль `editor`.
    
    {% include [grant-role-for-sa](../../_includes/iam/grant-role-for-sa.md) %}
    
1. Получите статические ключи доступа `aws_access_key_id` и `aws_secret_access_key`.

    {% list tabs %}
    
    - Консоль управления
    
      1. Перейдите в каталог, которому принадлежит сервисный аккаунт.
      1. Выберите вкладку **Сервисные аккаунты**.
      1. Выберите сервисный аккаунт и нажмите на строку с его именем.
      1. Нажмите кнопку **Создать новый ключ** на верхней панели.
      1. Выберите пункт **Создать ключ доступа**.
      1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
      1. Сохраните идентификатор и секретный ключ.
    
          {% note alert %}
    
          После закрытия диалога значение ключа будет недоступно.
    
          {% endnote %}
    
    - CLI
    
      {% include [default-catalogue](../../_includes/default-catalogue.md) %}
    
      1. Посмотрите описание команды создания статического ключа доступа:
    
          ```
          $ yc iam access-key create --help
          ```
    
      1. Выберите сервисный аккаунт, например `my-robot`:
    
          ```
          $ yc iam service-account list
          +----------------------+------------------+-------------------------------+
          |          ID          |       NAME       |          DESCRIPTION          |
          +----------------------+------------------+-------------------------------+
          | aje6o61dvog2h6g9a33s | my-robot         |                               |
          | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
          +----------------------+------------------+-------------------------------+
          ```
      1. Создайте ключ доступа для сервисного аккаунта `my-robot`:
    
          ```
          $ yc iam access-key create --service-account-name my-robot
    
          access_key:
            id: aje6t3vsbj8lp9r4vk2u
            service_account_id: ajepg0mjt06siuj65usm
            created_at: "2018-11-22T14:37:51Z"
            key_id: 0n8X6WY6S24N7OjXQ0YQ
          secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9hxtzMP1
          ```
      1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.
    
    - API
    
      Чтобы создать ключ доступа, воспользуйтесь методом [create](../../iam/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../iam/api-ref/AccessKey/index.md).
    
    {% endlist %}
     
1. Установите [AWS CLI](https://aws.amazon.com/ru/cli/). 
1. Настройте [окружение](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html). Один из самых простых способов настройки — запуск `aws configure`. В качестве ключей используйте значения, полученные выше. Для региона используйте `ru-central1`:

    ```
    $ aws configure
    AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
    AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
    Default region name [None]: ru-central1
    Default output format [None]:
    ```
    
    В результате будут созданы файлы `~/.aws/credentials` и `~/.aws/config` (`C:\Users\USERNAME\.aws\credentials` и `C:\Users\USERNAME\.aws\config` в Windows). 
1. Проверьте корректность настройки, запустив команду листинга таблиц в базе. В качестве значения `--endpoint` укажите Document API эндпоинт, доступный на вкладке **Обзор** вашей базы данных в [консоли управления]({{ link-console-main }}).

    ```
    $ aws dynamodb list-tables --endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1g4ej5ju4rf5kelpk4b/etn03ubijq52j860kvgj
    {
        "TableNames": [
        ]
    }
    ```

## Примеры {#examples}

{% list tabs %}

* AWS CLI

  **Создание таблицы**

  Чтобы создать таблицу, выполните команду:

  ```bash
  aws dynamodb create-table \
    --table-name series \
    --attribute-definitions \
        AttributeName=series_id,AttributeType=N \
        AttributeName=title,AttributeType=S \
        AttributeName=series_info,AttributeType=S \
        AttributeName=release_date,AttributeType=N \
    --key-schema \
        AttributeName=series_id,KeyType=HASH \
    --endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87bmaomkfvsleds/etn02uhup7vprrt9lc3u
  ```

  В результате будет создана таблица c именем `series`, с колонками для идентификатора, названия, аннотации и даты выхода сериала, с первичным ключом по колонке идентификатора:

  ```bash
  {
      "TableDescription": {
          "AttributeDefinitions": [
              {
                  "AttributeName": "series_id",
                  "AttributeType": "N"
              },
              {
                  "AttributeName": "title",
                  "AttributeType": "S"
              },
              {
                  "AttributeName": "series_info",
                  "AttributeType": "S"
              },
              {
                  "AttributeName": "release_date",
                  "AttributeType": "N"
              }
          ],
          "TableName": "series",
          "KeySchema": [
              {
                  "AttributeName": "series_id",
                  "KeyType": "HASH"
              }
          ],
          "TableStatus": "ACTIVE",
          "CreationDateTime": "2020-12-26T13:48:36+00:00",
          "TableSizeBytes": 0,
          "ItemCount": 0
      }
  }
  ```

  **Просмотр информаци о таблице**

  Чтобы просмотреть информацию о таблице с именем `series`, выполните команду:

  ```bash
  aws dynamodb describe-table \
    --table-name series \
    --endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87bmaomkfvsleds/etn02uhup7vprrt9lc3u

  ```

  Результат команды:

  ```bash
  {
      "Table": {
          "AttributeDefinitions": [
              {
                  "AttributeName": "title",
                  "AttributeType": "S"
              },
              {
                  "AttributeName": "series_info",
                  "AttributeType": "S"
              },
              {
                  "AttributeName": "release_date",
                  "AttributeType": "N"
              },
              {
                  "AttributeName": "series_id",
                  "AttributeType": "N"
              }
          ],
          "TableName": "series",
          "KeySchema": [
              {
                  "AttributeName": "series_id",
                  "KeyType": "HASH"
              }
          ],
          "TableStatus": "ACTIVE",
          "CreationDateTime": "2020-12-26T13:48:36+00:00",
          "TableSizeBytes": 0,
          "ItemCount": 0
      }
  }
  ```

  **Просмотр списка таблиц**

  Чтобы просмотреть список таблиц, выполните команду:

  ```bash
  aws dynamodb list-tables \
    --endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87bmaomkfvsleds/etn02uhup7vprrt9lc3u
  ```

  Результат команды:

  ```bash
  {
      "TableNames": [
          "series"
      ]
  }
  ```

  **Удаление таблицы**

  {% note warning %}

  Удаление таблицы — это необратимая операция.

  {% endnote %}

  Чтобы удалить таблицу c именем `series`, выполните команду:

  ```bash
  aws dynamodb delete-table \
    --table-name series \
    --endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87bmaomkfvsleds/etn02uhup7vprrt9lc3u
  ```

  Результат команды:

  ```bash
  {
      "TableDescription": {
          "AttributeDefinitions": [
              {
                  "AttributeName": "title",
                  "AttributeType": "S"
              },
              {
                  "AttributeName": "series_info",
                  "AttributeType": "S"
              },
              {
                  "AttributeName": "release_date",
                  "AttributeType": "N"
              },
              {
                  "AttributeName": "series_id",
                  "AttributeType": "N"
              }
          ],
          "TableName": "series",
          "KeySchema": [
              {
                  "AttributeName": "series_id",
                  "KeyType": "HASH"
              }
          ],
          "TableStatus": "ACTIVE",
          "CreationDateTime": "2020-12-26T13:48:36+00:00",
          "TableSizeBytes": 0,
          "ItemCount": 0
      }
  }
  ```

* AWS SDK (Python)

  **Создание таблицы**

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

  **Добавление записи**

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

  2. Для запуска программы выполните команду:

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

  **Чтение записи**

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


  2. Для запуска программы выполните команду:

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

  **Удаление таблицы**

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

  2. Для запуска программы выполните команду:

      ```
      python SeriesDeleteTable.py
      ``` 

      Результат выполнения:

      ```
      Таблица Series удалена
      ```

{% endlist %}
