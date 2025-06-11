---
title: How to update a workflow
description: Follow this guide to update a workflow.
---

# Updating a workflow

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to update a [workflow](../../../concepts/workflows/workflow.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Click ![image](../../../../_assets/console-icons/ellipsis.svg) in the workflow row and select ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Update workflow parameters in the YaML specification or using the constructor. For more information about configuring workflow steps using the constructor, see [{#T}](../constructor/index.md).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for updating a [workflow](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow update --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. In the command, specify the parameters to update, such as the workflow name:

      ```bash
      yc serverless workflow update \
        --yaml-spec <specification_file> \
        --name <workflow_name> \
        --new-name <new_workflow_name>
      ```

      Where:

      * `--yaml-spec`: Path to the [YaWL specification](../../../concepts/workflows/yawl/index.md) file for the workflow, e.g., `./yawl-spec.json`.
      * `--name`: Old workflow name.
      * `--new-name`: New workflow name.

      Result:

      ```text
      id: dfqjl5hh5p90********
      folder_id: b1g681qpemb4********
      specification:
        spec_yaml: "yawl: ..."
      created_at: "2025-03-11T09:27:51.691990Z"
      name: renamed-workflow
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

  To update a [workflow](../../../concepts/workflows/workflow.md), use the [Update](../../../../serverless-integrations/workflows/api-ref/Workflow/update.md) REST API method for the [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [workflow/Update](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/update.md) gRPC API call.

{% endlist %}