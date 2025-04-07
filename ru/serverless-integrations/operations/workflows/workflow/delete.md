---
title: Как удалить рабочий процесс
description: Следуя данной инструкции, вы сможете удалить рабочий процесс.
---

# Удалить рабочий процесс

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите удалить [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. В строке с нужным рабочим процессом нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления [рабочего процесса](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow delete --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. Удалите рабочий процесс:

      ```bash
      yc serverless workflow delete <имя_или_идентификатор_рабочего_процесса>
      ```

      Результат:

      ```text
      done (1s)
      ```

- API {#api}

  Чтобы удалить [рабочий процесс](../../../concepts/workflows/workflow.md), воспользуйтесь методом REST API [Delete](../../../../serverless-integrations/workflows/api-ref/Workflow/delete.md) для ресурса [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) или вызовом gRPC API [workflow/Delete](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/delete.md).

{% endlist %}