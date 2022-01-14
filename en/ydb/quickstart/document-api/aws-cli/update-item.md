# Updating data

To update the data in the `series` table:

{% list tabs %}

- AWS CLI

    Run the command below replacing `https://your-database-endpoint` with the endpoint of your DB:

    {% note warning %}

    To run the AWS CLI in Windows, we recommend using  [WSL]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/windows/wsl/){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/windows/wsl/){% endif %}.

    {% endnote %}

    ```bash
    endpoint="https://your-database-endpoint"
    aws dynamodb update-item \
        --table-name series \
        --key '{"series_id": {"N": "2"}, "title": {"S": "Silicon Valley"}}' \
        --update-expression "SET series_info = :newval" \
        --expression-attribute-values '{":newval":{"S":"Silicon Valley is an American comedy television series created by Mike Judge, John Altschuler and Dave Krinsky. The series focuses on five young men who founded a startup company in Silicon Valley."}}' \
        --return-values ALL_NEW \
        --endpoint $endpoint
    ```

    Execution result:

    ```text
    {
        "Attributes": {
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
    }
    ```

{% endlist %}
