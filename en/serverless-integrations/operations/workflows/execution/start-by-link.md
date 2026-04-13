---
title: How to execute a workflow via a link
description: Follow this guide to execute a workflow via a link.
---

# Executing a workflow via a link

## Getting a link for workflow execution {#get-link}

{% list tabs group=instructions %}

- Management console {#console}

    {% note info %}

    You can get a link for workflow execution using the management console only if the workflow is [public](../workflow/make-public.md).

    {% endnote %}

    1. In the [management console]({{ link-console-main }}), select the folder containing the workflow.
    1. [Go](../../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
    1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
    1. Select a workflow. The execution link will appear in the **{{ ui-key.yacloud.serverless-workflows.label_execution-url }}** field.

- CLI {#cli}

    To get an execution link, run this command:

    ```bash
    yc serverless workflow get <container_name>
    ```

    The execution link will appear in the `execution_url` field.

- API {#api}

  To get a workflow execution link, use the [get](../../../../serverless-integrations/workflows/api-ref/Workflow/get.md) REST API method for the [Workflow](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [WorkflowsService/Get](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/get.md) gRPC API call. The execution link will appear in the `execution_url` field.

{% endlist %}

## Executing a workflow via HTTPS {#https}

If the workflow is:
* [Public](../workflow/make-public.md), any user can run it.
* Private, the user needs to authenticate by providing the [{{ iam-short-name }} token](../../../../iam/concepts/authorization/iam-token.md) in the `Authorization` header in the following format:

    ```bash
    Authorization: Bearer <{{ iam-short-name }}_token>
    ```

To execute a workflow, send a POST request:

* Example of public workflow execution without providing the input data:

    ```bash
    curl -X POST "https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/fd2g4pu20roc********/start"
    ```

*  Example of private workflow execution without providing the input data:

    ```bash
    IAM_TOKEN="<{{ iam-short-name }}_token>"
    curl -X POST \
    --header "Authorization: Bearer $IAM_TOKEN" \
    "https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/dfq3l36kr2gh********/start"
    ```

* Example of public workflow execution with providing input data (the input data is passed to the workflow input unchanged):

    ```bash
    curl "https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/fd2g4pu20roc********/start" -d '{"hello": "world"}'
    ```

#### See also {#see-also}

* [{#T}](../../../concepts/workflows/execution.md)
* [{#T}](get-list.md)
