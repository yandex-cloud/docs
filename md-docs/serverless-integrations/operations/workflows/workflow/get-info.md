[Документация Yandex Cloud](../../../../index.md) > [Yandex Serverless Integrations](../../../index.md) > [Пошаговые инструкции](../../index.md) > Workflows > Получение информации о рабочем процессе > Получить информацию о рабочем процессе

# Получить информацию о рабочем процессе

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **Workflows**.
  1. Выберите рабочий процесс. На странице **Обзор** отобразится подробная информация о рабочем процессе.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для просмотра информации о [рабочем процессе](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow get --help
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

  1. Получите подробную информацию о рабочем процессе, указав его имя или идентификатор:

      ```bash
      yc serverless workflow get <имя_или_идентификатор_рабочего_процесса>
      ```

      Результат:

      ```text
        workflow:
          id: dfqud9cbc4k5********
          folder_id: b1g681qpemb4********
          specification:
            spec_yaml: |
              yawl: "0.1"
              start: collect_info
              steps:
                collect_info:
                  parallel:
                    branches:
                      collect_users:
                        start: fetch_users
                        steps:
                          fetch_users:
                            httpCall:
                              url: https://jsonplaceholder.typicode.com/users
                              output: '\({users: .})'
                      collect_posts:
                        start: fetch_posts
                        steps:
                          fetch_posts:
                            httpCall:
                              url: https://jsonplaceholder.typicode.com/posts
                              output: '\({posts: .})'
          created_at: "2025-03-10T12:57:48.679682Z"
          name: workflow203
          status: ACTIVE
          log_options:
            folder_id: b1g681qpemb4********
      ```

- API {#api}

  Чтобы получить информацию о [рабочем процессе](../../../concepts/workflows/workflow.md), воспользуйтесь методом REST API [get](../../../workflows/api-ref/Workflow/get.md) для ресурса [Workflow](../../../workflows/api-ref/Workflow/index.md) или вызовом gRPC API [WorkflowsService/Get](../../../workflows/api-ref/grpc/Workflow/get.md).

{% endlist %}