# Подключение к Yandex Managed Service for ClickHouse®

С помощью [направленного ациклического графа (DAG)](../concepts/index.md#about-the-service) можно настроить подключение к БД в кластере Yandex Managed Service for ClickHouse®. Данные для подключения к БД хранятся в Yandex Lockbox и автоматически подставляются в граф.

## Перед началом работы {#before-begin}

1. [Создайте кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-create.md) с параметрами:
   * **Имя БД** — `default-bd`;
   * **Имя пользователя** — `admin`;
   * **Пароль** — `admin-password`.

   {% note warning %}

   Создание базы данных с именем `default` запрещено.

   {% endnote %}

1. [Создайте бакет](../../storage/operations/buckets/create.md) Yandex Object Storage, в котором будет храниться DAG-файл.

1. [Настройте кластер Managed Service for Apache Airflow™](cluster-update.md):

   1. Включите опцию **Использовать Lockbox Secret Backend**, которая позволяет использовать секреты в сервисе [Yandex Lockbox](../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../concepts/impersonation.md#lockbox-integration) Apache Airflow™.
   1. В блоке **Зависимости** добавьте pip-пакет `airflow-clickhouse-plugin`.
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
   * **Имя** — `airflow/connections/ch`.
   * **Тип секрета** — `Пользовательский`.
   * **Ключ** — `conn`.
   * **Значение** — выберите **Текст** и укажите следующее содержимое:

      ```json
      {
        "conn_type": "clickhouse",
        "host": "<FQDN_хоста_кластера_ClickHouse®>",
        "port": 9440,
        "schema": "default-bd",
        "login": "admin",
        "password": "admin-password",
        "extra": {
            "secure": "True"
        }
      }
      ```

Подробнее о том, как узнать FQDN хоста кластера ClickHouse®, читайте в разделе [FQDN хостов ClickHouse®](../../managed-clickhouse/operations/connect/fqdn.md).

В секрете будут сохранены данные для подключения к БД в кластере Managed Service for ClickHouse®.

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `clickhouse.py` и скопируйте в него скрипт:

   ```python
   from airflow.decorators import dag, task
   from airflow_clickhouse_plugin.hooks.clickhouse import ClickHouseHook


   @dag(schedule=None)
   def clickhouse():
       @task
       def query_clickhouse():
           ch_hook = ClickHouseHook(clickhouse_conn_id="ch")
           result = ch_hook.execute('select 1;')
           print(f'query result: {result}')

       query_clickhouse()


   clickhouse()
   
   ```

1. Загрузите DAG-файл `clickhouse.py` в созданный ранее бакет.
1. [Откройте веб-интерфейс Apache Airflow™](af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **Dags** появился новый граф `clickhouse`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе Apache Airflow™:

{% list tabs group=instructions %}
   
- Версия Apache Airflow™ ниже 3.0 {#version-2}

  1. В разделе **DAGs** откройте граф `clickhouse`.
  1. Перейдите в раздел **Graph**.
  1. Выберите задание **query_clickhouse**.
  1. Перейдите в раздел **Logs**.
  1. Убедитесь, что в логах есть строка `query result: [(1,)]`. Это значит, что запрос выполнен успешно.

- Версия Apache Airflow™ 3.0 и выше {#version-3}

  1. В разделе **Dags** нажмите на граф `clickhouse`.
  1. Перейдите в раздел **Tasks**.
  1. Выберите задание **query_clickhouse**.
  1. Перейдите в раздел **Task Instances**.
  1. Выберите экземпляр задания.
  1. Откроется раздел **Logs**.
  1. Убедитесь, что в логах есть строка `query result: [(1,)]`. Это значит, что запрос выполнен успешно.

{% endlist %}

## Решение возможных проблем {#troubleshooting}

* [Как исправить ошибку `SSLCertVerificationError: [SSL: CERTIFICATE_VERIFY_FAILED]`?](../qa/index.md#airflow-clickhouse-ssl)
* [Как исправить ошибку `No module named 'airflow_clickhouse_plugin'`?](../qa/index.md#airflow-clickhouse-plugin)