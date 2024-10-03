---
title: Работа с AWS SDK. Обзор
description: В этом разделе описано, как с помощью AWS SDK написать простые программы, которые выполняют некоторые операции c YDB. Примеры приведены для нескольких языков программирования.
sourcePath: overlay/quickstart/document-api/aws-sdk/index.md
---

# Работа с AWS SDK в {{ ydb-name }}. Обзор

В этом разделе описано, как с помощью AWS SDK для нескольких языков программирования написать простые программы, которые выполняют следующие операции в {{ ydb-short-name }}:
* [Создание](create-table.md) таблицы и [загрузка](load-data.md) в нее данных в формате JSON.
* Управление записями в таблице: [добавление](create-item.md), [чтение](read-item.md), [обновление](update-item.md) и [удаление](delete-item.md) данных.
* [Поиск и извлечение](query-and-scan.md) данных.
* [Удаление](delete-table.md) таблицы.

## Перед началом работы {#before-you-begin}

1. [Настройте окружение AWS](../aws-setup.md).
1. Подготовьте Document API эндпоинт [созданной БД](../../../operations/manage-databases.md).

   {% cut "Как узнать Document API эндпоинт базы данных" %}

   1. Перейдите в [консоль управления]({{ link-console-main }}).
   1. Выберите нужный каталог и перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Выберите БД, к которой планируете сделать запрос.
   1. В меню слева перейдите в раздел **{{ ui-key.yacloud.ydb.database.switch_overview }}**.
   1. Значение эндпоинта указано в строке **{{ ui-key.yacloud.ydb.overview.label_document-endpoint }}**.

      >Пример значения эндпоинта:
      >
      >```text
      >{{ ydb.aws-ep }}
      >```

   {% endcut %}

   {% note info %}

   Для работы в режиме совместимости с Amazon DynamoDB используйте бессерверную (Serverless) конфигурацию БД.

   {% endnote %}

## Настройка окружения {#environment-set}

Настройте окружение для вашего языка программирования:

{% list tabs group=programming_language %}

- Java {#java}

  В примерах раздела для сборки приложений Java используется [Apache Maven](https://maven.apache.org/).

  Подробнее об AWS SDK для Java читайте в [документации AWS](https://aws.amazon.com/ru/sdk-for-java/).

- Python {#python}

  1. [Установите](https://www.python.org/downloads/) Python версии 3.8 и выше.
  1. Установите библиотеку Boto3:

     ```bash
     pip install boto3
     ```

     Подробнее об AWS SDK for Python (Boto) читайте в [документации AWS](https://aws.amazon.com/ru/sdk-for-python/).

- PHP {#php}

  1. Установите [PHP](https://www.php.net/).
  1. Настройте [AWS SDK для PHP](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/getting-started_installation.html).

  Подробнее об AWS SDK for PHP читайте в [документации AWS](https://aws.amazon.com/ru/sdk-for-php/).

- Node.js {#node}

  1. Установите [Node.js](https://nodejs.org/ru/).
  1. Установите [AWS SDK for Node.js](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/getting-started-nodejs.html).

  Подробнее об AWS SDK для Node.js читайте в [документации](https://aws.amazon.com/ru/sdk-for-node-js/).

- Ruby {#ruby}

  1. Установите [Ruby](https://www.ruby-lang.org/ru/documentation/installation/).
  1. Установите [AWS SDK for Ruby](https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/setup-install.html).

  Подробнее об AWS SDK для Ruby читайте в [документации](https://aws.amazon.com/ru/sdk-for-ruby/).

{% endlist %}
