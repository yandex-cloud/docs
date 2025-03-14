---
title: Как получить информацию о рабочем процессе
description: Следуя данной инструкции, вы сможете получить информацию о рабочем процессе {{ sw-full-name }}.
---

# Получить информацию о рабочем процессе

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Выберите рабочий процесс. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о рабочем процессе.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра информации о [рабочем процессе](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow get --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}

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

  Чтобы получить информацию о [рабочем процессе](../../../concepts/workflows/workflow.md), воспользуйтесь методом REST API [get](../../../../serverless-integrations/workflows/api-ref/Workflow/get.md) для ресурса [Workflow](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) или вызовом gRPC API [WorkflowsService/Get](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/get.md).

{% endlist %}