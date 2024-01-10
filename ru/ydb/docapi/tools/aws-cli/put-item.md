---
title: "Как добавить данные в таблицу в {{ ydb-full-name }}"
description: "Следуя данной инструкции, вы сможете добавить данные в таблицу." 
---

# Добавление данных в таблицу

Чтобы добавить две записи в таблицу `series`:

{% list tabs group=instructions %}

* AWS CLI {#cli}

    Выполните команды, заменив `https://your-database-endpoint` [подготовленным ранее Document API эндпоинтом](index.md#before-you-begin) вашей БД:

    {% note warning %}

    Для работы с AWS CLI из Windows рекомендуется использовать [WSL]({{ ms.docs }}/windows/wsl/).

    {% endnote %}

    ```bash
    endpoint="https://your-database-endpoint"
    aws dynamodb put-item \
        --table-name series \
        --item '{"series_id": {"N": "1"}, "title": {"S": "IT Crowd"}, "series_info": {"S": "The IT Crowd is a British sitcom produced by Channel 4, written by Graham Linehan, produced by Ash Atalla and starring Chris ODowd, Richard Ayoade, Katherine Parkinson, and Matt Berry."}, "release_date": {"S": "2006-02-03"}}' \
        --endpoint $endpoint
    ```

    и

    ```bash
    endpoint="https://your-database-endpoint"
    aws dynamodb put-item \
        --table-name series \
        --item '{"series_id": {"N": "2"}, "title": {"S": "Silicon Valley"}, "series_info": {"S": "Silicon Valley is an American comedy television series created by Mike Judge, John Altschuler and Dave Krinsky."}, "release_date": {"S": "2014-04-06"}}' \
        --endpoint $endpoint
    ```

{% endlist %}
