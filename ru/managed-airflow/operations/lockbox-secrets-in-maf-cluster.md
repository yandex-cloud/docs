---
title: Хранение подключений {{ AF }} в {{ lockbox-full-name }}
description: 'При работе с {{ maf-full-name }} вы можете использовать {{ lockbox-full-name }} для хранения артефактов, которые могут использоваться в DAG-файлах: подключений, переменных и конфигурационных данных. С помощью направленного ациклического графа (DAG) можно выполнить загрузку подключения из {{ lockbox-name }} и SQL-запрос к БД в кластере {{ mpg-full-name }}.'
---

# Хранение подключений {{ AF }} в {{ lockbox-full-name }}

При работе с {{ maf-full-name }} вы можете использовать [{{ lockbox-full-name }}](../../lockbox/index.yaml) для хранения артефактов, которые могут использоваться в DAG-файлах: подключений, переменных и конфигурационных данных. {{ lockbox-name }} интегрируется в {{ maf-short-name }} через провайдер [{{ lockbox-name }} Secret Backend](https://airflow.apache.org/docs/apache-airflow-providers-yandex/stable/secrets-backends/yandex-cloud-lockbox-secret-backend.html). В результате доступ к хранилищу секретов настраивается автоматически.

С помощью [направленного ациклического графа (DAG)](../concepts/index.md#about-the-service) можно выполнить загрузку подключения из {{ lockbox-name }} и SQL-запрос `SELECT 1;` к БД в кластере {{ mpg-full-name }}. Данные для подключения к БД хранятся в {{ lockbox-name }} и автоматически подставляются в граф.

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

Для корректной работы кластера {{ AF }} секрет в {{ lockbox-name }} должен иметь имя в формате `airflow/<тип_артефакта>/<идентификатор_артефакта>`, где:
   * `<тип_артефакта>` — тип артефакта, который будет храниться в секрете. Доступны следующие типы:
     * `connections` — подключения;
     * `variables` — переменные;
     * `config` — данные конфигурации.
   * `<идентификатор_артефакта>` — идентификатор, который будет использован для обращения к артефакту в {{ AF }}.

[Создайте секрет {{ lockbox-name }}](../../lockbox/operations/secret-create.md) с параметрами:
   * **{{ ui-key.yacloud.common.name }}** — `airflow/connections/pg`.
   * **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}** — `Пользовательский`.
   * **{{ ui-key.yacloud.lockbox.forms.label_key }}** — `airflow/connections/pg`.
   * **{{ ui-key.yacloud.lockbox.forms.label_value }}** — выберите **{{ ui-key.yacloud.lockbox.forms.value_payload-entry-value-type-text }}** и укажите следующее содержимое:

      ```json
      {
        "conn_type": "postgres",
        "host": "<FQDN_хоста_кластера_{{ PG }}>",
        "port": {{ port-mpg }},
        "schema": "db1",
        "login": "user1",
        "password": "user1-password"
      }
      ```

В секрете будут сохранены данные для подключения к БД в кластере {{ mpg-name }}.

Подробнее о том, как узнать FQDN хоста кластера {{ PG }}, см. в разделе [{#T}](../../managed-postgresql/operations/connect.md#fqdn).

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `test_lockbox_connection.py` и скопируйте в него скрипт:

   ```python
   from airflow import DAG
   from airflow.providers.postgres.operators.postgres import PostgresOperator
   from datetime import datetime

   with DAG(
     dag_id='test_lockbox_connection',
     start_date=datetime(2024, 4, 19),
     schedule="@once",
     catchup=False,
   ) as dag:
     check_conn = PostgresOperator(
         task_id="check_conn",
         postgres_conn_id='pg',
         sql="SELECT 1;",
     )
   ```

1. Загрузите DAG-файл `test_lockbox_connection.py` в созданный ранее бакет. В результате одноименный граф появится в веб-интерфейсе {{ AF }} автоматически.
1. [Откройте веб-интерфейс {{ AF }}](af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый граф `test_lockbox_connection`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе {{ AF }}:

1. В разделе **DAGs** откройте граф `test_lockbox_connection`.
1. Перейдите в раздел **Graph**.
1. Выберите задание **check_conn**.
1. Перейдите в раздел **Logs**.
1. Убедитесь, что в логах есть строка `Rows affected: 1`. Это значит, что запрос выполнен успешно.


