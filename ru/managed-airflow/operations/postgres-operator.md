---
title: Подключение к {{ mpg-full-name }}
description: С помощью направленного ациклического графа (DAG) можно настроить подключение к БД в кластере {{ mpg-full-name }}.
---

# Подключение к {{ mpg-full-name }}

С помощью [направленного ациклического графа (DAG)](../concepts/index.md#about-the-service) можно настроить подключение к БД в кластере {{ mpg-full-name }}. Данные для подключения к БД хранятся в {{ lockbox-name }} и автоматически подставляются в граф.

{% include [postgres-new-version](../../_includes/mdb/maf/postgres-new-version.md) %}

## Перед началом работы {#before-begin}

1. [Создайте кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md#create-cluster) с параметрами:
   * **Имя БД** — `db1`;
   * **Имя пользователя** — `user1`;
   * **Пароль** — `user1-password`.

1. [Создайте бакет](../../storage/operations/buckets/create.md) {{ objstorage-full-name }}, в котором будет храниться DAG-файл.

1. [Настройте кластер {{ maf-name }}](cluster-update.md):

   1. Включите опцию **{{ ui-key.yacloud.airflow.field_lockbox }}**, которая позволяет использовать секреты в сервисе [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../concepts/impersonation.md#lockbox-integration) {{ AF }}.
   1. В блоке **{{ ui-key.yacloud.mdb.forms.section_dependencies }}** добавьте pip-пакет `apache-airflow-providers-postgres`.

      {% note warning %}
      
      Установка pip-пакета необходима для кластеров с версией {{ AF }} 3.0 и выше. В кластерах с версией {{ AF }} ниже 3.0 pip-пакет установлен по умолчанию.
      
      {% endnote %}
      
   1. В блоке **{{ ui-key.yacloud.airflow.section_storage }}** выберите созданный ранее бакет {{ objstorage-name }}. Из него будет загружен DAG-файл.

1. Выдайте своему сервисному аккаунту [роль](../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.

   {% note info }

   Роль `lockbox.payloadViewer` не обязательно выдавать на весь каталог. Достаточно [назначить ее на конкретный секрет {{ lockbox-name }}](../../lockbox/operations/secret-access.md) после [его создания](#create-lockbox-secret).

   {% endnote %}

## Создайте секрет {{ lockbox-full-name }} {#create-lockbox-secret}

{% include [lockbox-description](../../_includes/mdb/maf/lockbox-description.md) %}

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

   {% list tabs group=instructions %}
   
   - Версия {{ AF }} ниже 3.0 {#version-2}
   
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
   
   - Версия {{ AF }} 3.0 и выше {#version-3}
   
     ```python
     from airflow import DAG
     from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator


     with DAG(
         dag_id='postgres_operator',
         schedule=None
     ):
         SQLExecuteQueryOperator(
             task_id="check_conn",
             conn_id='pg1',
             sql="SELECT 1;"
         )
     ```
   
   {% endlist %}

1. Загрузите DAG-файл `postgres_operator.py` в созданный ранее бакет.
1. [Откройте веб-интерфейс {{ AF }}](af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **Dags** появился новый граф `postgres_operator`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе {{ AF }}:

{% list tabs group=instructions %}
   
- Версия {{ AF }} ниже 3.0 {#version-2}

  1. В разделе **Dags** нажмите на граф `postgres_operator`.
  1. Перейдите в раздел **Graph**.
  1. Выберите задание **check_conn**.
  1. Перейдите в раздел **Logs**.
  1. Убедитесь, что в логах есть строка `Rows affected: 1`. Это значит, что запрос выполнен успешно.

- Версия {{ AF }} 3.0 и выше {#version-3}

  1. В разделе **Dags** нажмите на граф `postgres_operator`.
  1. Перейдите в раздел **Tasks**.
  1. Выберите задание **check_conn**.
  1. Перейдите в раздел **Task Instances**.
  1. Выберите экземпляр задания.
  1. Откроется раздел **Logs**.
  1. Убедитесь, что в логах есть строка `Rows affected: 1`. Это значит, что запрос выполнен успешно.

{% endlist %}
