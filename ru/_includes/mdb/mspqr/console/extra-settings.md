* **{{ ui-key.yacloud.logging.label_minlevel }}** — в журнал выполнения будут записываться логи указанного уровня и выше. Доступные уровни — `DEBUG`, `INFO`, `WARN`, `ERROR`, `FATAL` и `PANIC`. Уровень по умолчанию — `INFO`.

* {% include [Backup time](../../../../_includes/mdb/console/backup-time.md) %}

* **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}** — автоматические резервные копии будут храниться указанное количество дней. По умолчанию — 7 дней.

* **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени технического обслуживания:

    {% include [Maintenance window](../../console/maintenance-window-description.md) %}


* {% include [Deletion protection](../../console/deletion-protection.md) %}

    {% include [Ограничения защиты от удаления](../../deletion-protection-limits-db.md) %}
