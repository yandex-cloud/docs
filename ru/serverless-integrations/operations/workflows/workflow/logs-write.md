---
title: Запись логов в журнал выполнения в {{ sw-full-name }}
description: Следуя данной инструкции, вы сможете настроить логирование рабочего процесса.
---

# Записать логи в журнал выполнения рабочего процесса

{% include [logging-note](../../../../_includes/functions/logging-note.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. В строке с нужным рабочим процессом нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Раскройте блок **{{ ui-key.yacloud.serverless-workflows.label_additional-parameters }}** и найдите блок **{{ ui-key.yacloud.logging.label_title }}**:

      1. Включите опцию **{{ ui-key.yacloud.logging.field_logging }}**.
      1. В поле **{{ ui-key.yacloud.logging.label_destination }}** выберите:

         * `{{ ui-key.yacloud.common.folder }}` — чтобы записывать логи в лог-группу по умолчанию для каталога, в котором находится рабочий процесс.
         * {% include [log-group](../../../../_includes/functions/log-group.md) %}

      1. (Опционально) Выберите минимальный уровень логирования.

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

  {% include [min-log-level](../../../../_includes/serverless-integrations/min-log-level.md) %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  ### Назначение логирования {#destination}

  Если в параметрах рабочего процесса не указана пользовательская [лог-группа](../../../../logging/concepts/log-group.md) или логирование не отключено, рабочий процесс автоматически пишет все логи в лог-группу по умолчанию для [каталога](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором он находится.

  Чтобы записывать логи в лог-группу по умолчанию для другого каталога, укажите идентификатор этого каталога в параметре `--log-folder-id` при [создании](create-yawl.md) или [изменении](update.md) рабочего процесса. [Аккаунту](../../../../iam/concepts/users/accounts.md), от имени которого выполняется команда, на этот каталог должна быть назначена [роль](../../../../logging/security/index.md#logging-editor) `logging.editor` или выше.

  Чтобы записывать логи в пользовательскую лог-группу, укажите идентификатор этой лог-группы в параметре `--log-group-id` при создании или изменении рабочего процесса. Лог-группа может находиться в другом каталоге. Аккаунту, от имени которого выполняется команда, на этот каталог должна быть назначена роль `logging.editor` или выше.

  ### Минимальный уровень логирования {#log-level}

  Чтобы задать минимальный уровень логирования, укажите его в параметре `--min-log-level` при создании или изменении рабочего процесса.

  {% include [min-log-level](../../../../_includes/serverless-integrations/min-log-level.md) %}

  ### Отключение логирования {#disabled}

  Чтобы отключить логирование, при создании или изменении рабочего процесса укажите параметр `--no-logging`.

  ### Пример команды {#example}

  Чтобы записывать логи в пользовательскую лог-группу, выполните команду:

  ```
  yc serverless workflow update <имя_или_идентификатор_рабочего_процесса> \
    --yaml-spec <файл_спецификации> \
    --log-group-id <идентификатор_лог-группы> \
    --min-log-level <минимальный_уровень_логирования>
  ```

  Где:

  * `--yaml-spec` — путь к файлу с [YaWL-спецификацией](../../../concepts/workflows/yawl/index.md) рабочего процесса. Например: `./yawl-spec.json`.
  * `--log-group-id` — идентификатор лог-группы, в которую будут записываться логи.
  * `--min-log-level` — минимальный уровень логирования. Необязательный параметр.

  Результат:

  ```text
  id: dfqjl5hh5p90********
  folder_id: b1g681qpemb4********
  specification:
    spec_yaml: "yawl: ..."
  created_at: "2025-03-11T09:27:51.691990Z"
  name: my-workflow
  description: created via cli
  labels:
    owner: "admin"
    version: "alpha"
  status: ACTIVE
  log_options:
    log_group_id: e23u2vn449av********
    min_level: DEBUG
  service_account_id: aje4tpd9coa********
  network_id: enpm8v48ehcl********
  ```

- API {#api}

  Чтобы записывать логи в журнал выполнения рабочего процесса, воспользуйтесь методом REST API [Update](../../../../serverless-integrations/workflows/api-ref/Workflow/update.md) для ресурса [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) или вызовом gRPC API [workflow/Update](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/update.md).

{% endlist %}