[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Spark™](../index.md) > [Практические руководства](index.md) > Использование секрета Yandex Lockbox в PySpark-задании для подключения к Yandex Managed Service for PostgreSQL

# Использование секрета Yandex Lockbox в PySpark-задании для подключения к Yandex Managed Service for PostgreSQL

# Использование секрета Yandex Lockbox в PySpark-задании для подключения к Yandex Managed Service for PostgreSQL

Вы можете использовать секрет [Yandex Lockbox](../../lockbox/concepts/secret.md) для подключения к кластеру [Yandex Managed Service for PostgreSQL](../../managed-postgresql/index.md) из PySpark-задания в [Yandex Managed Service for Apache Spark™](../index.md). Для этого [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) кластера Yandex Managed Service for Apache Spark™ необходимо предоставить доступ к секрету. Секрет создается сервисом Yandex Connection Manager автоматически при создании пользователя Managed Service for PostgreSQL.

Для PySpark-задания используется Python-скрипт, который хранится в бакете Yandex Object Storage. Скрипт получает пароль пользователя из секрета и использует его для подключения к кластеру Managed Service for PostgreSQL.

Чтобы получить информацию из секрета и подключиться к кластеру Managed Service for PostgreSQL, выполните следующие действия:

1. [Подготовьте инфраструктуру](#infra).
1. [Настройте права доступа к секрету пользователя](#set-up-roles).
1. [Подготовьте PySpark-задание](#prepare-a-job).
1. [Запустите задание и проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for Apache Spark™: выделенные хостам вычислительные ресурсы ([тарифы Managed Service for Apache Spark™](../pricing.md)).
* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for PostgreSQL](../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Бакет Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).

Использование секретов Yandex Lockbox, созданных с помощью Connection Manager, не тарифицируется.


## Подготовьте инфраструктуру {#infra}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) `spark-agent` и назначьте ему роли:
  
    * [managed-spark.integrationProvider](../security.md#managed-spark-integrationProvider) — для взаимодействия Yandex Managed Service for Apache Spark™ с другими сервисами;
    * [storage.editor](../../storage/security/index.md#storage-editor) — для доступа к файлу с PySpark-заданием в бакете Object Storage.
  
1. [Создайте бакет](../../storage/operations/buckets/create.md). 
1. [Предоставьте разрешение](../../storage/operations/buckets/edit-acl.md) `READ` для сервисного аккаунта `spark-agent` на созданный бакет.

1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `spark-network`.

    Вместе с ней автоматически будут созданы три подсети в разных зонах доступности.

1. В сети `spark-network` [создайте группу безопасности](../../vpc/operations/security-group-create.md) `spark-sg` для кластера Yandex Managed Service for Apache Spark™, разрешающую исходящие TCP-подключения:
    
    * на порт `6432` для подключения к PostgreSQL;
    * на порт `443` для скачивания Maven-пакетов.

1. В сети `spark-network` создайте группу безопасности `pg-sg` для кластера Managed Service for PostgreSQL, разрешающую входящие TCP-подключения на порт `6432`.

1. [Создайте кластер Yandex Managed Service for Apache Spark™](../operations/cluster-create.md) со следующими настройками:

    * **Сервисный аккаунт** — `spark-agent`.
    * **Сеть** — `spark-network`.
    * **Группа безопасности** — `spark-sg`.

1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подсети, в которой создан кластер Yandex Managed Service for Apache Spark™. NAT-шлюз нужен для скачивания JDBC-драйвера PostgreSQL из Maven-репозитория.

1. [Создайте кластер Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-create.md) со следующими настройками:

    * **Сеть** — `spark-network`.
    * **Группа безопасности** — `pg-sg`.

## Настройте права доступа к секрету пользователя Managed Service for PostgreSQL {#set-up-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором создана необходимая инфраструктура.
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Пользователи**.
  1. Нажмите на идентификатор подключения в строке нужного пользователя.
    
      Откроется страница подключения Connection Manager для выбранного пользователя.
  
  1. На открывшейся странице нажмите на идентификатор секрета.

      Откроется страница секрета Yandex Lockbox, который хранит пароль пользователя PostgreSQL.

  1. На панели слева выберите раздел ![image](../../_assets/console-icons/persons.svg) **Права доступа** и нажмите кнопку **Назначить роли**.
  1. Выберите сервисный аккаунт `spark-agent`, которому будет предоставлен доступ к секрету.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите `lockbox.payloadViewer`.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы настроить права доступа к секрету пользователя Managed Service for PostgreSQL:
  
  1. Получите идентификатор секрета из подключения Connection Manager:

      ```bash
      yc metadata-hub connection-manager connection list \
        --mdb-cluster-id <идентификатор_кластера_PostgreSQL>
      ```

      Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-postgresql/operations/cluster-list.md).
  
  1. Настройте права доступа к секрету пользователя:

      ```bash
      yc lockbox secret add-access-binding <идентификатор_секрета> \
        --role lockbox.payloadViewer \
        --service-account-name spark-agent 
      ```

      Сервисному аккаунту `spark-agent` будет предоставлен доступ к секрету пользователя Managed Service for PostgreSQL.

{% endlist %}

## Подготовьте PySpark-задание {#prepare-a-job}

1. Создайте локально файл с именем `job-mpg-connection-with-secret.py` и скопируйте в него скрипт:

    {% cut "job-mpg-connection-with-secret.py" %}

    ```python
    import json
    import os
    import urllib.request
    from pyspark.sql import SparkSession
    
    def get_secret(secret_id: str) -> dict:
        """Получение секрета из Yandex Lockbox."""
        # Получение IAM-токена через metadata service
        metadata_host = os.environ.get("YC_METADATA_ADDR", "169.254.169.254")
        token_url = f"http://{metadata_host}/computeMetadata/v1/instance/service-accounts/default/token"
    
        req = urllib.request.Request(token_url)
        req.add_header("Metadata-Flavor", "Google")
        with urllib.request.urlopen(req, timeout=10) as resp:
            token = json.loads(resp.read())["access_token"]
    
        # Получение секрета Yandex Lockbox
        secret_url = f"https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/{secret_id}/payload"
        req = urllib.request.Request(secret_url)
        req.add_header("Authorization", f"Bearer {token}")
        with urllib.request.urlopen(req, timeout=30) as resp:
            payload = json.loads(resp.read())
            return {e["key"]: e["textValue"] for e in payload["entries"]}
    
    
    # Использование функции получения секрета
    secrets = get_secret("<идентификатор_секрета>")
    
    # Инициализация Spark сессии
    spark = SparkSession.builder.appName("db-reader").getOrCreate()
    
    # Подключение к кластеру Managed Service for PostgreSQL
    df = spark.read \
        .format("jdbc") \
        .option("url", f"jdbc:postgresql://<FQDN_хоста>:6432/<имя_БД>") \
        .option("driver", "org.postgresql.Driver") \
        .option("user", "<имя_пользователя>") \
        .option("password", secrets["postgresql_password"]) \
        .option("dbtable", "<имя_таблицы>") \
        .load()
    
    # Вывод первых 20 строк таблицы
    df.show()
    ```

    {% endcut %}

1. Укажите в файле скрипта следующие параметры:
    
    * идентификатор секрета;
    * [FQDN хоста](../../managed-postgresql/operations/connect/fqdn.md) для подключения к кластеру Managed Service for PostgreSQL;
    * имя базы данных;
    * имя таблицы.

## Запустите задание и проверьте результат {#check-out}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Загрузите в бакет](../../storage/operations/objects/upload.md#simple) файл `job-mpg-connection-with-secret.py`.
  1. В кластере Yandex Managed Service for Apache Spark™ [создайте задание](../operations/jobs-pyspark.md) со следующими параметрами:
      
      * **Тип задания** — **PySpark**.
      * **Main python файл** – `s3a://<имя_бакета>/job-mpg-connection-with-secret.py`.
      * **Пакеты** — `org.postgresql:postgresql:42.7.3`.

  1. Дождитесь, когда созданное PySpark-задание перейдет в статус **Done**.
  1. [Получите логи выполнения задания](../operations/jobs-pyspark.md#get-logs).

      В логах задания будет показан вывод строк таблицы, указанной в скрипте.

- CLI {#cli}
  
  1. Загрузите в бакет файл `job-mpg-connection-with-secret.py`:

      ```bash
      yc storage s3api put-object \
        --body <путь_к_локальному_файлу> \
        --bucket <имя_бакета> \
        --key "job-mpg-connection-with-secret.py"
      ```
  
  1. Запустите задание:

      ```bash
      yc managed-spark job create-pyspark \
        --cluster-id <идентификатор_кластера> \
        --name "<имя_задания>" \
        --main-python-file-uri s3a://<имя_бакета>/job-mpg-connection-with-secret.py \
        --packages org.postgresql:postgresql:42.7.3
      ```

      Идентификатор кластера можно получить со [списком кластеров в каталоге](../operations/cluster-list.md#list-clusters).

      Команда вернет идентификатор задания. Сохраните его, он понадобится для получения логов выполнения задания.

  1. Получите логи выполнения задания:

      ```bash
      yc managed-spark job log <идентификатор_задания> \
        --cluster-id <идентификатор_кластера>
      ```

      В логах задания будет показан вывод строк таблицы, указанной в скрипте.

{% endlist %}
 
## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Кластер Yandex Managed Service for Apache Spark™](../operations/cluster-delete.md).
1. [Кластер Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-delete.md).
1. [Бакет Object Storage](../../storage/operations/buckets/delete.md). Перед удалением бакета [удалите из него все объекты](../../storage/operations/objects/delete.md).
1. [NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).