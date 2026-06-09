# Подключение к Yandex Managed Service for PostgreSQL

С помощью [направленного ациклического графа (DAG)](../concepts/index.md#about-the-service) можно настроить подключение к БД в кластере Yandex Managed Service for PostgreSQL. Данные для подключения к БД хранятся в Yandex Lockbox и автоматически подставляются в граф.

{% note tip %}

В кластерах с версией Apache Airflow™ ниже 3.0 по умолчанию используется провайдер `apache-airflow-providers-postgres` версии 5.13.1. Если вы работаете с более новой версией провайдера, вместо PostgresOperator используйте SQLExecuteQueryOperator. Подробнее см. в [официальной документации](https://airflow.apache.org/docs/apache-airflow-providers-postgres/6.0.0/operators/postgres_operator_howto_guide.html).

{% endnote %}

## Перед началом работы {#before-begin}

1. [Создайте кластер Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-create.md#create-cluster) с параметрами:
   * **Имя БД** — `db1`;
   * **Имя пользователя** — `user1`;
   * **Пароль** — `user1-password`.

1. [Создайте бакет](../../storage/operations/buckets/create.md) Yandex Object Storage, в котором будет храниться DAG-файл.

1. [Настройте кластер Managed Service for Apache Airflow™](cluster-update.md):

   1. Включите опцию **Использовать Lockbox Secret Backend**, которая позволяет использовать секреты в сервисе [Yandex Lockbox](../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../concepts/impersonation.md#lockbox-integration) Apache Airflow™.
   1. В блоке **Зависимости** добавьте pip-пакет `apache-airflow-providers-postgres`.

      {% note warning %}

      Установка pip-пакета необходима для кластеров с версией Apache Airflow™ 3.0 и выше. В кластерах с версией Apache Airflow™ ниже 3.0 pip-пакет установлен по умолчанию.

      {% endnote %}
      
   1. В блоке **Хранилище DAG-файлов** выберите созданный ранее бакет Object Storage. Из него будет загружен DAG-файл.

1. Выдайте своему сервисному аккаунту [роль](../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.

   {% note info %}

   Роль `lockbox.payloadViewer` не обязательно выдавать на весь каталог. Достаточно [назначить ее на конкретный секрет Yandex Lockbox](../../lockbox/operations/secret-access.md) после [его создания](#create-lockbox-secret).

   {% endnote %}

## Создайте секрет Yandex Lockbox {#create-lockbox-secret}

Для корректной работы кластера Apache Airflow™ секрет в Yandex Lockbox должен иметь имя в формате `airflow/<тип_артефакта>/<идентификатор_артефакта>`, где:
   * `<тип_артефакта>` — определяет, какие данные будут храниться в секрете. Возможные значения:
     * `connections` — подключения;
     * `variables` — переменные;
     * `config` — данные конфигурации.
   * `<идентификатор_артефакта>` — идентификатор, который будет использоваться для обращения к артефакту в Apache Airflow™.

[Создайте секрет Yandex Lockbox](../../lockbox/operations/secret-create.md) с параметрами:
   * **Имя** — `airflow/connections/pg1`.
   * **Тип секрета** — `Пользовательский`.
   * **Ключ** — `conn`.
   * **Значение** — выберите **Текст** и укажите следующее содержимое:

      ```json
      {
        "conn_type": "postgres",
        "host": "<FQDN_хоста_кластера_PostgreSQL>",
        "port": 6432,
        "schema": "db1",
        "login": "user1",
        "password": "user1-password"
      }
      ```

Подробнее о том, как узнать FQDN хоста кластера PostgreSQL, читайте в разделе [FQDN хостов PostgreSQL](../../managed-postgresql/operations/connect/fqdn.md).

В секрете будут сохранены данные для подключения к БД в кластере Managed Service for PostgreSQL.

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `postgres_operator.py` и скопируйте в него скрипт:

   {% list tabs group=instructions %}
   
   - Версия Apache Airflow™ ниже 3.0 {#version-2}
   
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
   
   - Версия Apache Airflow™ 3.0 и выше {#version-3}
   
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
1. [Откройте веб-интерфейс Apache Airflow™](af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **Dags** появился новый граф `postgres_operator`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе Apache Airflow™:

{% list tabs group=instructions %}
   
- Версия Apache Airflow™ ниже 3.0 {#version-2}

  1. В разделе **Dags** нажмите на граф `postgres_operator`.
  1. Перейдите в раздел **Graph**.
  1. Выберите задание **check_conn**.
  1. Перейдите в раздел **Logs**.
  1. Убедитесь, что в логах есть строка `Rows affected: 1`. Это значит, что запрос выполнен успешно.

- Версия Apache Airflow™ 3.0 и выше {#version-3}

  1. В разделе **Dags** нажмите на граф `postgres_operator`.
  1. Перейдите в раздел **Tasks**.
  1. Выберите задание **check_conn**.
  1. Перейдите в раздел **Task Instances**.
  1. Выберите экземпляр задания.
  1. Откроется раздел **Logs**.
  1. Убедитесь, что в логах есть строка `Rows affected: 1`. Это значит, что запрос выполнен успешно.

{% endlist %}

## Решение возможных проблем {#troubleshooting}

* [Как исправить ошибку `No module named 'airflow.providers.postgres.operators'`?](../qa/index.md#airflow-provider-postgres-operators)
* [Как исправить ошибку `AirflowException: Unknown hook type "postgres"`?](../qa/index.md#airflow-provider-postgres-operators-2)