# Начало работы с AWS SDK

В этом разделе описано, как с помощью AWS SDK написать простые программы на нескольких языках программирования, которые выполняют следующие операции в {{ ydb-short-name }}:

- [Создание](create-table.md) таблицы c информацией о сериалах и [загрузка](load-data.md) в нее данных в формате JSON.

- Управление записями в таблице: [добавление](create-item.md), [чтение](read-item.md), [обновление](update-item.md) и [удаление](delete-item.md) данных.

- [Выполнение](query-and-scan.md) простых запросов.

- [Удаление](delete-table.md) таблицы.

## Перед началом работы {#before-you-begin}

1. [Создайте](../create_manage_database.md#create-db) базу данных.
1. Настройте [инструменты AWS](../../quickstart/aws-instrument/setup.md).

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
