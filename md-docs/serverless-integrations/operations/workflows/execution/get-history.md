[Документация Yandex Cloud](../../../../index.md) > [Yandex Serverless Integrations](../../../index.md) > [Пошаговые инструкции](../../index.md) > Workflows > Получение информации о запуске рабочего процесса > Получить информацию о выполнении каждого шага

# Получить детальную информацию о выполнении каждого шага рабочего процесса

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [запуск рабочего процесса](../../../concepts/workflows/execution.md).
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **Workflows** и выберите рабочий процесс.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/bars-play.svg) **Запуски** и выберите запуск.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/timeline.svg) **Шкала времени**. На странице **Шкала времени** отобразится диаграмма шагов запуска рабочего процесса.
  1. Нажмите на полосу нужного шага. В нижней части экрана на вкладках **Обзор**, **Данные на входе** и **Данные на выходе** отобразится детальная информация о выполнении шага.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для просмотра информации о [запуске рабочего процесса](../../../concepts/workflows/execution.md):

      ```bash
      yc serverless workflow execution get-history --help
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

  Чтобы получить детальную информацию о выполнении каждого шага [запуска рабочего процесса](../../../concepts/workflows/execution.md), воспользуйтесь методом REST API [getHistory](../../../workflows/api-ref/Execution/getHistory.md) для ресурса [Execution](../../../workflows/api-ref/Execution/index.md) или вызовом gRPC API [WorkflowsService/GetHistory](../../../workflows/api-ref/grpc/Execution/getHistory.md).

{% endlist %}