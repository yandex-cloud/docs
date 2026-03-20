---
title: Как запустить рабочий процесс по таймеру
description: Следуя данной инструкции, вы сможете запустить рабочий процесс по таймеру.
---

# Запустить рабочий процесс по таймеру

Вы можете задать расписание при [создании](../workflow/create-yawl.md) или [изменении](../workflow/update.md) рабочего процесса.


## Задать расписание {#add-schedule}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. В строке с нужным рабочим процессом нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. На графической схеме рабочего процесса нажмите на блок **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_trigger-settings-label }}**.
  1. Задайте расписание в формате [cron-выражения](../../../concepts/cron.md) и выберите часовой пояс.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения [рабочего процесса](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow update --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. Задайте расписание:

      ```bash
      yc serverless workflow update <имя_или_идентификатор_рабочего_процесса> \
        --schedule-cron-expression "<cron-выражение>" \
        --schedule-timezone "<часовой_пояс>"
      ```

      Где:
      
      * `--schedule-cron-expression` — cron-выражение, например: `"0 * * * * *"`. Подробнее о формате cron-выражений см. [{#T}](../../../concepts/cron.md).
      * `--schedule-timezone` — часовой пояс, например `Europe/Moscow`.

      Результат:

      ```text
      id: dfqai557kgv0********
      folder_id: b1g681qpemb4********
      specification:
        spec_yaml: ...
      created_at: "2025-09-19T09:11:38.826207Z"
      name: cron-flow
      status: ACTIVE
      log_options:
        folder_id: b1g681qpemb4********
      service_account_id: ajelprpohp7r********
      schedule:
        cron_expression: 0 * * * * *
        timezone: Europe/Moscow
      ```

- API {#api}

  Воспользуйтесь методом REST API [Update](../../../../serverless-integrations/workflows/api-ref/Workflow/update.md) для ресурса [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) или вызовом gRPC API [workflow/Update](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/update.md). В поле `schedule` задайте расписание и укажите часовой пояс.

{% endlist %}


## Удалить расписание {#remove-schedule}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. В строке с нужным рабочим процессом нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. На графической схеме рабочего процесса нажмите на блок **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_trigger-settings-label }}**.
  1. Удалите расписание.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для изменения [рабочего процесса](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow update --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. Удалите расписание:

      ```bash
      yc serverless workflow update <имя_или_идентификатор_рабочего_процесса> \
        --remove-schedule
      ```

      Результат:

      ```text
      id: dfqai557kgv0********
      folder_id: b1g681qpemb4********
      specification:
        spec_yaml: ...
      created_at: "2025-09-19T09:11:38.826207Z"
      name: cron-flow
      status: ACTIVE
      log_options:
        folder_id: b1g681qpemb4********
      service_account_id: ajelprpohp7r********
      ```

- API {#api}

  Воспользуйтесь методом REST API [Update](../../../../serverless-integrations/workflows/api-ref/Workflow/update.md) для ресурса [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) или вызовом gRPC API [workflow/Update](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/update.md). В поле `schedule` укажите `null`.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../../concepts/workflows/execution.md)
* [{#T}](get-list.md)
