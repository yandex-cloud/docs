# Прекратить запуск рабочего процесса

Если прекратить запуск [рабочего процесса](../../../concepts/workflows/workflow.md), текущий активный шаг будет прерван. Чтобы остановить запуск рабочего процесса после выполнения текущего активного шага, воспользуйтесь инструкцией [Остановить запуск рабочего процесса](stop.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором [запущен рабочий процесс](start.md).
  1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **Workflows** и выберите рабочий процесс.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/bars-play.svg) **Запуски**.
  1. В строке с нужным запуском нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/circle-xmark.svg) **Прекратить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для прекращения запуска рабочего процесса:

      ```bash
      yc serverless workflow execution terminate --help
      ```

  1. Получите список запусков рабочего процесса, указав идентификатор рабочего процесса:
     
     ```bash
     yc serverless workflow execution list --workflow-id <идентификатор_рабочего_процесса>
     ```
     
     Результат:
     
     ```text
     executions:
       - id: dfq...e78
         workflow_id: dfqud9cbc4k5********
         status: FINISHED
         started_at: "2025-03-10T15:54:44.304781814Z"
         duration: 1.070697344s
       ...
       - id: dfq...4d5
         workflow_id: dfqud9cbc4k5********
         status: FINISHED
         started_at: "2025-03-10T15:05:19.982768956Z"
         duration: 0.971907165s
     ```
  1. Прекратите запуск рабочего процесса:

      ```bash
      yc serverless workflow execution terminate <идентификатор_запуска_рабочего_процесса>
      ```

      Результат:

      ```text
      execution_id: dfqmeu8ci1ae2tvocsbv-429e9f6f-b506-4c5a-84b2-9abb********
      ```

- API {#api}

  Чтобы прекратить запуск рабочего процесса, воспользуйтесь методом REST API [terminate](../../../workflows/api-ref/Execution/terminate.md) для ресурса [Execution](../../../workflows/api-ref/Execution/index.md) или вызовом gRPC API [ExecutionService/Terminate](../../../workflows/api-ref/grpc/Execution/terminate.md).

{% endlist %}