---
title: Updating a workflow label
description: Follow this guide to update a workflow label.
---

# Updating a workflow label

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  To update a [workflow](../../../concepts/workflows/workflow.md) label, run this command:

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

  To update a [workflow](../../../concepts/workflows/workflow.md) label, use the [Update](../../../../serverless-integrations/workflows/api-ref/Workflow/update.md) REST API method for the [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [workflow/Update](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/update.md) gRPC API call.

{% endlist %}