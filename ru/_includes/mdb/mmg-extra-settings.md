- {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}

- **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}**{#setting-backup-saving}
  
  Время, в течение которого нужно хранить созданные автоматически резервные копии. Если для такой копии истекает срок хранения, то она удаляется. Значение по умолчанию — {{ mmg-backup-retention }} дней. Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Подробнее см. в разделе [Резервные копии](../../managed-mongodb/concepts/backup.md).


  Изменение срока хранения затрагивает как новые автоматические резервные копии, так и уже существующие. Например, если изначальный срок хранения был 7 дней и оставшееся время жизни отдельной автоматической резервной копии при таком сроке — 1 день, то при увеличении срока хранения до 9 дней, оставшееся время жизни этой резервной копии будет уже 3 дня.

  Для существующего кластера автоматически созданные копии хранятся заданное количество дней, а созданные вручную — бессрочно. После удаления кластера все копии хранятся {{ mmg-backup-retention }} дней.

- **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../../managed-mongodb/concepts/maintenance.md):

    {% include [Maintenance window](console/maintenance-window-description.md) %}


- **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** — включите эту опцию, чтобы пользоваться встроенным инструментом для [диагностики производительности](../../managed-mongodb/operations/performance-diagnostics.md) в кластере. Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

- **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}** — защита кластера от непреднамеренного удаления.

  {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

