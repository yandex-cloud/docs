---
title: Как принудительно остановить запуск рабочего процесса
description: Следуя данной инструкции, вы сможете принудительно остановить запуск рабочего процесса.
---

# Принудительно остановить запуск рабочего процесса

Если принудительно остановить запуск [рабочего процесса](../../../concepts/workflows/workflow.md), текущий активный шаг будет прерван. Чтобы остановить запуск рабочего процесса после выполнения текущего активного шага, воспользуйтесь инструкцией [{#T}](stop.md).

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для принудительной остановки запуска рабочего процесса:

      ```bash
      yc serverless workflow execution terminate --help
      ```

  1. {% include [get-executions-list](../../../../_includes/serverless-integrations/get-executions-list.md) %}
  1. Принудительно остановите запуск рабочего процесса:

      ```bash
      yc serverless workflow execution terminate <идентификатор_запуска_рабочего_процесса>
      ```

      Результат:

      ```text
      execution_id: dfqmeu8ci1ae2tvocsbv-429e9f6f-b506-4c5a-84b2-9abb********
      ```

- API {#api}

  Чтобы принудительно остановить запуск рабочего процесса, воспользуйтесь методом REST API [terminate](../../../workflows/api-ref/Execution/terminate.md) для ресурса [Execution](../../../workflows/api-ref/Execution/index.md) или вызовом gRPC API [ExecutionService/Terminate](../../../workflows/api-ref/grpc/Execution/terminate.md).

{% endlist %}