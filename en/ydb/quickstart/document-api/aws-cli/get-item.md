# Reading data from a table

To read data from the `series` table:

{% list tabs %}

- AWS CLI

    Run the command below replacing `https://your-database-endpoint` with the endpoint of your DB:

    {% note warning %}

    To run the AWS CLI in Windows, we recommend using [WSL]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/windows/wsl/){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/windows/wsl/){% endif %}.

    {% endnote %}

    ```bash
    endpoint="https://your-database-endpoint"
    aws dynamodb get-item --consistent-read \
        --table-name series \
        --key '{"series_id": {"N": "1"}, "title": {"S": "IT Crowd"}}' \
        --endpoint $endpoint
    ```

   Execution result:

    ```text
    {
        "Item": {
            "series_id": {
                "N": ".1e1"
            },
            "title": {
                "S": "IT Crowd"
            },
            "release_date": {
                "S": "2006-02-03"
            },
            "series_info": {
                "S": "The IT Crowd is a British sitcom produced by Channel 4, written by Graham Linehan, produced by Ash Atalla and starring Chris ODowd, Richard Ayoade, Katherine Parkinson, and Matt Berry."
            }
        }
    }
    ```

{% endlist %}
