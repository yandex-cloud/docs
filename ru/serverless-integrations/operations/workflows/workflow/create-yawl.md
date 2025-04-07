---
title: Как создать рабочий процесс с помощью YaWL-спецификации
description: Следуя данной инструкции, вы сможете создать рабочий процесс с помощью YaWL-спецификации.
---

# Создать рабочий процесс с помощью YaWL-спецификации

## Подготовить YaWL-спецификацию {#prepare-spec}

Сохраните [YaWL-спецификацию](../../../concepts/workflows/yawl/index.md) рабочего процесса в JSON-файле, например `yawl-spec.json`.

Пример спецификации:

```json
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
```


## Создать рабочий процесс {#create-workflow}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.serverless-workflows.button_create-workflow }}**.
  1. Выберите способ `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_text-editor }}`.
  1. В редакторе кода опишите [YaWL-спецификацию](../../../concepts/workflows/yawl/index.md) рабочего процесса.
  1. {% include [workflows-additional-console](../../../../_includes/serverless-integrations/workflows-additional-console.md) %}
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания [рабочего процесса](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow create --help
      ```

  1. Создайте рабочий процесс:

      ```bash
      yc serverless workflow create \
        --yaml-spec <файл_спецификации> \
        --name <имя_рабочего_процесса> \
        --description "<описание_процесса>" \
        --labels <список_меток> \
        --network-id <идентификатор_сети> \
        --service-account-id <идентификатор_сервисного_аккаунта>
      ```

      Где:

      * `--yaml-spec` — путь к файлу с [YaWL-спецификацией](../../../concepts/workflows/yawl/index.md) рабочего процесса. Например: `./yawl-spec.json`.
      * `--name` — имя рабочего процесса.
      * `--description` — описание рабочего процесса. Необязательный параметр.
      * `--labels` — список меток. Необязательный параметр.

          Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

      * `--network-id` — идентификатор облачной сети, в которой будет выполняться рабочий процесс. Необязательный параметр.
      * `--service-account-id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md).

      Результат:

      ```text
      id: dfqjl5hh5p90********
      folder_id: b1g681qpemb4********
      specification:
        spec_yaml: "yawl: ..."
      created_at: "2025-03-11T09:27:51.691990Z"
      name: my-workflow
      description: created via cli
      labels:
        owner: "admin"
        version: "alpha"
      status: ACTIVE
      log_options: {}
      service_account_id: aje4tpd9coa********
      network_id: enpm8v48ehcl********
      ```

- API {#api}

  Чтобы создать [рабочий процесс](../../../concepts/workflows/workflow.md), воспользуйтесь методом REST API [Create](../../../../serverless-integrations/workflows/api-ref/Workflow/create.md) для ресурса [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) или вызовом gRPC API [workflow/Create](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/create.md).

{% endlist %}