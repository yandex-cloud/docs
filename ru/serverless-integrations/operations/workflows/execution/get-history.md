---
title: Как получить детальную информацию о выполнении каждого шага рабочего процесса
description: Следуя данной инструкции, вы сможете посмотреть детальную информацию о выполнении каждого шага рабочего процесса {{ sw-full-name }}.
---

# Получить детальную информацию о выполнении каждого шага рабочего процесса

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [запуск рабочего процесса](../../../concepts/workflows/execution.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}** и выберите рабочий процесс.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.serverless-workflows.label_workflow-executions }}** и выберите запуск.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/timeline.svg) **{{ ui-key.yacloud.serverless-workflows.label_timeline }}**. На странице **{{ ui-key.yacloud.serverless-workflows.label_timeline }}** отобразится диаграмма шагов запуска рабочего процесса.
  1. Нажмите на полосу нужного шага. В нижней части экрана на вкладках **{{ ui-key.yacloud.common.overview }}**, **{{ ui-key.yacloud.serverless-workflows.label_input-data }}** и **{{ ui-key.yacloud.serverless-workflows.label_output-data }}** отобразится детальная информация о выполнении шага.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра информации о [запуске рабочего процесса](../../../concepts/workflows/execution.md):

      ```bash
      yc serverless workflow execution get-history --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. {% include [get-executions-list](../../../../_includes/serverless-integrations/get-executions-list.md) %}
  1. Получите подробную детальную информацию о выполнении каждого шага запуска рабочего процесса, указав идентификатор запуска:

      ```bash
      yc serverless workflow execution get-history <идентификатор_запуска>
      ```

      Результат:

      ```text
      id: dfq...e78
      workflow_id: dfqud9cbc4k5********
      status: FINISHED
      started_at: "2025-03-10T15:54:44.304781814Z"
      duration: 1.070697344s
      entries:
        - id: fetch_posts
          started_at: "2025-03-10T15:54:44.452347159Z"
          duration: 0.795435385s
          input:
            input_json: '{"input":{}}'
          output:
            output_json:
            ...
          status: COMPLETED
          type: HttpCall
          attempts: "1"
        ...
        - id: fetch_users
          started_at: "2025-03-10T15:54:44.452394388Z"
          duration: 0.751175310s
          input:
            input_json: '{"input":{}}'
          output:
            output_json:
            ...
          status: COMPLETED
          type: HttpCall
          attempts: "1"
      ```

- API {#api}

  Чтобы получить детальную информацию о выполнении каждого шага [запуска рабочего процесса](../../../concepts/workflows/execution.md), воспользуйтесь методом REST API [getHistory](../../../../serverless-integrations/workflows/api-ref/Execution/getHistory.md) для ресурса [Execution](../../../../serverless-integrations/workflows/api-ref/Execution/index.md) или вызовом gRPC API [WorkflowsService/GetHistory](../../../../serverless-integrations/workflows/api-ref/grpc/Execution/getHistory.md).

{% endlist %}