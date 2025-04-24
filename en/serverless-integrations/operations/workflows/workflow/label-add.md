---
title: Adding a label to a workflow
description: Follow this guide to add label to a workflow.
---

# Adding a label to a workflow

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to add a label to a [workflow](../../../concepts/workflows/workflow.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Click ![image](../../../../_assets/console-icons/ellipsis.svg) in the workflow row and select ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Expand **{{ ui-key.yacloud.serverless-workflows.label_additional-parameters }}**:

      1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
      1. Enter the key and the value, and press **Enter**.

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  To add a label to a [workflow](../../../concepts/workflows/workflow.md), run this command:

  {% include [labels-rewrite-warning](../../../../_includes/labels-rewrite-warning.md) %}

  ```bash
  yc serverless workflow update <workflow_name_or_ID> \
    --yaml-spec <specification_file> \
    --labels <label_list>
  ```

  Where:

  * `--yaml-spec`: Path to the [YaWL specification](../../../concepts/workflows/yawl/index.md) file for the workflow, e.g., `./yawl-spec.json`.
  * `--labels`: List of labels. You can specify one label or multiple labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.

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

  To add a label to a [workflow](../../../concepts/workflows/workflow.md), use the [Update](../../../../serverless-integrations/workflows/api-ref/Workflow/update.md) REST API method for the [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [workflow/Update](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/update.md) gRPC API call.

{% endlist %}