# Создание логической реплики Amazon RDS для {{ PG }} в {{ mpg-name }}

Перенести базу данных из _кластера-источника_ Amazon RDS для {{ PG }} в _кластер-приемник_ {{ mpg-name }} можно с помощью логической репликации.

[Логическая репликация](https://www.postgresql.org/docs/current/logical-replication.html) использует механизм [подписки (subscription)](https://www.postgresql.org/docs/current/sql-createsubscription.html). Это позволяет перенести данные в кластер-приемник с минимальным временем простоя. Логическая репликация доступна в Amazon RDS для {{ PG }} версии 10.4 и выше.

Используйте логическую репликацию в том случае, если [перенос данных с помощью Yandex Data Transfer](../tutorials/data-migration.md#data-transfer) по каким-либо причинам невозможен.

Чтобы перенести базу данных из кластера-источника Amazon RDS для {{ PG }} в кластер-приемник {{ mpg-name }}:

1. [Настройте Amazon RDS](#amazon-set).
1. [Настройте кластер-приемник и создайте подписку](#mdb-pg-set).
1. [Перенесите последовательности](#transfer-sequences).
1. [Удалите подписку и переключите нагрузку на кластер-приемник](#transfer-load).

## Особенности использования логической репликации {#logical-replica-specific}

* Изменения схемы базы данных и DDL не реплицируются.

    В первую очередь применяйте новые изменения схемы на стороне [подписчика (subscription)](https://www.postgresql.org/docs/current/logical-replication-subscription.html), а потом — на стороне [публикации (publication)](https://www.postgresql.org/docs/current/logical-replication-publication.html).

* Последовательности (`SEQUENCES`) не реплицируются.

    В составе таблицы реплицируются данные в столбцах `serial` или столбцах идентификации, которые генерируются последовательностями. Но сама последовательность на подписчике будет сохранять стартовое значение.

    В случае переключения на базу подписчика, необходимо обновить последовательность до последнего значения:

    ```sql
    ALTER SEQUENCE serial RESTART WITH <new value>;
    ```

* По умолчанию при создании подписки происходит полное копирование данных из исходных таблиц.

    Для ускорения копирования создайте только первичный ключ (`PRIMARY KEY`), а после его завершения создайте все остальные индексы.

* Если в таблице отсутствует первичный ключ, во время репликации появятся ошибки:

    ```text
    ERROR:  55000: cannot update table "<имя таблицы>" because it does not have a replica identity and publishes updates
    HINT:  To enable updating the table, set REPLICA IDENTITY using ALTER TABLE.
    ```

    Для работы репликации `UPDATE` и `DELETE` в таблицах без первичного ключа необходимо изменить `REPLICA IDENTITY`:

    ```sql
    ALTER TABLE <имя таблицы> REPLICA IDENTITY FULL;
    ```

* В {{ PG }} версии 10 команда `TRUNCATE` не реплицируется.

    Вместо этого можно использовать `DELETE`.

* Внешние таблицы не реплицируются.
* Если потребуется пересоздать подписку, то для предотвращения ошибок ограничения первичного ключа очистите таблицы в кластере-приемнике.
* Ошибки, связанные с работой логической репликации, смотрите в [логах {{ mpg-name }}](cluster-logs.md).

## Перед началом работы {#before-you-begin}

Создайте необходимые ресурсы:

{% list tabs %}

* Вручную

    [Создайте кластер {{ mpg-name }}](../operations/cluster-create.md) с публичным доступом к хостам. При этом:

    * Версия {{ PG }} должна быть не ниже, чем в кластере-источнике. Миграция с понижением версии {{ PG }} невозможна.
    * Имя базы данных должно быть такое же, как и в кластере-источнике.
    * Включите те же [расширения {{ PG }}](../operations/cluster-extensions.md), что и в базе-источнике.

* С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, [установите и настройте его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
    1. Скачайте в ту же рабочую директорию файл конфигурации [logical-replica-amazon-rds-to-postgresql.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/logical-replica-amazon-rds-to-postgresql.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, разрешающее подключение к кластеру;
        * кластер {{ mpg-name }} с публичным доступом из интернета.

    1. Укажите параметры инфраструктуры в файле конфигурации `logical-replica-amazon-rds-to-postgresql.tf` в блоке `locals`:

        * `pg_version` — версия {{ PG }}. Она должна быть не ниже, чем в Amazon RDS.
        * `db_name` — имя базы данных в кластере-приемнике. Должно совпадать с именем базы-источника.
        * `username` и `password` — имя и пароль пользователя-владельца базы данных.
        * Имена и версии расширений {{ PG }}, используемых в Amazon RDS. Для этого раскомментируйте и размножьте блок `extension`.

    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдера, указанного в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Настройте Amazon RDS {#amazon-set}

{% note warning %}

Экземпляр БД должен иметь публичный доступ — `Public accessibility = yes`.

{% endnote %}

1. Настройте логическую репликацию.

    1. Установите параметр в `parameter group` вашего экземпляра БД:

        ```text
        rds.logical_replication = 1
        ```

    1. Перезапустите кластер для применения изменений.

1. Создайте отдельного пользователя с ролью `rds_replication`. Для этого выполните от имени пользователя с ролью `rds_superuser`:

    ```sql
    CREATE ROLE <имя пользователя> WITH LOGIN PASSWORD <пароль>;
    GRANT rds_replication TO <имя пользователя>;
    ```

1. Предоставьте привилегию `SELECT` на все таблицы, участвующие в репликации:

    ```sql
    GRANT SELECT ON <таблица_1>, <таблица_2>, ..., <таблица_n> TO <имя пользователя>;
    ```

1. Создайте публикацию:

    ```sql
    CREATE PUBLICATION pub FOR TABLE <таблица_1>, <таблица_2>, ..., <таблица_n>;
    ```

    {% note info %}

    Не рекомендуется использовать публикации `FOR ALL TABLES` из-за невозможности отредактировать список таблиц в будущем.

    {% endnote %}

1. Добавьте правило для входящего трафика в [VPC security groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html). Например:

    ```text
    protocol: tcp, port: 5432, source: 84.201.175.90/32
    ```

    Где `84.201.175.90` — публичный IP-адрес.

## Настройте кластер-приемник и создайте подписку {#mdb-pg-set}

В кластерах {{ mpg-name }} подписки может использовать владелец базы данных (пользователь, созданный одновременно с кластером) и пользователи с ролью `mdb_admin` для этого кластера.

1. (Опционально) [Назначьте](../operations/grant.md#grant-role) пользователю кластера {{ mpg-name }} роль `mdb_admin`.

1. Создайте подписку со строкой подключения к кластеру-источнику:

    ```sql
    CREATE SUBSCRIPTION s_data_migration CONNECTION 'host=<адрес кластера-источника> port=<порт> user=<имя пользователя> sslmode=prefer dbname=<имя базы данных>' PUBLICATION pub;
    ```

    Подробнее о создании подписок см. в [документации {{ PG }}](https://www.postgresql.org/docs/10/sql-createsubscription.html).

1. Чтобы получить статус репликации, обратитесь к каталогам `pg_subscription_rel`.

    ```sql
    SELECT * FROM pg_subscription_rel;
    ```

    Значение `r` в поле `srsubstate` означает, что репликация завершилась.

### Перенесите последовательности {#transfer-sequences}

Чтобы завершить синхронизацию кластера-источника и кластера-приемника:

1. Переведите кластер-источник в режим <q>только чтение</q>.
1. Создайте дамп с последовательностями:

    ```bash
    pg_dump --host=<адрес кластера-источника> \
            --username=<имя пользователя> \
            --port=<порт> \
            --dbname=<имя базы данных> \
            --data-only \
            --table='*.*_seq' > /tmp/seq-data.sql
    ```

    Обратите внимание на используемый паттерн `*.*_seq`. Если в переносимой базе есть не соответствующие ему последовательности, то для их выгрузки укажите другой паттерн.

    Подробнее о паттернах см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/app-psql.html#APP-PSQL-PATTERNS).

1. Восстановите дамп с последовательностями в кластере-приемнике:

    ```bash
    psql \
        --host=<IP-адрес или FQDN хоста-мастера кластера-приемника> \
        --username=<имя пользователя> \
        --port={{ port-mpg }} \
        --dbname=<имя базы данных> < /tmp/seq-data.sql
    ```

### Удалите подписку и переключите нагрузку на кластер-приемник {#transfer-load}

1. Удалите подписку в кластере-приемнике:

    ```sql
    DROP SUBSCRIPTION s_data_migration;
    ```

1. Перенесите нагрузку на кластер-приемник.
