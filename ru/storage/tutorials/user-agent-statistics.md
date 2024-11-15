---
title: Статистика посещения сайта браузерами
description: Следуя данному руководству, вы сможете получить статистику посещения сайта браузерами.
---

# Статистика посещения сайта браузерами


Получите статистику запросов к объектам бакета, который настроен для [хостинга статического сайта](../concepts/hosting.md). Для получения данных будет использоваться язык запросов [S3 Select](../concepts/s3-select-language.md).

{% note info %}

Чтобы получить информацию о запросах, [включите механизм логирования](../operations/buckets/enable-logging.md#enable) для бакета, в котором находится содержимое сайта.

{% endnote %}

## Перед началом работы {#before-you-begin}

Установите и настройте интерфейс командной строки [AWS CLI](../tools/aws-cli.md).

## Получение статистики посещения {#session-stat}

{% list tabs group=programming_language %}

- Bash {#bash}

  1. Выполните запрос в {{ objstorage-name }} и сохраните результат выполнения в файл:

     1. Для удобства работы сохраните:

        * Имя бакета, в котором хранится объект с логами, в переменную `$bucket`:

          ```bash
          bucket=<имя_бакета>
          ```

        * [Ключ](../concepts/object.md#key) объекта с логами в переменную `$key`:

          ```bash
          key=<ключ_объекта>
          ```

        * Выражение для запроса данных на языке S3 Select в переменную `$query`:

          ```bash
          query="select user_agent from s3object"
          ```

     1. Выполните команду:

        ```bash
        aws --endpoint https://{{ s3-storage-host }} s3api select-object-content \
          --bucket $bucket \
          --key $key \
          --expression "$query" \
          --expression-type 'SQL' \
          --input-serialization 'JSON={Type=LINES}' \
          --output-serialization 'CSV={}' \
          "output.csv"
        ```

  1. Чтобы вывести количество посещений для каждой страницы, выполните агрегирующий запрос с помощью команд `sort` и `uniq`:

     ```bash
     sort -nr output.csv | uniq -c
     ```

     Результат:

     ```bash
     418 docker/19.03.9 go/go1.13.10 git-commit/1d238398e7 kernel/4.4.0-142-generic os/linux arch/amd64 UpstreamClient(Go-http-client/1.1)
     255 docker/19.03.13 go/go1.13.15 git-commit/4484c46d9d kernel/3.10.0-1127.19.1.el7 os/linux arch/amd64 UpstreamClient(Go-http-client/1.1)
     101 aws-sdk-java/1.11.424 Linux/4.14.74-28+yc7 OpenJDK_64-Bit_Server_VM/11.0.5-shenandoah+10-adhoc.heretic.src java/11.0.5-shenandoah
     17 aws-cli/1.18.27 Python/2.7.6 Linux/4.19.62-13 botocore/1.17.50
     ```

{% endlist %}
