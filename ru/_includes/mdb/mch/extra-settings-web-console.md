* {% include [Backup time](../../../_includes/mdb/console/backup-time.md) %}

* **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}** — время, в течение которого нужно хранить созданные автоматически резервные копии (в днях). Если для такой копии истекает срок хранения, то она удаляется. Значение по умолчанию — {{ mch-backup-retention }} дней. Подробнее см. в разделе [Резервные копии](../../../managed-clickhouse/concepts/backup.md#storage).

    Изменение срока хранения затрагивает как новые автоматические резервные копии, так и уже существующие. Например, изначальный срок хранения был 7 дней, оставшееся время жизни отдельной автоматической резервной копии — 1 день. При увеличении срока хранения до 9 дней оставшееся время жизни этой резервной копии будет уже 3 дня.

* **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../../../managed-clickhouse/concepts/maintenance.md):

   {% include [Maintenance window](../console/maintenance-window-description.md) %}

* **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}** — опция разрешает анализировать данные из кластера в сервисе [{{ datalens-full-name }}](../../../datalens/concepts/index.md).


* **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** — опция разрешает [выполнять SQL-запросы](../../../managed-clickhouse/operations/web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}.




* **{{ ui-key.yacloud.mdb.forms.additional-field-metrika }}** — опция разрешает [импортировать данные из AppMetrica](https://appmetrica.yandex.ru/docs/common/cloud/about.html) в кластер.

* **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}** — включите эту опцию, чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../../functions/concepts/index.md). Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../../functions/operations/database-connection.md).


* **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** — включите эту опцию, чтобы разрешить доступ к кластеру из сервиса [{{ yq-full-name }}](../../../query/concepts/index.md). Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

* {% include [Deletion protection](../console/deletion-protection.md) %}

   {% include [Ограничения защиты от удаления](../deletion-protection-limits-db.md) %}

