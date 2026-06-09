# Решение проблем в {{ metastore-full-name }}

В этом разделе описаны проблемы, возникающие в сервисе, а также способы их устранения.

* [Ошибка при создании базы данных](#create-db-in-hive)
* [Отсутствие прав при подключении сервисного аккаунта к кластеру](#attach-service-account)
* [Блокировка таблиц Hive](#lock-tables)

## Ошибка при создании базы данных в {{ metastore-full-name }} {#create-db-in-hive}

Ошибка возникает, если создавать БД с помощью следующего запроса:

```sql
CREATE DATABASE IF NOT EXISTS <имя_БД>;
```

**Решение**
{{ metastore-name }} не позволяет создать базу данных или таблицу в Hive — они хранятся в [бакете {{ objstorage-full-name }}](../../storage/concepts/bucket.md), который привязан к кластеру {{ dataproc-name }}. Чтобы создать БД, выполните запрос:

```sql
CREATE DATABASE IF NOT EXISTS <имя_БД> LOCATION <местоположение_БД>;
```

В параметре `LOCATION` укажите путь до бакета и базы данных в нем в формате: `s3a://<имя_бакета>/<имя_папки>/<имя_БД>`. Указывать папку необязательно, но в нее объекты загружаются быстрее, чем в корень бакета.

## Отсутствие прав при подключении сервисного аккаунта к кластеру {#attach-service-account}

#### Как исправить ошибку отсутствия прав при подключении сервисного аккаунта к кластеру? {#attach-service-account}

Текст ошибки:

```text
ERROR: rpc error: code = PermissionDenied desc = you do not have permission to access the requested service account or service account does not exist
```

Ошибка возникает, если вы создаете или изменяете кластер и привязываете к нему сервисный аккаунт.

**Решение**
[Назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._

## Блокировка таблиц Hive {#lock-tables}

При работе с {{ metastore-full-name }} может произойти блокировка таблицы Hive, например, если прервать работу скрипта.

Для снятия блокировки можно использовать:
* thrift-интерфейс Hive Metastore;
* python-скрипт, который запускается в той же виртуальной частной сети (VPC), что и {{ metastore-name }}.

### Снятие блокировки с помощью python-скрипта {#unlock-tables-script}

{% note warning %}

{{ metastore-name }} доступен только по внутреннему IP-адресу в виртуальной частной сети (VPC) и не имеет публичного DNS-имени. Это обеспечивает дополнительную безопасность, но требует, чтобы все сервисы, подключающиеся к {{ metastore-name }}, находились в той же VPC или имели настроенный сетевой доступ.

{% endnote %}

Чтобы снять блокировку:

1. Подключитесь к виртуальной машине или сервису, который находится в той же VPC, что и {{ metastore-name }}.

1. Установите зависимости:

   ```bash
   pip install click
   pip install hive-metastore-client
   ```

1. Создайте файл с именем `unlock.py` и скопируйте в него скрипт:

   {% cut "unlock.py" %}

   ```python
   import click

   from hive_metastore_client import HiveMetastoreClient
   from thrift_files.libraries.thrift_hive_metastore_client.ttypes import ShowLocksRequest, UnlockRequest


   class MetastoreClient:
       def __init__(self, metastore_hostname, metastore_port):
           self.metastore_hostname = metastore_hostname
           self.metastore_port = metastore_port
           self.metastore_client = HiveMetastoreClient(metastore_hostname, metastore_port)

       def show_locks(self, db_name, table):
           with self.metastore_client as metastore_client:
               req = ShowLocksRequest(dbname=db_name, tablename=table)
               return metastore_client.show_locks(req)

       def unlock(self, lock_id):
           with self.metastore_client as metastore_client:
               req = UnlockRequest(lockid=lock_id)
               return metastore_client.unlock(req)


   @click.group()
   @click.option(
       "--host",
       required=True,
       help="Metastore host",
   )
   @click.option(
       "--port",
       type=int,
       help="Metastore port",
       default=9083,
   )
   @click.pass_context
   def cli(ctx, host: str, port: int):
       """Hive Metastore CLI."""
       ctx.obj = MetastoreClient(host, port)


   @cli.command("show-locks")
   @click.argument("db_name", required=True)
   @click.argument("table", required=True)
   @click.pass_obj
   def show_locks(client: MetastoreClient, db_name, table):
       """Show locks for table."""
       result = client.show_locks(db_name, table)
       click.echo(result)


   @cli.command("unlock")
   @click.argument("lock_id", required=True, type=int)
   @click.pass_obj
   def unlock(client: MetastoreClient, lock_id):
       """Unlock by lock id."""
       result = client.unlock(lock_id)
       click.echo(result)


   if __name__ == "__main__":
       cli()
   ```

   {% endcut %}

1. Чтобы посмотреть список блокировок, запустите скрипт:

    ```bash
    python unlock.py --host <metastore-host> show-locks <db-name> <table-name>
    ```

    Где:

    * `<metastore-host>` — внутренний IP-адрес {{ metastore-name }}.

       Чтобы узнать IP-адрес:
       1. Перейдите на страницу [каталога ресурсов]({{ link-console-main }}).
       1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
       1. На панели слева выберите ![image](../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.

    * `<db-name>` — имя базы данных.
    * `<table-name>` — имя таблицы.

1. Чтобы снять блокировку, запустите скрипт:

    ```bash
    python unlock.py --host <metastore-host> unlock <lock-id>
    ```

    Где:

    * `<metastore-host>` — внутренний IP-адрес {{ metastore-name }}.
    * `<lock-id>` — идентификатор блокировки.