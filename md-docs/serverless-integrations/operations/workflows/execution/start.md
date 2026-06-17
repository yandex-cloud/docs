# Запустить рабочий процесс

Чтобы любой пользователь мог запустить рабочий процесс, сделайте его [публичным](../workflow/make-public.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите запустить [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева выберите ![GraphNode](../../../../_assets/console-icons/graph-node.svg) **Workflows**.
  1. Рядом с нужным рабочим процессом нажмите ![ellipsis](../../../../_assets/console-icons/ellipsis.svg) и выберите ![TriangleRight](../../../../_assets/console-icons/triangle-right.svg) **Запустить**.
  1. В открывшемся окне нажмите **Запустить** и дождитесь завершения рабочего процесса.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для запуска [рабочего процесса](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow execution start --help
      ```

  1. Получите список рабочих процессов:
     
     ```bash
     yc serverless workflow list
     ```
     
     Результат:
     
     ```text
     workflows:
       - id: dfqdi6ic7c5j********
         folder_id: b1g681qpemb4********
         created_at: "2025-03-10T13:31:55.387059Z"
         name: workflow895
         status: ACTIVE
         log_options:
           folder_id: b1g681qpemb4********
       ...
       - id: dfqud9cbc4k5********
         folder_id: b1g681qpemb4********
         created_at: "2025-03-10T12:57:48.679682Z"
         name: workflow203
         status: ACTIVE
         log_options:
           folder_id: b1g681qpemb4********
     ```
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

#### Полезные ссылки {#see-also}

* [Запуск рабочего процесса](../../../concepts/workflows/execution.md)
* [Получить список запусков рабочего процесса](get-list.md)