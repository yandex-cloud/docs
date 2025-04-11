- {% include [Backup time](../../../_includes/mdb/console/backup-time.md) %}

- **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}** — время, в течение которого нужно хранить созданные автоматически резервные копии. Если для такой копии истекает срок хранения, то она удаляется. Значение по умолчанию — {{ mpg-backup-retention }} дней. Подробнее см. в разделе [Резервные копии](../../../managed-postgresql/concepts/backup.md).

    Изменение срока хранения затрагивает как новые автоматические резервные копии, так и уже существующие. Например, изначальный срок хранения был 7 дней. Оставшееся время жизни отдельной автоматической резервной копии при таком сроке — 1 день. При увеличении срока хранения до 9 дней оставшееся время жизни этой резервной копии будет уже 3 дня.

    Автоматические резервные копии кластера хранятся заданное количество дней, а созданные вручную — бессрочно. После удаления кластера все копии хранятся 7 дней.

- **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../../../managed-postgresql/concepts/maintenance.md):

    {% include [Maintenance window](../console/maintenance-window-description.md) %}

- **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}** — опция разрешает анализировать данные из кластера в сервисе [{{ datalens-full-name }}](../../../datalens/concepts/index.md).


- **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** — опция разрешает [выполнять SQL-запросы](../../../managed-postgresql/operations/web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}.




- **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** — опция разрешает выполнять YQL-запросы к базам данных кластера из сервиса [{{ yq-full-name }}](../../../query/concepts/index.md).

- **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}** — включите эту опцию, чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../../functions/concepts/index.md). Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../../functions/operations/database-connection.md).



- **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** — опция разрешает использовать в кластере инструмент [Диагностика производительности](../../../managed-postgresql/operations/performance-diagnostics.md). Если опция включена, настройте также **{{ ui-key.yacloud.mdb.forms.field_diagnostics-sessions-interval }}** и **{{ ui-key.yacloud.mdb.forms.field_diagnostics-statements-interval }}** при помощи ползунков. Единицы измерения обеих настроек — секунды.


- **Автоматическое переключение мастера** — если эта опция включена, при смене мастера источник репликации для всех хостов-реплик автоматически переключится на новый хост-мастер. Подробнее см. в разделе [Репликация](../../../managed-postgresql/concepts/replication.md).

    При [удалении](../../../managed-postgresql/operations/hosts.md#remove) хоста-мастера новый мастер будет выбран автоматически независимо от значения этой опции.

    {% note alert %}

    Если опция **Автоматическое переключение мастера** выключена, при выходе хоста-мастера из строя запустить выборы нового мастера или назначить эту роль одной из реплик придется [вручную](../../../managed-postgresql/operations/update.md#start-manual-failover).

    {% endnote %}


- **{{ ui-key.yacloud.postgresql.cluster.additional-field-pooling_mode }}** — выберите один из [режимов работы менеджера подключений](../../../managed-postgresql/concepts/pooling.md).

- **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}** — защита от удаления кластера, его баз данных и пользователей.

    По умолчанию при создании пользователей и БД значение параметра наследуется от кластера. Значение также можно задать вручную, подробнее см. в разделах [Управление пользователями](../../../managed-postgresql/operations/cluster-users.md) и [Управление БД](../../../managed-postgresql/operations/databases.md).
    
    Если параметр изменен на работающем кластере, новое значение унаследуют только пользователи и БД с защитой **Как у кластера**.

    {% include [Ограничения защиты от удаления кластера](../../../_includes/mdb/deletion-protection-limits-data.md) %}
