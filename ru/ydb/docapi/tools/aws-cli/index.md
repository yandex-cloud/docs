---
title: Работа с AWS CLI. Обзор
description: 'В разделе описано, как с использованием AWS CLI выполнить cоздание, добавление, чтение и обновление данных в таблице. Приведены примеры выполнения простых запросов.'
sourcePath: overlay/quickstart/document-api/aws-cli/index.md
---

# Обзор

В разделе описано, как с использованием AWS CLI выполнить следующие операции в YDB:

* [Создание](create-table.md) таблицы.
* [Добавление](put-item.md), [чтение](get-item.md) и [обновление](update-item.md) данных в таблице.
* [Выполнение](query.md) простых запросов.

## Перед началом работы {#before-you-begin}

1. [Настройте окружение AWS](../aws-setup.md).
1. Подготовьте Document API эндпоинт [созданной БД](../../../operations/manage-database.md#create-db).

    {% cut "Как узнать Document API эндпоинт базы данных" %}

    1. Перейдите в [консоль управления]({{ link-console-main }}).
    1. Выберите нужный каталог и перейдите в сервис **{{ ydb-full-name }}**.
    1. Выберите базу данных, к которой планируете сделать запрос.
    1. В меню слева перейдите в раздел **Обзор**.
    1. Значение эндпоинта указано в строке **Document API эндпоинт**.

        Пример значения эндпоинта:

        ```text
        https://docapi.serverless.yandexcloud.net/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj
        ```

    {% endcut %}

    {% note info %}

    Для работы в режиме совместимости с Amazon DynamoDB используйте бессерверную (Serverless) конфигурацию БД.

    {% endnote %}
