# Creating a table

To create a table named `series` with `series_id` as the partition key and `title` as the sort key:

{% list tabs %}

- AWS CLI

    Run the command below replacing `https://your-database-endpoint` with the endpoint of your DB:

    {% note warning %}

    To run the AWS CLI in Windows, we recommend using [WSL]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/windows/wsl/){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/windows/wsl/){% endif %}.

    {% endnote %}

    ```bash
    endpoint="https://your-database-endpoint"
    aws dynamodb create-table \
        --table-name series \
        --attribute-definitions \
          AttributeName=series_id,AttributeType=N \
          AttributeName=title,AttributeType=S \
        --key-schema \
          AttributeName=series_id,KeyType=HASH \
          AttributeName=title,KeyType=RANGE \
        --endpoint $endpoint
    ```

    Execution result:

    ```text
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
                }
            ],
            "TableName": "series",
            "KeySchema": [
                {
                    "AttributeName": "series_id",
                    "KeyType": "HASH"
                },
                {
                    "AttributeName": "title",
                    "KeyType": "RANGE"
                }
            ],
            "TableStatus": "ACTIVE",
            "CreationDateTime": "2020-12-27T13:21:10+00:00",
            "TableSizeBytes": 0,
            "ItemCount": 0
        }
    }
    ```

{% endlist %}
