---
title: Как сделать рабочий процесс публичным
description: Следуя данной инструкции, вы сможете сделать рабочий процесс публичным.
---

# Сделать рабочий процесс публичным

Сделайте рабочий процесс публичным, чтобы любой пользователь мог запустить его.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Выберите нужный рабочий процесс.
  1. Включите опцию **{{ ui-key.yacloud.serverless-workflows.label_public-access }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения [рабочего процесса](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow update --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. Сделайте рабочий процесс публичным:

      ```bash
      yc serverless workflow update \
        --name <имя_рабочего_процесса> \
        --set-is-public
      ```

- API {#api}

  Чтобы сделать [рабочий процесс](../../../concepts/workflows/workflow.md) публичным, воспользуйтесь методом REST API [Update](../../../../serverless-integrations/workflows/api-ref/Workflow/update.md) для ресурса [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) или вызовом gRPC API [workflow/Update](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/update.md), установив параметр `isPublic: true`.

{% endlist %}
