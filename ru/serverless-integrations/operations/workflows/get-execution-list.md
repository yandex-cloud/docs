---
title: Как получить список запусков рабочего процесса
description: Следуя данной инструкции, вы сможете посмотреть список запусков рабочего процесса {{ sw-full-name }}.
---

# Получить список запусков рабочего процесса

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [запуск рабочего процесса](../../concepts/workflows/execution.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}** и выберите рабочий процесс.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.serverless-workflows.label_workflow-executions }}**. На странице **{{ ui-key.yacloud.serverless-workflows.label_workflow-executions }}** отобразится список запусков рабочего процесса.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра списка [запусков рабочего процесса](../../concepts/workflows/execution.md):

      ```bash
      yc serverless workflow execution list --help
      ```

  1. {% include [get-workflows-list](../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. {% include [get-executions-list](../../../_includes/serverless-integrations/get-executions-list.md) %}

- API {#api}

  Чтобы посмотреть список [запусков рабочего процесса](../../concepts/workflows/execution.md), воспользуйтесь методом REST API [list](../../../serverless-integrations/workflows/api-ref/Execution/list.md) для ресурса [Execution](../../../serverless-integrations/workflows/api-ref/Execution/index.md) или вызовом gRPC API [WorkflowsService/List](../../../serverless-integrations/workflows/api-ref/grpc/Execution/list.md).

{% endlist %}