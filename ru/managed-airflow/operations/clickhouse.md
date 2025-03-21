---
title: Подключение к {{ mch-full-name }}
description: С помощью направленного ациклического графа (DAG) можно настроить подключение к БД в кластере {{ mch-full-name }}.
---

# Подключение к {{ mch-full-name }}

С помощью [направленного ациклического графа (DAG)](../concepts/index.md#about-the-service) можно настроить подключение к БД в кластере {{ mch-full-name }}. Данные для подключения к БД хранятся в {{ lockbox-name }} и автоматически подставляются в граф.

## Перед началом работы {#before-begin}

1. [Создайте кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) с параметрами:
   * **Имя БД** — `default`;
   * **Имя пользователя** — `admin`;
   * **Пароль** — `admin-password`.

1. Выдайте своему сервисному аккаунту [роль](../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.

   {% note info }

   Роль `lockbox.payloadViewer` не обязательно выдавать на весь каталог. Достаточно [назначить ее на конкретный секрет {{ lockbox-name }}](../../lockbox/operations/secret-access.md) после [его создания](#create-lockbox-secret).

   {% endnote %}

## Создайте секрет {{ lockbox-full-name }} {#create-lockbox-secret}

[Создайте секрет {{ lockbox-name }}](../../lockbox/operations/secret-create.md) с именем `airflow/connections/ch1` и содержимым `json.dumps(conn)`, где `conn` — подключение к кластеру {{ mch-name }}. В качестве значения `conn_type` укажите `SQLite` или другую БД SQL.

```json
conn = {
         "conn_type": "SQLite",
         "host": "<FQDN_хоста_кластера_{{ CH }}>",
         "port": 9440,
         "schema": "default",
         "login": "admin",
         "password": "admin-password",
         "extra": {
             "secure": True,
         }
}
```
В секрете будут сохранены данные для подключения к БД в кластере {{ mch-name }}.

Подробнее о том, как узнать FQDN хоста кластера {{ CH }}, см. в разделе [{#T}](../../managed-clickhouse/operations/connect/fqdn.md).

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `clickhouse.py` и скопируйте в него скрипт:

   ```python
   from airflow.decorators import dag, task
   from airflow_clickhouse_plugin.hooks.clickhouse import ClickHouseHook


   @dag(schedule=None)
   def clickhouse():
       @task
       def query_clickhouse():
           ch_hook = ClickHouseHook(clickhouse_conn_id="ch1")
           result = ch_hook.execute('select 1;')
           print(f'query result: {result}')

       query_clickhouse()


   clickhouse()
   ```

1. Загрузите DAG-файл `clickhouse.py` в созданный ранее бакет. В результате одноименный граф появится в веб-интерфейсе {{ AF }} автоматически.
1. [Откройте веб-интерфейс {{ AF }}](af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый граф `clickhouse`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе {{ AF }}:

1. В разделе **DAGs** откройте граф `clickhouse`.
1. Перейдите в раздел **Graph**.
1. Выберите задание **query_clickhouse**.
1. Перейдите в раздел **Logs**.
1. Убедитесь, что в логах есть строка `query result: 1`. Это значит, что запрос выполнен успешно.
