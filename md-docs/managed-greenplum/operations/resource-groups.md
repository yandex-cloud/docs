[Документация Yandex Cloud](../../index.md) > [Yandex MPP Analytics for PostgreSQL](../index.md) > [Пошаговые инструкции](index.md) > Пользователи и сессии > Управление ресурсными группами

# Управление ресурсными группами

Вы можете управлять квотами на использование ресурсов кластера при помощи [ресурсных групп](../concepts/resource-groups.md).

Для выполнения операций с помощью SQL-запросов [подключитесь к кластеру](connect/index.md) от имени пользователя с [ролью](../concepts/cluster-users.md#mdb_admin) `mdb_admin`.

## Посмотреть информацию о ресурсных группах {#info}

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы посмотреть список ресурсных групп и значения их [параметров](../concepts/resource-groups.md#parameters), выполните команду:

    ```bash
    yc managed-greenplum resource-groups list --cluster-id=<идентификатор_кластера> 
    ```

    Чтобы посмотреть значения параметров отдельной ресурсной группы, выполните команду:

    ```bash
    yc managed-greenplum resource-groups get <имя_ресурсной_группы> \
       --cluster-id=<идентификатор_кластера> 
    ```

    Вместо параметра `--cluster-id` можно использовать параметр `--cluster-name`, указав в нем имя кластера. Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- SQL {#sql}

    Чтобы посмотреть список ресурсных групп и значения их [параметров](../concepts/resource-groups.md#parameters), выполните команду:

    ```sql
    SELECT * FROM gp_toolkit.gp_resgroup_config;
    ```

    Чтобы посмотреть список ролей и ресурсные группы, к которым они относятся, выполните команду:

    ```sql
    SELECT rolname, rsgname FROM pg_roles, pg_resgroup
    WHERE pg_roles.rolresgroup=pg_resgroup.oid;
    ```

{% endlist %}

## Создать ресурсную группу {#create}

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
    
    Чтобы создать ресурсную группу в кластере с СУБД Apache Cloudberry™, передайте имя ресурсной группы и значения ее [параметров](../concepts/resource-groups.md#parameters) в команде:

    ```bash
    yc managed-greenplum resource-groups create <имя_ресурсной_группы> \
       --cluster-id <идентификатор_кластера> \
       --concurrency <значение_параметра_CONCURRENCY> \
       --cpu-max-percent <значение_параметра_CPU_MAX_PERCENT> \
       --cpu-weight <значение_параметра_CPU_WEIGHT> \
       --memory-quota <значение_параметра_MEMORY_QUOTA> \
       --min-cost <значение_параметра_MIN_COST>
    ```

    При создании ресурсной группы достаточно указать значение параметра `CPU_MAX_PERCENT`. Для остальных параметров будут применены значения по умолчанию.

    Чтобы создать ресурсную группу в кластере с СУБД Greenplum®, передайте имя ресурсной группы и значения ее [параметров](../concepts/resource-groups.md#parameters) в команде:
   
    ```bash
    yc managed-greenplum resource-groups create <имя_ресурсной_группы> \
       --cluster-id <идентификатор_кластера> \
       --concurrency <значение_параметра_CONCURRENCY> \
       --cpu-rate-limit <значение_параметра_CPU_RATE_LIMIT> \
       --memory-limit <значение_параметра_MEMORY_LIMIT> \
       --memory-shared-quota <значение_параметра_MEMORY_SHARED_QUOTA> \
       --memory-spill-ratio <значение_параметра_MEMORY_SPILL_RATIO>
    ```

    При создании ресурсной группы достаточно указать значение параметра `CPU_RATE_LIMIT`. Для остальных параметров будут применены значения по умолчанию.

    Вместо параметра `--cluster-id` можно использовать параметр `--cluster-name`, указав в нем имя кластера. Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- SQL {#sql}

    Передайте имя ресурсной группы и ее [параметры](../concepts/resource-groups.md#parameters) в команде:

    ```sql
    CREATE RESOURCE GROUP <имя_ресурсной_группы> WITH (<параметр_1>, <параметр_2>, ...);
    ```

    При создании ресурсной группы достаточно указать значение параметра `CPU_RATE_LIMIT` или `CPUSET`. Для остальных параметров будут применены значения по умолчанию.


{% endlist %}

## Назначить ресурсную группу для роли {#assign}

{% list tabs group=instructions %}

- SQL {#sql}

    Чтобы создать роль и сразу назначить ей ресурсную группу, выполните команду:

    ```sql
    CREATE ROLE <имя_роли> RESOURCE GROUP <имя_ресурсной_группы>;
    ```

    {% note info %}

    * Если при создании роли ресурсная группа не указана, роли назначается `default_group`.

    * В Apache Cloudberry™ для ролей с [атрибутом SUPERUSER](../concepts/cluster-users.md#attributes) назначается группа `admin_group`.

    {% endnote %}

    Чтобы назначить для роли другую ресурсную группу, выполните команду:

    ```sql
    ALTER ROLE <имя_роли> RESOURCE GROUP <имя_ресурсной_группы>;
    ```

{% endlist %}

## Посмотреть текущую загрузку ресурсных групп {#load}

{% list tabs group=instructions %}

- SQL {#sql}

    Чтобы посмотреть текущую загрузку ресурсных групп во всем кластере, выполните команду:

    ```sql
    SELECT * FROM gp_toolkit.gp_resgroup_status;
    ```

    Чтобы посмотреть те же данные в разрезе хостов, используйте команду:

    ```sql
    SELECT * FROM gp_toolkit.gp_resgroup_status_per_host;
    ```

    Чтобы посмотреть те же данные в разрезе сегментов, используйте команду:

    ```sql
    SELECT * FROM gp_toolkit.gp_resgroup_status_per_segment;
    ```

{% endlist %}

## Посмотреть список запросов в ресурсных группах {#queries}

{% list tabs group=instructions %}

- SQL {#sql}

    Чтобы посмотреть список запросов на выполнении и в очереди, выполните команду:

    ```sql
    SELECT query, waiting, rsgname, rsgqueueduration
    FROM pg_stat_activity;
    ```

{% endlist %}

## Изменить параметры ресурсной группы {#params}

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить [параметры](../concepts/resource-groups.md#parameters) ресурсной группы в кластере с СУБД Apache Cloudberry™, выполните команду:

    ```bash
    yc managed-greenplum resource-groups update <имя_ресурсной_группы> \
       --cluster-id <идентификатор_кластера> \
       --concurrency <новое_значение_параметра_CONCURRENCY> \
       --cpu-max-percent <новое_значение_параметра_CPU_MAX_PERCENT> \
       --cpu-weight <новое_значение_параметра_CPU_WEIGHT> \
       --memory-quota <новое_значение_параметра_MEMORY_QUOTA> \
       --min-cost <новое_значение_параметра_MIN_COST>
    ```

    Чтобы изменить [параметры](../concepts/resource-groups.md#parameters) ресурсной группы в кластере с СУБД Greenplum®, выполните команду:

    ```bash
    yc managed-greenplum resource-groups update <имя_ресурсной_группы> \
       --cluster-id <идентификатор_кластера> \
       --concurrency <новое_значение_параметра_CONCURRENCY> \
       --cpu-rate-limit <новое_значение_параметра_CPU_RATE_LIMIT> \
       --memory-limit <новое_значение_параметра_MEMORY_LIMIT> \
       --memory-shared-quota <новое_значение_параметра_MEMORY_SHARED_QUOTA> \
       --memory-spill-ratio <новое_значение_параметра_MEMORY_SPILL_RATIO>
    ```

    Вместо параметра `--cluster-id` можно использовать параметр `--cluster-name`, указав в нем имя кластера. Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- SQL {#sql}

    Передайте имя ресурсной группы и новые значения ее [параметров](../concepts/resource-groups.md#parameters), которые нужно изменить, в команде:

    ```sql
    ALTER RESOURCE GROUP <имя_ресурсной_группы> SET <имя_параметра> <новое_значение_параметра>;
    ```

{% endlist %}

## Удалить ресурсную группу {#delete}

Ресурсную группу можно удалить, только если она не назначена никаким ролям и не содержит транзакций в очереди или на обработке.

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы удалить ресурсную группу, выполните команду:

    ```bash
    yc managed-greenplum resource-groups delete <имя_ресурсной_группы> \
       --cluster-id=<идентификатор_кластера> 
    ```

    Вместо параметра `--cluster-id` можно использовать параметр `--cluster-name`, указав в нем имя кластера. Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- SQL {#sql}

    Чтобы удалить ресурсную группу, выполните команду:

    ```sql
    DROP RESOURCE GROUP <имя_ресурсной_группы>;
    ```

{% endlist %}


## Пример создания ресурсной группы {#example}

Создайте ресурсную группу с тестовыми характеристиками:

* Имя `testgroup`.
* Максимальное количество обрабатываемых транзакций — 15.
* Доля используемых ресурсов CPU в сегменте — 10%.
* Доля оперативной памяти в сегменте — 20%.
* Доля, выделенная в качестве общей квоты, — 50%.
* Доля оперативной памяти в ресурсной группе, которую может занимать один оператор транзакции, — 30%.

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Выполните команду:

    ```bash
    yc managed-greenplum resource-groups create testgroup \
       --cluster-id=<идентификатор_кластера> \
       --concurrency=15 \
       --cpu-rate-limit=10 \
       --memory-limit=20 \
       --memory-shared-quota=50\
       --memory-spill-ratio=30
    ```

    Проверьте, что новая ресурсная группа появилась в списке:

    ```bash
    yc managed-greenplum resource-groups list --cluster-id=<идентификатор_кластера> 
    ```

- SQL {#sql}

    Выполните команду:

    ```sql
    CREATE RESOURCE GROUP testgroup
    WITH (CONCURRENCY=15, CPU_RATE_LIMIT=10, MEMORY_LIMIT=20, MEMORY_SHARED_QUOTA=50, MEMORY_SPILL_RATIO=30);
    ```

    Проверьте, что новая ресурсная группа появилась в списке:

    ```sql
    SELECT * FROM gp_toolkit.gp_resgroup_config;
    ```

{% endlist %}


_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_Apache® и Apache Cloudberry™ являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._