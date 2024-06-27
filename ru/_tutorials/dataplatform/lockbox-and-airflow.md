# Хранение подключений и переменных {{ AF }} в {{ lockbox-full-name }}

При работе с {{ maf-full-name }} вы можете использовать [{{ lockbox-full-name }}](../../lockbox/index.yaml) для хранения подключений, переменных и конфигурационных данных, которые используются в DAG-файлах. {{ lockbox-name }} интегрируется в {{ maf-short-name }} через провайдер [{{ lockbox-name }} Secret Backend](https://airflow.apache.org/docs/apache-airflow-providers-yandex/stable/secrets-backends/yandex-cloud-lockbox-secret-backend.html). В результате доступ к хранилищу секретов настраивается автоматически.

Ниже рассматривается [направленный ациклический граф (DAG)](../../managed-airflow/concepts/index.md#about-the-service), выполняющий SQL-запрос `SELECT 1;` к БД в кластере {{ mpg-full-name }}. Данные для подключения к БД хранятся в {{ lockbox-name }} и автоматически подставляются в граф.

Чтобы использовать конфигурационные данные из секрета {{ lockbox-name }} в графе:

1. [Подготовьте инфраструктуру](#create-infrastracture).
1. [Создайте секрет {{ lockbox-name }}](#create-lockbox-secret).
1. [Подготовьте DAG-файл и запустите граф](#dag).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note info %}

Сервис {{ maf-name }} находится на стадии [Preview](../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

## Подготовьте инфраструктуру {#create-infrastracture}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) `airflow-sa` с ролями:

   * `managed-airflow.integrationProvider`;
   * `lockbox.payloadViewer`.

   {% note info }

   Роль `lockbox.payloadViewer` не обязательно выдавать на весь каталог. Достаточно [назначить ее на конкретный секрет {{ lockbox-name }}](../../lockbox/operations/secret-access.md) после [его создания](#create-lockbox-secret).

   {% endnote %}

1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md) для сервисного аккаунта. Сохраните его идентификатор и секретный ключ.

1. [Создайте бакет {{ objstorage-name }}](../../storage/operations/buckets/create.md) с произвольными настройками.

1. [Создайте кластер {{ maf-name }}](../../managed-airflow/operations/cluster-create.md#create-cluster) с параметрами:

   * **Сервисный аккаунт** — `airflow-sa`;
   * **Имя бакета** — имя созданного бакета;
   * **Идентификатор ключа** и **секретный ключ** — принадлежат статическому ключу доступа.

1. [Создайте кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md#create-cluster) с параметрами:

   * **Имя БД** — `db1`;
   * **Имя пользователя** — `user1`;
   * **Пароль** — `user1-password`.

## Создайте секрет {{ lockbox-full-name }} {#create-lockbox-secret}

Для корректной работы кластера {{ AF }} секрет в {{ lockbox-name }} должен иметь название в формате `airflow/<тип_секрета>/<идентификатор_секрета>`, где:
   * `<тип_секрета>` — тип хранимого секрета. Доступны следующие типы:
     * `connections` — подключения;
     * `variables` — переменные;
     * `config` — данные конфигурации.
   * `<идентификатор_секрета>` — идентификатор, который будет использован для обращения к секрету {{ lockbox-name }} в {{ AF }}.

[Создайте секрет {{ lockbox-name }}](../../lockbox/operations/secret-create.md) с параметрами:

   * **Имя** — `airflow/connections/pg`;
   * **Значение** — укажите следующее содержимое:
      ```
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

Подробнее о том, как узнать FQDN хоста кластера {{ PG }}, см. в [документации](https://yandex.cloud/ru/docs/managed-postgresql/operations/connect#fqdn).

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

1. [Откройте веб-интерфейс {{ AF }}](../../managed-airflow/operations/af-interfaces.md#web-gui).

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

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).
1. [Бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
1. [Секрет {{ lockbox-name }}](../../lockbox/operations/secret-delete.md).
1. [Кластер {{ maf-name }}](../../managed-airflow/operations/cluster-delete.md#delete).
1. [Кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md#delete).
