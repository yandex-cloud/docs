# Data selections

To select data from the `series` table by the `series_id` key:

{% list tabs %}

- AWS CLI

    Run the command by replacing `https://your-database-endpoint` with the endpoint of your DB:

    {% note warning %}

    To work with the AWS CLI from Windows, we recommend using the [WSL]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/windows/wsl/){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/windows/wsl/){% endif %}.

    {% endnote %}

    ```bash
    endpoint="https://your-database-endpoint"
    aws dynamodb query \
        --table-name series \
        --key-condition-expression "series_id = :name" \
        --expression-attribute-values '{":name":{"N":"2"}}' \
        --endpoint $endpoint
    ```

   Output:

    ```text
    {
        "Items": [
            {
                "series_id": {
                    "N": ".2e1"
                },
                "title": {
                    "S": "Silicon Valley"
                },
                "release_date": {
                    "S": "2014-04-06"
                },
                "series_info": {
                    "S": "Silicon Valley is an American comedy television series created by Mike Judge, John Altschuler and Dave Krinsky. The series focuses on five young men who founded a startup company in Silicon Valley."
                }
            }
        ],
        "Count": 1,
        "ScannedCount": 1,
        "ConsumedCapacity": null
    }
    ```

{% endlist %}
