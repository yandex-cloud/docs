- **{{ ui-key.yacloud.mdb.forms.backup-window-start }}**{#setting-backup-start}

  Время по UTC (в 24-часовом формате), когда начинается [резервное копирование](../../managed-mongodb/operations/cluster-backups.md) кластера. Если время не задано, резервное копирование начнется в 22:00 UTC.

- **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}**{#setting-backup-saving}
  
  Время, в течение которого нужно хранить созданные автоматически резервные копии. Если для такой копии истекает срок хранения, то она удаляется. Значение по умолчанию — {{ mmg-backup-retention }} дней. Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Подробнее см. в разделе [{#T}](../../managed-mongodb/concepts/backup.md).


  Изменение срока хранения затрагивает как новые автоматические резервные копии, так и уже существующие. Например, если изначальный срок хранения был 7 дней и оставшееся время жизни отдельной автоматической резервной копии при таком сроке — 1 день, то при увеличении срока хранения до 9 дней, оставшееся время жизни этой резервной копии будет уже 3 дня.

  Для существующего кластера автоматически созданные копии хранятся заданное количество дней, а созданные вручную — бессрочно. После удаления кластера все копии хранятся {{ mmg-backup-retention }} дней.

- **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../../managed-mongodb/concepts/maintenance.md):

    {% include [Maintenance window](console/maintenance-window-description.md) %}

- {% include [datatransfer access](console/datatransfer-access.md) %}

- **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** — включите эту опцию, чтобы воспользоваться инструментом [{#T}](../../managed-mongodb/operations/performance-diagnostics.md) в кластере. Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). 

- {% include [Deletion protection](console/deletion-protection.md) %}

    {% include [Ограничения защиты от удаления](deletion-protection-limits-db.md) %}
