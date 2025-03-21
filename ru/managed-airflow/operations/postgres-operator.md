---
title: Подключение к {{ mpg-full-name }}
description: С помощью направленного ациклического графа (DAG) можно настроить подключение к БД в кластере {{ mpg-full-name }}.
---

# Подключение к {{ mpg-full-name }}

С помощью [направленного ациклического графа (DAG)](../concepts/index.md#about-the-service) можно настроить подключение к БД в кластере {{ mpg-full-name }}. Данные для подключения к БД хранятся в {{ lockbox-name }} и автоматически подставляются в граф.

## Перед началом работы {#before-begin}

1. [Создайте кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md#create-cluster) с параметрами:
   * **Имя БД** — `db1`;
   * **Имя пользователя** — `user1`;
   * **Пароль** — `user1-password`.

1. Выдайте своему сервисному аккаунту [роль](../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.

   {% note info }

   Роль `lockbox.payloadViewer` не обязательно выдавать на весь каталог. Достаточно [назначить ее на конкретный секрет {{ lockbox-name }}](../../lockbox/operations/secret-access.md) после [его создания](#create-lockbox-secret).

   {% endnote %}

## Создайте секрет {{ lockbox-full-name }} {#create-lockbox-secret}

[Создайте секрет {{ lockbox-name }}](../../lockbox/operations/secret-create.md) с именем `airflow/connections/pg1` и содержимым `json.dumps(conn)`, где `conn` — подключение к кластеру {{ mpg-name }}.

```json
conn = {
         "conn_type": "postgres",
         "host": "<FQDN_хоста_кластера_{{ PG }}>",
         "port": 6432,
         "schema": "db1",
         "login": "user1",
         "password": "user1-password"
}
```

В секрете `airflow/connections/pg1` будут сохранены данные для подключения к БД в кластере {{ mpg-name }}.

Подробнее о том, как узнать FQDN хоста кластера {{ PG }}, см. в разделе [{#T}](../../managed-postgresql/operations/connect.md#fqdn).

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `postgres_operator.py` и скопируйте в него скрипт:

   ```python
   from airflow import DAG
   from airflow.providers.postgres.operators.postgres import PostgresOperator


   with DAG(
       dag_id='postgres_operator',
       schedule=None,
   ):
       PostgresOperator(
           task_id="check_conn",
           postgres_conn_id='pg1',
           sql="SELECT 3;",
       )
   ```

1. Загрузите DAG-файл `postgres_operator.py` в созданный ранее бакет. В результате одноименный граф появится в веб-интерфейсе {{ AF }} автоматически.
1. [Откройте веб-интерфейс {{ AF }}](af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый граф `postgres_operator`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе {{ AF }}:

1. В разделе **DAGs** откройте граф `postgres_operator`.
1. Перейдите в раздел **Graph**.
1. Выберите задание **check_conn**.
1. Перейдите в раздел **Logs**.
1. Убедитесь, что в логах есть строка `Rows affected: 3`. Это значит, что запрос выполнен успешно.
