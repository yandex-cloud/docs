# Сделать рабочий процесс приватным

По умолчанию все рабочие процессы приватные, и их могут запускать только пользователи, у которых есть права на запуск рабочих процессов. Если вы сделали рабочий процесс [публичным](make-public.md), чтобы снова сделать его приватным:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **Workflows**.
  1. Выберите нужный рабочий процесс.
  1. Выключите опцию **Публичный рабочий процесс**.
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
  1. Сделайте рабочий процесс приватным:

      ```bash
      yc serverless workflow update \
        --name <имя_рабочего_процесса> \
        --remove-is-public
      ```

- API {#api}

  Чтобы сделать [рабочий процесс](../../../concepts/workflows/workflow.md) приватным, воспользуйтесь методом REST API [Update](../../../workflows/api-ref/Workflow/update.md) для ресурса [Workflows](../../../workflows/api-ref/Workflow/index.md) или вызовом gRPC API [workflow/Update](../../../workflows/api-ref/grpc/Workflow/update.md), установив параметр `isPublic: false`.

{% endlist %}