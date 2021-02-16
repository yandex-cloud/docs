# Работа с AWS CLI

После того как вы [настроили параметры](setup.md) для работы с AWS SDK, попробуйте поработать с таблицей с помощью AWS CLI.

## Создание таблицы {#create}

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

## Просмотр информации о таблице {#get}

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

## Просмотр списка таблиц {#list}

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

## Удаление таблицы {#delete}

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
