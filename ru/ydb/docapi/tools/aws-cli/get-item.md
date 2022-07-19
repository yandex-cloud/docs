---
sourcePath: overlay/quickstart/document-api/aws-cli/get-item.md
---
# Чтение данных из таблицы

Чтобы прочитать данные из таблицы `series`:

{% list tabs %}

* AWS CLI

    Выполните команду, заменив `https://your-database-endpoint` [подготовленным ранее Document API эндпоинтом](index.md#before-you-begin) эндпоинтом вашей БД:

    {% note warning %}

    Для работы с AWS CLI из Windows рекомендуется использовать [WSL]({{ ms.docs }}/windows/wsl/).

    {% endnote %}

    ```bash
    endpoint="https://your-database-endpoint"
    aws dynamodb get-item --consistent-read \
        --table-name series \
        --key '{"series_id": {"N": "1"}, "title": {"S": "IT Crowd"}}' \
        --endpoint $endpoint
    ```

   Результат:

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
