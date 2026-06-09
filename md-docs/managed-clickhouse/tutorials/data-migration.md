# Миграция данных в Managed Service for ClickHouse® средствами ClickHouse®

# Миграция данных в Managed Service for ClickHouse® средствами ClickHouse®

Вы можете перенести данные из вашего кластера ClickHouse® в кластер Managed Service for ClickHouse® при помощи:

* [Встроенной функции `remote`](#transfer-remote). Этот способ подойдет для переноса отдельных таблиц.
* [Встроенных команд `BACKUP` и `RESTORE` и бакета Yandex Object Storage](#backup-objstorage). Этот способ подойдет для переноса как отдельных таблиц, так и базы данных целиком.

Вы также можете перенести базу данных из кластера ClickHouse® в кластер Managed Service for ClickHouse® при помощи Data Transfer. О том, как это сделать, см. в [практическом руководстве](../../tutorials/dataplatform/ch-to-mch-migration.md).

## Перенос данных при помощи remote {#transfer-remote}

При помощи `remote` вы можете перенести отдельные таблицы из стороннего кластера ClickHouse®. Этот способ не требует установки ZooKeeper и дополнительных инструментов, а также обновления версии ClickHouse® кластера-источника. 

{% note tip %}

Перед переносом данных рекомендуется остановить мержи в кластер-источник при помощи команд `STOP MERGES` и `STOP TTL MERGES`, а также отключить потребителей.

{% endnote %}

Чтобы перенести таблицу из стороннего кластера ClickHouse® в кластер Managed Service for ClickHouse®:

1. [Создайте кластер-приемник Managed Service for ClickHouse®](../operations/cluster-create.md#create-cluster).
1. Подключитесь к кластеру, из которого вы хотите перенести данные.
1. Получите текст запроса для создания таблиц:

   ```sql
   SELECT create_table_query FROM system.tables WHERE database = '<имя_переносимой_БД>';
   ```

   Например, в вашей БД `db1` хранится таблица `tasks` со списком заданий. Ответ на запрос будет выглядеть так:

   ```sql
   CREATE TABLE db1.tasks (`task_id` Int32,
                           `title` String, 
                           `start_date` Date, 
                           `due_date` Date, 
                           `priority` Int8 DEFAULT 3, 
                           `description` String) 
                  ENGINE = MergeTree 
                  PRIMARY KEY tuple(task_id) 
                  ORDER BY tuple(task_id) 
                  SETTINGS index_granularity = 8192;
   ```

1. [Подключитесь к кластеру Managed Service for ClickHouse®](../operations/connect/clients.md#clickhouse-client), на который вы хотите перенести данные, и создайте на нем новую таблицу из полученного ранее текста запроса.

   Если в кластере-источнике не использовались реплики, а в приемнике — используются, замените движок на Replicated-семейство.

   Чтобы создать объект на всех хостах кластера-приемника, используйте в команде `CREATE` выражение `ON CLUSTER`.

1. В кластере-источнике выполните запрос:

   ```sql
   INSERT INTO FUNCTION
   remoteSecure('<FQDN_хоста_кластера_Managed_Service_for_ClickHouse®>:9440',
                '<имя_БД_в_кластере-приемнике>.<имя_целевой_таблицы>',
                '<имя_пользователя_в_кластере-приемнике>',
                '<пароль_пользователя_в_кластере-приемнике>')
   SELECT * from <имя_БД>.<имя_таблицы>;
   ```

   О том, как получить FQDN хоста, см. [инструкцию](../operations/connect/fqdn.md).

1. В кластере-приемнике проверьте, что в БД появилась таблица из кластера-источника:

   ```sql
   SHOW TABLES FROM <имя_базы_данных>;
   ```

1. Проверьте, что таблица содержит данные из таблицы кластера-источника:

   ```sql
   SELECT * FROM <имя_БД>.<имя_таблицы>;
   ```

Подробнее об использовании функции `remote` см. в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/table-functions/remote).

## Перенос данных при помощи команд BACKUP и RESTORE и бакета Object Storage {#backup-objstorage}

{% note warning %}

Для работы с командами `BACKUP` и `RESTORE` в стороннем кластере нужна версия ClickHouse® 22.10 или новее.

{% endnote %}

При помощи команд `BACKUP` и `RESTORE` и бакета Object Storage вы можете перенести из стороннего кластера ClickHouse® как отдельные таблицы, так и базу данных целиком:

1. [Создайте кластер-приемник Managed Service for ClickHouse®](../operations/cluster-create.md#create-cluster) с включенным [управлением пользователями через SQL](../operations/cluster-users.md#sql-user-management).
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с ролью `storage.editor`.
1. [Создайте статический ключ](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта.

    Сохраните идентификатор ключа и сам ключ: они понадобятся в следующих шагах.

1. [Создайте бакет Object Storage](../../storage/operations/buckets/create.md).


1. Если в бакете включено [шифрование](../../storage/concepts/encryption.md), [назначьте](../../kms/operations/key-access.md#add-access-binding) сервисному аккаунту роль [kms.keys.encrypterDecrypter](../../iam/roles-reference.md#kms-keys-encrypterDecrypter) на ключ шифрования, привязанный к бакету.


1. Подключитесь к кластеру, из которого вы хотите перенести данные, от имени пользователя с привилегией `BACKUP` на нужную базу данных. По умолчанию такую привилегию имеет пользователь `admin`. Чтобы назначить привилегию другому пользователю, выполните запрос:

    ```sql
    GRANT BACKUP ON <имя_базы_данных>.* TO <имя_пользователя>;
    ```

1. Выполните команду для сохранения резервной копии таблицы в бакет Object Storage:

    ```sql
    BACKUP TABLE <имя_базы_данных>.<имя_таблицы> TO S3(
      'https://storage.yandexcloud.net/<имя_бакета_Object_Storage>',
      '<идентификатор_статического_ключа_сервисного_аккаунта>',
      '<статический_ключ_сервисного_аккаунта>'
    );
    ```

    Если вы хотите перенести базу данных целиком, выполните команду:

    ```sql
    BACKUP DATABASE <имя_базы_данных> TO S3(
      'https://storage.yandexcloud.net/<имя_бакета_Object_Storage>',
      '<идентификатор_статического_ключа_сервисного_аккаунта>',
      '<статический_ключ_сервисного_аккаунта>'
    );
    ```

1. [Подключитесь к кластеру Managed Service for ClickHouse®](../operations/connect/clients.md#clickhouse-client), в который вы хотите перенести данные, от имени пользователя с привилегиями `CREATE DATABASE`, `CREATE TABLE` и `INSERT` на нужную базу данных. По умолчанию такие привилегии имеет пользователь `admin`. Чтобы назначить привилегии другому пользователю, выполните запрос:

    ```sql
    GRANT CREATE DATABASE, CREATE TABLE, INSERT ON <имя_базы_данных>.* TO <имя_пользователя>;
    ```

1. Выполните команду для восстановления таблицы из резервной копии:

    ```sql
    RESTORE TABLE <имя_базы_данных>.<имя_таблицы> FROM S3(
      'https://storage.yandexcloud.net/<имя_бакета_Object_Storage>',
      '<идентификатор_статического_ключа_сервисного_аккаунта>',
      '<статический_ключ_сервисного_аккаунта>'
    );
    ```

    Если вы хотите восстановить базу данных целиком, используйте команду: 

    ```sql
    RESTORE DATABASE <имя_базы_данных> FROM S3(
      'https://storage.yandexcloud.net/<имя_бакета_Object_Storage>',
      '<идентификатор_статического_ключа_сервисного_аккаунта>',
      '<статический_ключ_сервисного_аккаунта>'
    );
    ```

1. Убедитесь, что восстановление из резервной копии прошло успешно:

    * Если вы восстанавливали таблицу, выполните команду:

        ```sql
        SELECT * FROM <имя_базы_данных>.<имя_таблицы>;
        ```

    * Если вы восстанавливали базу данных, выполните команду:

        ```sql
        SHOW DATABASES;
        ```

Подробнее об использовании команд `BACKUP` и `RESTORE` с S3-хранилищем см. в [документации ClickHouse®](https://clickhouse.com/docs/ru/operations/backup/overview#backuprestore-using-an-s3-disk).