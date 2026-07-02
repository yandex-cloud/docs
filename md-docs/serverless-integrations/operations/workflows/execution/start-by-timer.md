[Документация Yandex Cloud](../../../../index.md) > [Yandex Serverless Integrations](../../../index.md) > [Пошаговые инструкции](../../index.md) > Workflows > Управление запуском рабочего процесса > Запустить рабочий процесс > По таймеру

# Запустить рабочий процесс по таймеру

Вы можете задать расписание при [создании](../workflow/create-yawl.md) или [изменении](../workflow/update.md) рабочего процесса.


## Задать расписание {#add-schedule}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **Workflows**.
  1. В строке с нужным рабочим процессом нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. На графической схеме рабочего процесса нажмите на блок **Старт**.
  1. Задайте расписание в формате [cron-выражения](../../../concepts/cron.md) и выберите часовой пояс.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения [рабочего процесса](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow update --help
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
  1. Задайте расписание:

      ```bash
      yc serverless workflow update <имя_или_идентификатор_рабочего_процесса> \
        --schedule-cron-expression "<cron-выражение>" \
        --schedule-timezone "<часовой_пояс>"
      ```

      Где:
      
      * `--schedule-cron-expression` — cron-выражение, например: `"0 * * * * *"`. Подробнее о формате cron-выражений в [Cron-выражения в Serverless Integrations](../../../concepts/cron.md).
      * `--schedule-timezone` — часовой пояс, например `Europe/Moscow`.

      Результат:

      ```text
      id: dfqai557kgv0********
      folder_id: b1g681qpemb4********
      specification:
        spec_yaml: ...
      created_at: "2025-09-19T09:11:38.826207Z"
      name: cron-flow
      status: ACTIVE
      log_options:
        folder_id: b1g681qpemb4********
      service_account_id: ajelprpohp7r********
      schedule:
        cron_expression: 0 * * * * *
        timezone: Europe/Moscow
      ```

- API {#api}

  Воспользуйтесь методом REST API [Update](../../../workflows/api-ref/Workflow/update.md) для ресурса [Workflows](../../../workflows/api-ref/Workflow/index.md) или вызовом gRPC API [workflow/Update](../../../workflows/api-ref/grpc/Workflow/update.md). В поле `schedule` задайте расписание и укажите часовой пояс.

{% endlist %}


## Удалить расписание {#remove-schedule}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **Workflows**.
  1. В строке с нужным рабочим процессом нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. На графической схеме рабочего процесса нажмите на блок **Старт**.
  1. Удалите расписание.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для изменения [рабочего процесса](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow update --help
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
  1. Удалите расписание:

      ```bash
      yc serverless workflow update <имя_или_идентификатор_рабочего_процесса> \
        --remove-schedule
      ```

      Результат:

      ```text
      id: dfqai557kgv0********
      folder_id: b1g681qpemb4********
      specification:
        spec_yaml: ...
      created_at: "2025-09-19T09:11:38.826207Z"
      name: cron-flow
      status: ACTIVE
      log_options:
        folder_id: b1g681qpemb4********
      service_account_id: ajelprpohp7r********
      ```

- API {#api}

  Воспользуйтесь методом REST API [Update](../../../workflows/api-ref/Workflow/update.md) для ресурса [Workflows](../../../workflows/api-ref/Workflow/index.md) или вызовом gRPC API [workflow/Update](../../../workflows/api-ref/grpc/Workflow/update.md). В поле `schedule` укажите `null`.

{% endlist %}

#### Полезные ссылки {#see-also}

* [Запуск рабочего процесса](../../../concepts/workflows/execution.md)
* [Получить список запусков рабочего процесса](get-list.md)