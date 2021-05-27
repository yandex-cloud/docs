# Обзор

В этом разделе описано, как с помощью AWS SDK написать простые программы на нескольких языках программирования, которые выполняют следующие операции в {{ ydb-short-name }}:

- [Создание](create-table.md) таблицы c информацией о сериалах и [загрузка](load-data.md) в нее данных в формате JSON.

- Управление записями в таблице: [добавление](create-item.md), [чтение](read-item.md), [обновление](update-item.md) и [удаление](delete-item.md) данных.

- [Выполнение](query-and-scan.md) простых запросов.

- [Удаление](delete-table.md) таблицы.

## Перед началом работы {#before-you-begin}

1. [Настройте окружение AWS](../aws-setup.md).
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

- Python

  1. [Установите](https://www.python.org/downloads/) Python версии 3.6 и выше.
  1. Установите библиотеку Boto3:

      ```
      pip install boto3
      ```

      Подробнее об AWS SDK for Python (Boto) читайте в [документации AWS](https://aws.amazon.com/ru/sdk-for-python/).

{% endlist %}
