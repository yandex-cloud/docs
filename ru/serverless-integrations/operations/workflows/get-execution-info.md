---
title: Как получить информацию о запуске рабочего процесса
description: Следуя данной инструкции, вы сможете посмотреть информацию о запуске рабочего процесса {{ sw-full-name }}.
---

# Получить информацию о запуске рабочего процесса

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [запуск рабочего процесса](../../concepts/workflows/execution.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}** и выберите рабочий процесс.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.serverless-workflows.label_workflow-executions }}**.
  1. Выберите запуск. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о запуске рабочего процесса.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра информации о [запуске рабочего процесса](../../concepts/workflows/execution.md):

      ```bash
      yc serverless workflow execution get --help
      ```

  1. {% include [get-workflows-list](../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. {% include [get-executions-list](../../../_includes/serverless-integrations/get-executions-list.md) %}
  1. Получите подробную информацию о запуске рабочего процесса, указав идентификатор запуска:

      ```bash
      yc serverless workflow execution get <идентификатор_запуска>
      ```

      Результат:

      ```text
      execution:
        id: dfq...e78
        workflow_id: dfqud9cbc4k5********
        input:
          input_json: '{}'
        result:
          result_json:
          ...
        status: FINISHED
        started_at: "2025-03-10T15:54:44.304781814Z"
        duration: 1.070697344s
      ```

- API {#api}

  Чтобы получить информацию о [запуске рабочего процесса](../../concepts/workflows/execution.md), воспользуйтесь методом REST API [get](../../../serverless-integrations/workflows/api-ref/Execution/get.md) для ресурса [Execution](../../../serverless-integrations/workflows/api-ref/Execution/index.md) или вызовом gRPC API [WorkflowsService/Get](../../../serverless-integrations/workflows/api-ref/grpc/Execution/get.md).

{% endlist %}