# Миграция базы данных между {{ mms-name }} с помощью {{ objstorage-full-name }}

Вы можете переносить базы данных между кластерами {{ mms-name }} с помощью {{ objstorage-name }}:

1. [Настройте кластеры](#configure).
1. [Экспортируйте резервные копии необходимых баз данных в {{ objstorage-name }}](#backup-export).
1. [Восстановите базы данных из резервных копий, хранящихся в {{ objstorage-name }}](#backup-import).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Создайте необходимые ресурсы:

{% list tabs %}

* Вручную

    1. [Создайте кластер-приемник {{ mms-name }}](../../managed-sqlserver/operations/cluster-create.md).

    1. [Создайте бакет](../../storage/operations/buckets/create.md) в {{ objstorage-name }}.

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) для работы с кластерами {{ mms-name }} и бакетом {{ objstorage-name }}.

    1. Выдайте сервисному аккаунту права на чтение и запись в бакет одним из способов:

        * (рекомендуется) [настройте ACL бакета](../../storage/operations/buckets/edit-acl.md), добавив в список сервисный аккаунт и выдав ему разрешение `READ и WRITE`;
        * [назначьте сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md) `storage.uploader` и `storage.viewer`.

* С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
    1. Скачайте в ту же рабочую директорию файл конфигурации [to-mms-with-bucket.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/sqlserver-migration/to-mms-with-bucket.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, разрешающее подключение к кластеру;
        * [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для работы с кластерами {{ mms-name }} и бакетом {{ objstorage-name }};
        * [бакет в {{ objstorage-name }}](../../storage/concepts/bucket.md) с разрешением `READ и WRITE` в [ACL](../../storage/concepts/acl.md) для сервисного аккаунта;
        * кластер-приемник {{ mms-name }}.

    1. Укажите параметры инфраструктуры в файле конфигурации `sqlserver-data-migration.tf` в блоке `locals`:

        * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут созданы ресурсы.
        * `sql_server_version` — версия {{ MS }}.
        * `db_name` — имя базы данных в кластере-приемнике.
        * `username` и `password` — имя и пароль пользователя-владельца базы данных.
        * `storage_sa_id` — идентификатор сервисного аккаунта с ролью `storage.admin`. С помощью него будет создан бакет в {{ objstorage-name }} с разрешением `READ и WRITE` в [ACL](../../storage/concepts/acl.md) для нового сервисного аккаунта.
        * `cluster_sa` — имя сервисного аккаунта для кластера {{ mms-name }}. Оно должны быть уникальным в каталоге.
        * `bucket_name` — имя бакета в {{ objstorage-name }}. Оно должны быть уникальным для всего {{ objstorage-name }}.

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

## Настройте кластеры {#configure}

1. Снимите нагрузку с кластера-источника.
1. Переведите кластер-источник в режим <q>только чтение</q>:

    * С помощью {{ ssms }}:

        1. Откройте {{ ssms }}.
        1. Откройте контекстное меню для реплицируемой базы данных, затем выберите пункт **Properties**.
        1. Выберите **Database Properties** → **Options** и в блоке **State** поменяйте значение **Database Read Only** на **True**.

    * С помощью запроса:

        ```sql
        ALTER DATABASE <имя базы данных> SET READ_ONLY
        ```

1. [Создайте резервную копию](../../managed-sqlserver/operations/cluster-backups.md#create-backup) кластера-источника. Она необходима для экспорта резервных копий баз данных кластера.

1. [Привяжите созданный сервисный аккаунт](../../managed-sqlserver/operations/update.md#service-account) к кластеру-источнику и кластеру-приемнику.

## Экспортируйте резервные копии необходимых баз данных в {{ objstorage-name }} {#backup-export}

{% include [database-backup-export](../../_includes/mdb/mms/database-backup-export.md) %}

## Восстановите базы данных из резервных копий, хранящихся в {{ objstorage-name }} {#backup-import}

{% include [database-backup-import](../../_includes/mdb/mms/database-backup-import.md) %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

{% list tabs %}

* Вручную

    * [Удалите кластер-приемник {{ mms-name }}](../../managed-sqlserver/operations/cluster-delete.md).
    * [Удалите бакет](../../storage/operations/buckets/delete.md) в {{ objstorage-name }}.
    * [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).

* С помощью Terraform

    Чтобы удалить инфраструктуру, созданную с помощью {{ TF }}:

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `to-mms-with-bucket.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `to-mms-with-bucket.tf`, будут удалены.

{% endlist %}
