---
title: Как указать облачную сеть, в которой будет выполняться рабочий процесс
description: Следуя данной инструкции, вы сможете указать облачную сеть, в которой будет выполняться рабочий процесс.
---

# Указать облачную сеть, в которой будет выполняться рабочий процесс

Вы можете указать облачную сеть, в которой будет выполняться рабочий процесс.

{% include [network](../../../../_includes/functions/network.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. В строке с нужным рабочим процессом нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Раскройте блок **{{ ui-key.yacloud.serverless-workflows.label_additional-parameters }}** и в поле **{{ ui-key.yacloud.serverless-workflows.label_network }}** укажите нужную сеть.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

    Чтобы указать облачную сеть, выполните команду:

    ```bash
    yc serverless workflow update <имя_или_идентификатор_рабочего_процесса> \
      --yaml-spec <файл_спецификации> \
      --network-id <идентификатор_сети>
    ```

    Где:

    * `--yaml-spec` — путь к файлу с [YaWL-спецификацией](../../../concepts/workflows/yawl/index.md) рабочего процесса. Например: `./yawl-spec.json`.
    * `--network-id` — идентификатор облачной сети, в которой будет выполняться рабочий процесс.

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

  Чтобы указать облачную сеть, воспользуйтесь методом REST API [Update](../../../../serverless-integrations/workflows/api-ref/Workflow/update.md) для ресурса [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) или вызовом gRPC API [workflow/Update](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/update.md).

{% endlist %}