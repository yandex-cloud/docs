* `--security-group-ids` — список идентификаторов [групп безопасности](../../metadata-hub/operations/metastore/configure-security-group.md).
* `--resource-preset-id` — конфигурация вычислительных ресурсов. Доступные значения:
    * `c2-m8` — 2 vCPU и 8 ГБ RAM.
    * `c2-m4` — 2 vCPU и 4 ГБ RAM.
* `--maintenance-window` — настройки времени технического обслуживания (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

    {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

* `--deletion-protection` — включает защиту кластера от непреднамеренного удаления.
* Параметры логирования:

    * `--log-enabled` — включает логирование. Логи, сгенерированные компонентами {{ metastore-name }}, будут отправляться в {{ cloud-logging-full-name }}.
    * `--log-folder-id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
    * `--log-group-id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

      Укажите один из двух параметров: `--log-folder-id` либо `--log-group-id`.

    * `--log-min-level` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO` (значение по умолчанию), `WARN`, `ERROR` и `FATAL`.