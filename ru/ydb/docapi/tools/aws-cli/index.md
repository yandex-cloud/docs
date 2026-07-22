---
title: Работа с AWS CLI. Обзор
description: В разделе описано, как с использованием AWS CLI выполнить создание, добавление, чтение и обновление данных в таблице. Приведены примеры выполнения простых запросов.
---

# Работа с AWS CLI в {{ ydb-name }}. Обзор

В разделе описано, как с использованием AWS CLI выполнить следующие операции в {{ ydb-short-name }}:
* [Создание](create-table.md) таблицы.
* [Добавление](put-item.md), [чтение](get-item.md) и [обновление](update-item.md) данных в таблице.
* [Выполнение](query.md) простых запросов.

## Перед началом работы {#before-you-begin}

1. [Настройте окружение AWS](../aws-setup.md).
1. Подготовьте Document API эндпоинт [созданной БД](../../../operations/manage-databases.md).

   {% cut "Как узнать Document API эндпоинт базы данных" %}

   1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
   1. [Перейдите]({{ link-console-main }}/link/ydb) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
   1. Выберите БД, к которой планируете сделать запрос.
   1. В меню слева перейдите в раздел **{{ ui-key.yacloud.common.overview }}**.
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