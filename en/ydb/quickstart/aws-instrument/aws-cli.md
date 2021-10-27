# Working with the AWS CLI

After you [set up the parameters](setup.md) to work with the AWS SDK, try to perform operations with a table via the AWS CLI.

## Creating a table {#create}

To create a table, run the command:

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

This creates a table named `series` with the series ID, title, info, and release date columns. The series ID is used as the primary key column:

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

## Viewing table information {#get}

To view information about the `series` table, run the command:

```bash
aws dynamodb describe-table \
--table-name series \
--endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87bmaomkfvsleds/etn02uhup7vprrt9lc3u
```

Command results:

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

## Viewing a list of tables {#list}

To view a list of tables, run the command:

```bash
aws dynamodb list-tables \
--endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87bmaomkfvsleds/etn02uhup7vprrt9lc3u
```

Command results:

```bash
{
  "TableNames": [
      "series"
  ]
}
```

## Deleting a table {#delete}

{% note warning %}

Deleting a table is an irreversible operation.

{% endnote %}

To delete the `series` table, run the command:

```bash
aws dynamodb delete-table \
--table-name series \
--endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87bmaomkfvsleds/etn02uhup7vprrt9lc3u
```

Command results:

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

