---
title: Как получить список рабочих процессов
description: Следуя данной инструкции, вы сможете посмотреть список доступных рабочих процессов {{ sw-full-name }}.
---

# Получить список рабочих процессов

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**. На странице **{{ ui-key.yacloud.serverless-workflows.label_workflows }}** отобразится список рабочих процессов.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра списка [рабочих процессов](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow list --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}

- API {#api}

  Чтобы посмотреть список [рабочих процессов](../../../concepts/workflows/workflow.md), воспользуйтесь методом REST API [list](../../../../serverless-integrations/workflows/api-ref/Workflow/list.md) для ресурса [Workflow](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) или вызовом gRPC API [WorkflowsService/List](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/list.md).

{% endlist %}