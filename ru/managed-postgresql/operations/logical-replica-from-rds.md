# Создание логической реплики Amazon RDS для PostgreSQL в {{ mpg-name }}

Если вы используете сервис Amazon RDS для PostgreSQL, вы можете создать копию ваших данных в {{ mpg-name }}.

## Настройка на стороне Amazon RDS для PostgreSQL {#amazon-set}

Доступно для Amazon RDS для PostgreSQL версии 10.4 и выше.

{% note warning %}

Экземпляр БД должен иметь публичный доступ — `Public accessibility = yes`.

{% endnote %}

1. Настройте логическую репликацию.

    1. Установите параметр в `parameter group` вашего экземпляра БД:

       ```
       rds.logical_replication = 1
       ```

    1. Перезапустите кластер для применения изменений.

1. Создайте отдельного пользователя с ролью `rds_replication`. Для этого выполните от имени пользователя с ролью `rds_superuser`:

    ```
    CREATE ROLE <user> WITH LOGIN PASSWORD <password>;
    GRANT rds_replication TO <user>;
    ```

1. Предоставьте привилегию `SELECT` на все таблицы, участвующие в репликации:

    ```
    GRANT SELECT ON <table>, <table2> TO <user>;
    ```

1. Создайте публикацию:

    ```
    CREATE PUBLICATION pub FOR TABLE <table>, <table2>;
    ```

	{% note info %}

	Не рекомендуется использовать публикации `FOR ALL TABLES` из-за невозможности отредактировать список таблиц в будущем.

	{% endnote %}


1. Добавьте `inbound` правило в [VPC security groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html).
   Например:

    ```
    protocol: tcp, port: 5432, source: 84.201.175.90/32
    ```

    Где `84.201.175.90` — публичный IP-адрес.

## Настройка на стороне {{ mpg-name }} {#mdb-pg-set}

{% note warning %}

Хосты должны иметь публичный доступ.

{% endnote %}

1. Для создания `subscription` назначьте пользователю роль `mdb_admin`:

   ```
   yc managed-postgresql user update {user_name} --grants mdb_admin --cluster-id {cluster_id}
   ```

1. На хосте кластера {{ mpg-name }} создайте подписку со строкой подключения к Amazon RDS:

   ```
   CREATE SUBSCRIPTION s_data_migration CONNECTION 'host=<адрес сервера Amazon RDS> port=<порт> user=<имя пользователя> sslmode=prefer dbname=<имя базы данных>' PUBLICATION pub;
   ```

Подробнее о создании подписок смотрите [в документации {{ PG }}](https://www.postgresql.org/docs/10/sql-createsubscription.html).

## Особенности использования логической репликации {#logical-replica-specific}

* Изменения схемы базы данных и DDL не реплицируются.

  В первую очередь применяйте новые изменения схемы на стороне подписчика, а потом — на стороне публикации.

* Последовательности не реплицируются.

  В составе таблицы реплицируются данные в столбцах `serial` или столбцах идентификации, которые генерируются последовательностями. Но сама последовательность на подписчике будет сохранять стартовое значение.

  В случае переключения на базу подписчика, необходимо обновить последовательность до последнего значения:

    ```
    ALTER SEQUENCE serial RESTART WITH <new value>;
    ```

* По умолчанию при создании подписки происходит полное копирование данных из исходных таблиц.

  Для ускорения копирования создавайте только `primary key`, а после его завершения создайте все остальные индексы.

* Если на таблице отсутствует `primary key`, вы будете получать ошибки:

    ```
    ERROR:  55000: cannot update table "t2" because it does not have a replica identity and publishes updates
    HINT:  To enable updating the table, set REPLICA IDENTITY using ALTER TABLE.
    ```

   Для работы репликации `UPDATE`, `DELETE` на таблицах без `primary key` необходимо изменить `REPLICA IDENTITY` :

    ```
    alter table t2 replica identity full;
    ```

* В PostgreSQL версии 10 команда `TRUNCATE` не реплицируется.

  Вместо этого можно использовать `DELETE`.

* Внешние таблицы не реплицируются.
* Ошибки, связанные с работой логической репликации, смотрите в логах {{ mpg-name }}.
* Если потребуется пересоздать подписку, то для предотвращения ошибок ограничения `primary key` очистите таблицы на стороне подписчика.
