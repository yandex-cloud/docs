- {% include [Backup time](../../../_includes/mdb/console/backup-time.md) %}

- **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}** — время, в течение которого нужно хранить созданные автоматически резервные копии. Если для такой копии истекает срок хранения, то она удаляется. Значение по умолчанию — {{ mpg-backup-retention }} дней. Подробнее см. в разделе [Резервные копии](../../../managed-postgresql/concepts/backup.md).

    Изменение срока хранения затрагивает как новые автоматические резервные копии, так и уже существующие. Например, изначальный срок хранения был 7 дней. Оставшееся время жизни отдельной автоматической резервной копии при таком сроке — 1 день. При увеличении срока хранения до 9 дней оставшееся время жизни этой резервной копии будет уже 3 дня.

    Автоматические резервные копии кластера хранятся заданное количество дней, а созданные вручную — бессрочно. После удаления кластера все копии хранятся 7 дней.

- **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../../../managed-postgresql/concepts/maintenance.md):

    {% include [Maintenance window](../console/maintenance-window-description.md) %}

- **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}** — опция разрешает анализировать данные из кластера в сервисе [{{ datalens-full-name }}](../../../datalens/concepts/index.md).


- **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}** — опция разрешает выполнять SQL-запросы к базам кластера из консоли управления {{ yandex-cloud }}.


- {% include [datatransfer access](../console/datatransfer-access.md) %}



- **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}** — включите эту опцию, чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../../functions/concepts/index.md). Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../../functions/operations/database-connection.md).



- **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** — опция разрешает использовать в кластере инструмент [Диагностика производительности](../../../managed-postgresql/operations/performance-diagnostics.md). Если опция включена, настройте также **{{ ui-key.yacloud.mdb.forms.field_diagnostics-sessions-interval }}** и **{{ ui-key.yacloud.mdb.forms.field_diagnostics-statements-interval }}** при помощи ползунков. Единицы измерения обеих настроек — секунды.

    Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

- **Автоматическое переключение мастера** — включите эту опцию, чтобы при смене мастера источник репликации для всех хостов-реплик автоматически переключился на новый хост-мастер. Подробнее см. в разделе [Репликация](../../../managed-postgresql/concepts/replication.md).

    При [удалении](../../../managed-postgresql/operations/hosts.md#remove) хоста-мастера новый мастер будет выбран автоматически независимо от значения этой опции.

    {% note alert %}

    Если опция **Автоматическое переключение мастера** выключена, при выходе хоста-мастера из строя запустить выборы нового мастера или назначить эту роль одной из реплик придется [вручную](../../../managed-postgresql/operations/update.md#start-manual-failover).

    {% endnote %}


- **{{ ui-key.yacloud.postgresql.cluster.additional-field-pooling_mode }}** — выберите один из [режимов работы менеджера подключений](../../../managed-postgresql/concepts/pooling.md).

- {% include [Deletion protection](../console/deletion-protection.md) %}

    По умолчанию при создании пользователей и БД значение параметра наследуется от кластера. Значение также можно задать вручную, подробнее см. в разделах [Управление пользователями](../../../managed-postgresql/operations/cluster-users.md) и [Управление БД](../../../managed-postgresql/operations/databases.md).
    
    Если параметр изменен на работающем кластере, новое значение унаследуют только пользователи и БД с защитой **Как у кластера**.

    {% include [Ограничения защиты от удаления](../deletion-protection-limits-db.md) %}
