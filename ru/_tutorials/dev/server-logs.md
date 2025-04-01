

Получите статистику запросов к объектам {{ objstorage-name }} с помощью языка запросов [S3 Select](../../storage/concepts/s3-select-language.md).

{% note info %}

Чтобы получить информацию о запросах к объектам, [включите механизм логирования](../../storage/operations/buckets/enable-logging.md#enable).

{% endnote %}

## Перед началом работы {#before-you-begin}

1. Установите и настройте интерфейс командной строки [AWS CLI](../../storage/tools/aws-cli.md).
1. Скачайте и установите утилиту [jq](https://stedolan.github.io/jq/download/).

## Получение статистики запросов {#request-stat}

{% list tabs group=programming_language %}

- Bash {#bash}

  1. Выполните запрос в {{ objstorage-name }} и сохраните результат выполнения в файл:

     1. Для удобства работы сохраните:

        * Имя бакета, в котором хранится объект с логами, в переменную `$bucket`:

          ```bash
          bucket=<имя_бакета>
          ```

        * [Ключ](../../storage/concepts/object.md#key) объекта с логами в переменную `$key`:

          ```bash
          key=<ключ_объекта>
          ```

        * Выражение для запроса данных объекта на языке S3 Select в переменную `$query`:

          ```bash
          query='<выражение_для_запроса>'
          ```

          Примеры выражений:

          * Поиск запросов по коду ответа:

            ```sql
            SELECT "timestamp", request_id, handler, object_key, status, request_time
            FROM S3Object
            WHERE status >= 400
            ```

          * Поиск долго обрабатываемых запросов:

            ```sql
            SELECT "timestamp", request_id, handler, object_key, status, request_time
            FROM S3Object
            WHERE request_time >= 1000
            ```

          * Среднее время обработки запросов (с использованием [агрегатной функции](../../storage/concepts/s3-select-language.md#aggregate-functions) `AVG`):

            ```sql
            SELECT AVG(request_time) AS "avg" FROM S3Object
            ```

     1. Выполните команду:

        ```bash
        aws --endpoint https://{{ s3-storage-host }} s3api select-object-content \
          --bucket $bucket \
          --key $key \
          --expression "$query" \
          --expression-type 'SQL' \
          --input-serialization 'JSON={Type=LINES}' \
          --output-serialization 'JSON={}' \
          "output.json"
        ```

  1. Если в запросе не использовались агрегатные функции, выведите количество запросов для каждого ключа объекта. Для этого выполните агрегирующий запрос при помощи утилиты `jq`:

     ```bash
     jq .object_key output.json | uniq -c | sort -nr
     ```

     Результат:

     ```bash
     9 "path/logs/2021-02-10-22-02-25-199f57b5-5601-3210-5d9a-1apl1e5z6b4f"
     7 "path/logs/2021-01-28-11-40-11-580g57b5-9903-1108-6a7a-1ghj1e0e8b0f"
     3 "path/logs/2020-12-09-10-05-31-123f57b5-1853-4120-8d7a-5bcc1e9e9b4f"
     1 "path/logs/2020-12-09-08-11-10-123f57b5-1773-9310-1d2a-5bcc1e9e9b4f"
     1 "path/logs/2020-12-01-14-42-11-493f57b5-1093-4120-8d7a-5bcc1e9e9b4f"
     ```

{% endlist %}
