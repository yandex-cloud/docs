# Обзор

В разделе приведены описания команд {{ ydb-short-name }} CLI, а также примеры их использования для выполнения следующих операций в БД:

* [{#T}](scheme-ls.md).
* [{#T}](scheme-describe.md).
* [{#T}](discovery-list.md).
* [{#T}](query.md).
* [{#T}](readtable.md).
* [{#T}](operations-index.md).
* [{#T}](scheme-mkdir.md).

Перед выполнением примеров:

1. [Создайте]{% if audience == "external" %}(../../operations/create_manage_database.md#create-db){% else %}(https://cloud.yandex.ru/docs/ydb/operations/create_manage_database#create-db){% endif %}
 базу данных.
1. [Создайте]{% if audience == "external" %}(../../yql/tutorial/create_demo_tables.md){% else %}(https://cloud.yandex.ru/docs/ydb/yql/tutorial/create_demo_tables){% endif %}
 таблицу и [добавьте]{% if audience == "external" %}(../../yql/tutorial/fill_tables_with_data.md){% else %}(https://cloud.yandex.ru/docs/ydb/yql/tutorial/fill_tables_with_data){% endif %}
 в нее данные.
1. [Установите](../install.md) {{ ydb-short-name }} CLI.
1. [Настройте](../profile/create.md) профиль {{ ydb-short-name }} CLI.
