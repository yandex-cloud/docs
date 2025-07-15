#### Можно ли восстановить резервную копию кластера в работающий экземпляр {{ mpg-short-name }} в другой облачной сети? {#diff-network}

Восстановить кластер из резервной копии можно только в рамках одной облачной сети.

Чтобы перенести данные между облачными сетями, воспользуйтесь [инструкциями по миграции](../../managed-postgresql/tutorials/replication-overview.md).

#### Можно ли изменить срок хранения автоматических резервных копий? {#backup-retain-days}

При [создании](../../managed-postgresql/operations/cluster-create.md) или [изменении](../../managed-postgresql/operations/update.md#change-additional-settings) кластера можно задать срок хранения автоматических резервных копий.

#### Нужен ли плагин wal2json, если выполняется только реплицирование, но не копирование данных? {#wal2json}

Да, плагин обязателен, даже если вы не выполняете копирование данных.

#### Можно ли локально выгрузить резервную копию базы данных? {#backup-local-dump}

Локально выгрузить резервную копию из {{ yandex-cloud }} средствами сервиса нельзя, но вы можете воспользоваться [утилитой pg_dump]({{ pg.docs.org }}/current/app-pgdump.html).

#### Как перенести локальный дамп базы данных {{ PG }} в {{ yandex-cloud }}? {#dump-to-yc}

Воспользуйтесь инструкцией в разделе [Миграция базы данных](../../managed-postgresql/tutorials/data-migration.md).

#### Как перенести БД или таблицу из одного кластера в другой? {#transfer-db-table}

Перенести БД или таблицу можно с помощью сервиса {{ data-transfer-name }} или утилиты [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html).

Подробнее о миграции с помощью {{ data-transfer-name }} см. в руководстве [Миграция базы данных](../../managed-postgresql/tutorials/outbound-replication.md).

#### Как перенести данные между кластерами в разных каталогах или облаках? {#transfer-data}

Перенести данные можно с помощью сервиса {{ data-transfer-name }} или утилиты [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html).

Подробнее о миграции с помощью {{ data-transfer-name }} см. в руководстве [Миграция базы данных](../../managed-postgresql/tutorials/outbound-replication.md).

#### Как перенести кластер в другое облако? {#transfer-cluster}

Перенести кластер можно с помощью сервиса {{ data-transfer-name }} или утилиты [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html).

Подробнее о миграции с помощью {{ data-transfer-name }} см. в руководстве [Миграция базы данных](../../managed-postgresql/tutorials/outbound-replication.md).

#### Как восстановить резервную копию в существующий кластер? {#restore-existing-cluster}

Резервную копию можно развернуть только в новый кластер.

#### Как восстановить кластер до состояния выбранной резервной копии? {#cluster-existing-backup}

Резервную копию можно развернуть только в новый кластер.

#### Можно ли восстановить из резервной копии одну базу данных? {#restore-one-database}

Нет, выбрать желаемые базы данных нельзя. Из резервной копии кластер восстанавливается целиком со всеми базами данных.
