---
title: Как запустить рабочий процесс
description: Следуя данной инструкции, вы сможете запустить рабочий процесс.
---

# Запустить рабочий процесс

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите запустить [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева выберите ![GraphNode](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Рядом с нужным рабочим процессом нажмите ![ellipsis](../../../../_assets/console-icons/ellipsis.svg) и выберите ![TriangleRight](../../../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.serverless-workflows.label_run-workflow }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.start }}** и дождитесь завершения рабочего процесса.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для запуска [рабочего процесса](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow execution start --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. Запустите рабочий процесс, указав его имя или идентификатор:

      ```bash
      yc serverless workflow execution start <идентификатор_рабочего_процесса>
      ```

      Результат:

      ```text
      execution_id: dfqapb31gq758qil1r8b-b3e3dade-4903-4a6f-9df7-a4b6********
      ```

- API {#api}

  Чтобы запустить [рабочий процесс](../../../concepts/workflows/workflow.md), воспользуйтесь методом REST API [start](../../../workflows/api-ref/Execution/start.md) для ресурса [Execution](../../../workflows/api-ref/Execution/index.md) или вызовом gRPC API [ExecutionService/Start](../../../workflows/api-ref/grpc/Execution/start.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../../concepts/workflows/execution.md)
* [{#T}](get-list.md)