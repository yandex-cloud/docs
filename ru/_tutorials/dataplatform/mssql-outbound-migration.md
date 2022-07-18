# Миграция базы данных из {{ mms-name }} в сторонний кластер {{ MS }}

{% note info %}

Миграция данных из стороннего кластера {{ MS }} описана в статье [{#T}](../../managed-sqlserver/tutorials/data-migration.md).

{% endnote %}

Чтобы перенести базу данных, развернутую в кластере {{ mms-name }}, в сторонний кластер {{ MS }}:

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

1. [Создайте резервную копию](../../managed-sqlserver/operations/cluster-backups.md#create-backup) кластера {{ mms-name }}. Она необходима для экспорта резервных копий баз данных кластера.
1. [Экспортируйте резервные копии необходимых баз данных](../../managed-sqlserver/operations/cluster-backups.md#objstorage-export) в {{ objstorage-full-name }}.
1. [Скачайте](../../storage/operations/objects/download.md) файлы резервных копий из {{ objstorage-full-name }}.
1. Восстановите резервные копии баз банных в стороннем кластере {{ MS }}, воспользовавшись [документацией {{ MS }}]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/backup-restore/quickstart-backup-restore-database?view=sql-server-ver16#restore-a-backup){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/quickstart-backup-restore-database?view=sql-server-ver16#restore-a-backup){% endif %}.

Если кластер {{ mms-name }} вам больше не нужен, [удалите его](../../managed-sqlserver/operations/cluster-delete.md).
