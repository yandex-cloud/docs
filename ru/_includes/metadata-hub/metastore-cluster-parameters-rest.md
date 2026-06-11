* `name` — имя кластера.
* `description` — описание кластера.
* `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
* `deletionProtection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.
* `version` — версия {{ metastore-name }}.

  {% include [metastore-version](metastore-version-cluster-create.md) %}

* `configSpec.resources.resourcePresetId` — [конфигурация вычислительных ресурсов](../../metadata-hub/concepts/metastore.md#presets).
* `configSpec.warehouse.s3` — параметры хранилища данных {{ metastore-name }}:

  * `bucket` — имя бакета {{ objstorage-name }}, который будет использоваться в качестве хранилища данных {{ metastore-name }} (warehouse).
  * `path` — путь внутри бакета, который будет использоваться как префикс для данных {{ metastore-name }}. Опциональный параметр.

* `serviceAccountId` — идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).
* `logging` — параметры логирования:

  * `enabled` — позволяет включить логирование. Логи, сгенерированные компонентами {{ metastore-name }}, будут отправляться в {{ cloud-logging-full-name }}. Возможные значения: `true` или `false`.
  * `folderId` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
  * `logGroupId` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

      Укажите один из двух параметров: `folderId` либо `logGroupId`.

  * `minLevel` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`.
