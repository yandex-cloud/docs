---
title: How to specify a cloud network in which to run a workflow
description: Follow this guide to specify a cloud network in which to run a workflow.
---

# Specifying a cloud network in which to run a workflow

You can specify a cloud network in which to run a workflow.

{% include [network](../../../../_includes/functions/network.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the [workflow](../../../concepts/workflows/workflow.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Click ![image](../../../../_assets/console-icons/ellipsis.svg) in the workflow row and select ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Expand the **{{ ui-key.yacloud.serverless-workflows.label_additional-parameters }}** section and specify the network in the **{{ ui-key.yacloud.serverless-workflows.label_network }}** field.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

    To specify a cloud network, run the command:

    ```bash
    yc serverless workflow update <workflow_name_or_ID> \
      --yaml-spec <specification_file> \
      --network-id <network_ID>
    ```

    Where:

    * `--yaml-spec`: Path to the [YaWL specification](../../../concepts/workflows/yawl/index.md) file for the workflow, e.g., `./yawl-spec.json`.
    * `--network-id`: ID of the cloud network the workflow will run in.

    Result:

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

  To specify a cloud network, use the [Update](../../../../serverless-integrations/workflows/api-ref/Workflow/update.md) REST API method for the [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [workflow/Update](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/update.md) gRPC API call.

{% endlist %}