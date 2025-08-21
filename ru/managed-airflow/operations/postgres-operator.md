---
title: Подключение к {{ mpg-full-name }}
description: С помощью направленного ациклического графа (DAG) можно настроить подключение к БД в кластере {{ mpg-full-name }}.
---

# Подключение к {{ mpg-full-name }}

С помощью [направленного ациклического графа (DAG)](../concepts/index.md#about-the-service) можно настроить подключение к БД в кластере {{ mpg-full-name }}. Данные для подключения к БД хранятся в {{ lockbox-name }} и автоматически подставляются в граф.

{% note tip %}

По умолчанию используется провайдер `apache-airflow-providers-postgres` версии 5.13.1. Если вы работаете с более новой версией провайдера, вместо PostgresOperator используйте SQLExecuteQueryOperator. Подробнее см. в [официальной документации](https://airflow.apache.org/docs/apache-airflow-providers-postgres/6.0.0/operators/postgres_operator_howto_guide.html).

{% endnote %}

## Перед началом работы {#before-begin}

1. [Создайте кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md#create-cluster) с параметрами:
   * **Имя БД** — `db1`;
   * **Имя пользователя** — `user1`;
   * **Пароль** — `user1-password`.

1. [Создайте бакет](../../storage/operations/buckets/create.md) {{ objstorage-full-name }}, в котором будет храниться DAG-файл.

1. [Настройте кластер {{ maf-name }}](cluster-update.md):

   1. Включите опцию **{{ ui-key.yacloud.airflow.field_lockbox }}**, которая позволяет использовать секреты в сервисе [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../concepts/impersonation.md#lockbox-integration) {{ AF }}.

   1. В блоке **{{ ui-key.yacloud.airflow.section_storage }}** выберите созданный ранее бакет {{ objstorage-name }}. Из него будет загружен DAG-файл.

1. Выдайте своему сервисному аккаунту [роль](../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.

   {% note info }

   Роль `lockbox.payloadViewer` не обязательно выдавать на весь каталог. Достаточно [назначить ее на конкретный секрет {{ lockbox-name }}](../../lockbox/operations/secret-access.md) после [его создания](#create-lockbox-secret).

   {% endnote %}

## Создайте секрет {{ lockbox-full-name }} {#create-lockbox-secret}

Для корректной работы кластера {{ AF }} секрет в {{ lockbox-name }} должен иметь имя в формате `airflow/<тип_артефакта>/<идентификатор_артефакта>`, где:
   * `<тип_артефакта>` — определяет, какие данные будут храниться в секрете. Возможные значения:
     * `connections` — подключения;
     * `variables` — переменные;
     * `config` — данные конфигурации.
   * `<идентификатор_артефакта>` — идентификатор, который будет использован для обращения к артефакту в {{ AF }}.

[Создайте секрет {{ lockbox-name }}](../../lockbox/operations/secret-create.md) с параметрами:
   * **{{ ui-key.yacloud.common.name }}** — `airflow/connections/pg1`.
   * **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}** — `Пользовательский`.
   * **{{ ui-key.yacloud.lockbox.forms.label_key }}** — `conn`.
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

Подробнее о том, как узнать FQDN хоста кластера {{ PG }}, см. в разделе [{#T}](../../managed-postgresql/operations/connect.md#fqdn).

В секрете будут сохранены данные для подключения к БД в кластере {{ mpg-name }}.

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `postgres_operator.py` и скопируйте в него скрипт:

   ```python
   from airflow import DAG
   from airflow.providers.postgres.operators.postgres import PostgresOperator


   with DAG(
       dag_id='postgres_operator',
       schedule=None
   ):
       PostgresOperator(
           task_id="check_conn",
           postgres_conn_id='pg1',
           sql="SELECT 1;"
       )
   ```

1. Загрузите DAG-файл `postgres_operator.py` в созданный ранее бакет.
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
1. Убедитесь, что в логах есть строка `Rows affected: 1`. Это значит, что запрос выполнен успешно.
