---
title: How to create a workflow using a YaWL specification
description: Follow this guide to create a workflow using a YaWL specification.
---

# Creating a workflow using a YaWL specification

## Preparing a YaWL specification {#prepare-spec}

Save the workflow [YaWL specification](../../../concepts/workflows/yawl/index.md) to a YAML file, e.g., `yawl-spec.yaml`.

Specification example:

```yaml
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


## Creating a workflow {#create-workflow}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [workflow](../../../concepts/workflows/workflow.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. In the top-right corner, click **{{ ui-key.yacloud.serverless-workflows.button_create-workflow }}**.
  1. Choose the `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_text-editor }}` method.
  1. In the code editor, describe the workflow [YaWL specification](../../../concepts/workflows/yawl/index.md).
  1. {% include [workflows-additional-console](../../../../_includes/serverless-integrations/workflows-additional-console.md) %}
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a [workflow](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow create --help
      ```

  1. Create a workflow:

      ```bash
      yc serverless workflow create \
        --yaml-spec <specification_file> \
        --name <workflow_name> \
        --description "<workflow_description>" \
        --labels <label_list> \
        --network-id <network_ID> \
        --service-account-id <service_account_ID>
      ```

      Where:

      * `--yaml-spec`: Path to the [YaWL specification](../../../concepts/workflows/yawl/index.md) file for the workflow, e.g., `./yawl-spec.yaml`.
      * `--name`: Workflow name.
      * `--description`: Workflow description. This is an optional parameter.
      * `--labels`: List of labels. This is an optional parameter.

          You can specify one or more labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.

      * `--network-id`: ID of a cloud network where the workflow will run. This is an optional parameter.
      * `--service-account-id`: [Service account](../../../../iam/concepts/users/service-accounts.md) ID.

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

  To create a [workflow](../../../concepts/workflows/workflow.md), use the [Create](../../../../serverless-integrations/workflows/api-ref/Workflow/create.md) REST API method for the [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [WorkflowService/Create](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/create.md) gRPC API call.

{% endlist %}