---
title: Как остановить запуск рабочего процесса
description: Следуя данной инструкции, вы сможете остановить запуск рабочего процесса.
---

# Остановить запуск рабочего процесса

Если остановить запуск [рабочего процесса](../../../concepts/workflows/workflow.md), {{ sw-name }} сначала дождется завершения текущего активного шага. Чтобы прервать текущий активный шаг, воспользуйтесь инструкцией [{#T}](terminate.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором [запущен рабочий процесс](./start.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}** и выберите рабочий процесс.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.serverless-workflows.label_workflow-executions }}**.
  1. В строке с нужным запуском нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/circle-stop.svg) **{{ ui-key.yacloud.serverless-workflows.label_stop-workflow }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для остановки запуска рабочего процесса:

      ```bash
      yc serverless workflow execution stop --help
      ```

  1. {% include [get-executions-list](../../../../_includes/serverless-integrations/get-executions-list.md) %}
  1. Остановите запуск рабочего процесса:

      ```bash
      yc serverless workflow execution stop <идентификатор_запуска_рабочего_процесса>
      ```

      Результат:

      ```text
      execution_id: dfqmeu8ci1ae2tvocsbv-429e9f6f-b506-4c5a-84b2-9abb********
      ```

- API {#api}

  Чтобы остановить запуск рабочего процесса, воспользуйтесь методом REST API [stop](../../../workflows/api-ref/Execution/stop.md) для ресурса [Execution](../../../workflows/api-ref/Execution/index.md) или вызовом gRPC API [ExecutionService/Stop](../../../workflows/api-ref/grpc/Execution/stop.md).

{% endlist %}