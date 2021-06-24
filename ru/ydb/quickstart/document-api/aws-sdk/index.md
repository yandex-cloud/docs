---
title: Работа с AWS SDK. Обзор
description: 'В этом разделе описано, как с помощью AWS SDKнаписать простые программы, которые выполняют некоторые операции c YDB. Примеры приведены для нескольких языков программирования.'
---

# Обзор

В этом разделе описано, как с помощью AWS SDK для нескольких языков программирования написать простые программы, которые выполняют следующие операции в {{ ydb-short-name }}:

* [Создание](create-table.md) таблицы и [загрузка](load-data.md) в нее данных в формате JSON.
* Управление записями в таблице: [добавление](create-item.md), [чтение](read-item.md), [обновление](update-item.md) и [удаление](delete-item.md) данных.
* [Поиск и извлечение](query-and-scan.md) данных.
* [Удаление](delete-table.md) таблицы.

## Перед началом работы {#before-you-begin}

1. {% if deploy != "arc" %}[Настройте окружение AWS](../aws-setup.md){% else %}Настройте окружение AWS{% endif %}.
1. Подготовьте Document API эндпоинт [созданной БД](../../create-db.md).

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

## Настройка окружения {#environment-set}

Настройте окружение для вашего языка программирования:

{% list tabs %}

- Java

  В примерах раздела для сборки приложений Java используется [Apache Maven](https://maven.apache.org/).

  Подробнее об AWS SDK для Java читайте в [документации AWS](https://aws.amazon.com/ru/sdk-for-java/).

- Python

  1. [Установите](https://www.python.org/downloads/) Python версии 3.6 и выше.
  1. Установите библиотеку Boto3:

      ```bash
      pip install boto3
      ```

      Подробнее об AWS SDK for Python (Boto) читайте в [документации AWS](https://aws.amazon.com/ru/sdk-for-python/).

- PHP

  1. Установите [PHP](https://www.php.net/).
  1. Настройте [AWS SDK для PHP](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/getting-started_installation.html).

  Подробнее об AWS SDK for PHP читайте в [документации AWS](https://aws.amazon.com/ru/sdk-for-php/).

{% endlist %}
