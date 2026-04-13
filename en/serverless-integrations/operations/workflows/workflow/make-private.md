---
title: How to make a workflow private
description: Follow this guide to make a workflow private.
---

# Making a workflow private

By default, all workflows are private and can only be run by users who have permissions to run them. If you have made a workflow [public](make-public.md) and want to make it private again:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the [workflow](../../../concepts/workflows/workflow.md).
  1. [Go](../../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Select the workflow.
  1. Disable **{{ ui-key.yacloud.serverless-workflows.label_public-access }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for updating a [workflow](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow update --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. Make a workflow private:

      ```bash
      yc serverless workflow update \
        --name <workflow_name> \
        --remove-is-public
      ```

- API {#api}

  To make a [workflow](../../../concepts/workflows/workflow.md) private, use the [Update](../../../../serverless-integrations/workflows/api-ref/Workflow/update.md) REST API method for the [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [workflow/Update](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/update.md) gRPC API call with `isPublic: false`.

{% endlist %}
