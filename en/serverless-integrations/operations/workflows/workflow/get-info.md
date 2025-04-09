---
title: How to get information about a workflow
description: Follow this guide to get information about a {{ sw-full-name }} workflow.
---

# Getting information about a workflow

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the [workflow](../../../concepts/workflows/workflow.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Select a workflow. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the workflow.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to view information about a [workflow](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow get --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}

  1. Get detailed information about the workflow by specifying its name or ID:

      ```bash
      yc serverless workflow get <workflow_name_or_ID>
      ```

      Result:

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

  To get information about a [workflow](../../../concepts/workflows/workflow.md), use the [get](../../../../serverless-integrations/workflows/api-ref/Workflow/get.md) REST API method for the [Workflow](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [WorkflowsService/Get](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/get.md) gRPC API call.

{% endlist %}