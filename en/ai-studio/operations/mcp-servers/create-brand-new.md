---
title: How to create an MCP server from scratch in {{ mcp-hub-name }}
description: Follow this guide to learn how to create your own MCP servers in {{ mcp-hub-name }} from scratch using the {{ foundation-models-full-name }} interface.
---

# Creating an MCP server in {{ mcp-hub-name }} from scratch

{% include [note-preview](../../../_includes/note-preview.md) %}

In [{{ mcp-hub-name }}](../../concepts/mcp-hub/index.md), you can create new MCP servers from scratch containing tools such as an HTTPS request to an external API, a {{ sf-full-name }} [function](../../../functions/concepts/function.md), or a [workflow](../../../serverless-integrations/concepts/workflows/workflow.md) in {{ sw-full-name }}.

To create a new MCP server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the [`serverless.mcpGateways.editor`](../../security/index.md#serverless-mcpGateways-editor) and [`iam.serviceAccounts.user`](../../../iam/security/index.md#iam-serviceAccounts-user) roles or higher.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. In the left-hand panel, select ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **{{ ui-key.yacloud.yagpt.YaGPT.mcp-servers-list-title_snWTf }}** and click **{{ ui-key.yacloud.yagpt.YaGPT.McpServersList.label_create-mcp-gateway_3o3Vu }}**. In the window that opens:

      1. Under **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.type_dZSaw }}**, select ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.form-view_create_8RLHn }}**.
      1. Under **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.tools_gkQfS }}**, select the [type](../../concepts/mcp-hub/index.md#brand-new) of the tool you want to add to the MCP server: `{{ ui-key.yacloud.yagpt.YaGPT.HttpCallTool.http-tool_7afuQ }}`, `{{ ui-key.yacloud.yagpt.YaGPT.FunctionCallToolCard.function-tool_vSycC }}`, or `{{ ui-key.yacloud.yagpt.YaGPT.WorkflowCallToolCard.workflow-tool_k663q }}`:

          {% list tabs %}

          - HTTPS request

            1. In the **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.tool-name_1jNyn }}** field, enter a name for the new tool. Follow these naming requirements:

                {% include [name-format](../../../_includes/name-format.md) %}

            1. In the **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.instruct-for-agent_gXCHg }}** field, enter the required text description for the tool. This description must define conditions for the AI agent to use this tool. Here is an example:

                ```text
                A tool for creating tickets in a corporate task processing system. Use this 
                tool to log customer complaints, support requests, and 
                error reports. When using this tool, set the `queue`, `type`, `priority`, and `summary` parameters. 
                In the `queue` parameter (queue name), always provide the SUPPORT constant. In the `type` parameter (request 
                type), provide one of the following values: bug (error report), complaint (customer complaint) or 
                support-request (request for consultation). In the `priority` parameter, 
                provide one of these values: low, medium, or high. In the 
                `summary` parameter, provide a text describing the gist of the user request in their own words.
                ```
            1. In the **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.url_w32Uc }}** field, specify the endpoint for the HTTPS request.

                * You can use [jq templates](https://jqlang.github.io/jq/manual/) to add path parameters to the endpoint value. Here is an example:

                    ```text
                    {{ link-console-main }}/folders/\(.folder-id)
                    ```

                    In this example, the `folder-id` field must also be added to the **{{ ui-key.yacloud.yagpt.YaGPT.ToolParams.tool-params_d87zq }}** section of the MCP server settings.

                * To send query parameters of the endpoint request:

                    * Add relevantly named fields to the **{{ ui-key.yacloud.yagpt.YaGPT.ToolParams.tool-params_d87zq }}** section of the new MCP server settings, e.g., `country`, `city`, and `name`.
                    * Add relevant query parameters to the **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolCallParams.http-call-tool-call-params_tBsF4 }}** section of the new MCP server settings. Specify jq templates with the names of the fields mentioned above as values for the new query parameters, e.g., `\(.country)`, `\(.city)`, and `\(.name)`.
            1. In the **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.method_wzMu6 }}** field, select the HTTP request method: `{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.method_get_rrb42 }}`, `{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.method_post_omtdL }}`, `{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.method_delete_dzg1G }}`, `{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.method_patch_qxnSP }}`, `{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.method_options_oi6ea }}`, or `{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.method_head_1gdE5 }}`.
            1. Expand the **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.extra_3crF8 }}** section and specify the authentication data to provide in HTTPS requests:

                {% include [create-server-console-auth-params](../../../_includes/ai-studio/mcp-hub/create-server-console-auth-params.md) %}

            1. {% include [create-server-console-tool-params](../../../_includes/ai-studio/mcp-hub/create-server-console-tool-params.md) %}
            1. Under **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolCallParams.http-call-tool-call-params_tBsF4 }}**, configure the HTTPS request parameters:

                * Under **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolCallParams.http-call-tool-call-params_headers_8ziH9 }}**, specify the names and values ​​of the headers to provide in requests.
                * Under **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolCallParams.http-call-tool-call-params_query_aWDHd }}**, specify the names and values ​​of the parameters to provide in the request.
                * Under **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolCallParams.http-call-tool-call-params_body_pbgxV }}**, review an example of the request and modify it as needed.

                    {% include [empty-request-body](../../../_includes/ai-studio/mcp-hub/empty-request-body.md) %}

                {% include [https-req-supporting-templates](../../../_includes/ai-studio/mcp-hub/https-req-supporting-templates.md) %}

          - {{ sf-name }}

            1. In the **{{ ui-key.yacloud.yagpt.YaGPT.FunctionCallToolForm.tool-name_wys4v }}** field, enter a name for the new tool. Follow these naming requirements:

                {% include [name-format](../../../_includes/name-format.md) %}

            1. In the **{{ ui-key.yacloud.yagpt.YaGPT.FunctionCallToolForm.instruct-for-agent_qcH1R }}** field, enter the required text description for the tool. This description must define conditions for the AI agent to use this tool. Here is an example:

                ```text
                This tool recognizes text in an image transmitted in base64 encoding. In the recognized 
                text, the tool extracts "article":"quantity" pairs and returns them in JSON structure format.
                ```
            1. In the **{{ ui-key.yacloud.yagpt.YaGPT.FunctionCallToolForm.function_nqzGL }}** field, select the {{ sf-name }} [function](../../../functions/concepts/function.md) to process the requests and its [version](../../../functions/concepts/function.md#version).
            1. {% include [create-server-console-tool-params](../../../_includes/ai-studio/mcp-hub/create-server-console-tool-params.md) %}

            {% include [empty-request-body](../../../_includes/ai-studio/mcp-hub/empty-request-body.md) %}

          - {{ sw-name }}

            1. In the **{{ ui-key.yacloud.yagpt.YaGPT.WorkflowCallToolForm.tool-name_1by52 }}** field, enter a name for the new tool. Follow these naming requirements:

                {% include [name-format](../../../_includes/name-format.md) %}

            1. In the **{{ ui-key.yacloud.yagpt.YaGPT.WorkflowCallToolForm.instruct-for-agent_3aVyw }}** field, enter the required text description for the tool. This description must define conditions for the AI agent to use this tool. Here is an example:

                ```text
                This tool invokes a workflow to automatically summarize long text. Provides 
                the source text, maximum summation length, and language.
                ```
            1. In the **{{ ui-key.yacloud.yagpt.YaGPT.WorkflowCallToolForm.workflow_oHNAL }}** field, select the {{ sw-name }} [workflow](../../../serverless-integrations/concepts/workflows/workflow.md) to process the requests.
            1. {% include [create-server-console-tool-params](../../../_includes/ai-studio/mcp-hub/create-server-console-tool-params.md) %}

            {% include [empty-request-body](../../../_includes/ai-studio/mcp-hub/empty-request-body.md) %}

          {% endlist %}

      1. To add an additional tool to the MCP server, click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.yagpt.YaGPT.Tools.add-tool_86ss3 }}**.

          {% include [server-tool-number-notice](../../../_includes/ai-studio/mcp-hub/server-tool-number-notice.md) %}

      1. Under **Server parameters**:

          1. {% include [create-server-console-general-params-ss1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss1.md) %}
          1. {% include [create-server-console-general-params-ss2](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss2.md) %}
          1. {% include [create-server-console-general-params-ss3](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss3.md) %}
          1. {% include [create-server-console-general-params-ss4](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss4.md) %}
          1. {% include [create-server-console-general-params-ss4-1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss4-1.md) %}
          1. {% include [create-server-console-general-params-ss5](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss5.md) %}
      1. Click **{{ ui-key.yacloud.common.save }}**.

- cURL {#curl}

  {% note info %}

  The example below demonstrates how to create a simple MCP server with a single tool, an HTTPS request. To create an MCP server with multiple tools, add the descriptions of these tools as separate [JSON](https://en.wikipedia.org/wiki/JSON) objects into the `tools` list. For more information about the parameters used to create an MCP server, see [McpGateway.Create](../../mcp-gateway/api-ref/McpGateway/create.md) in the API reference.

  {% endnote %}

  1. [Get an IAM token](../../../iam/operations/index.md#authentication), which is required for [authentication](../../api-ref/authentication.md).
  1. Save the [IAM token](../../../iam/concepts/authorization/iam-token.md) to an environment variable:

      ```bash
      export IAM_TOKEN="<IAM_token_contents>"
      ```
  1. Create a file with the request body, e.g., `body.json`:

      **body.json**

      ```json
      {
        "folderId": "<folder_ID>",
        "name": "<MCP_server_name>",
        "description": "<MCP_server_description>",
        "serviceAccountId": "<service_account_ID>",
        "public": "true|false",
        "tools": [
          {
            "name": "<tool_name>",
            "description": "<tool_description>",
            "inputJsonSchema": "<tool_JSON_schema>",
            "action": {
              "httpCall": {
                "url": "<endpoint_URL>",
                "method": "<HTTP_method>",
                "body": "<request_body>",
                "headers": {
                  "header1": "<header1_value>",
                  "header2": "<header2_value>"
                },
                "query": {
                  "parameter1": "<parameter1_value>"
                },
                "useServiceAccount": "true|false"
              }
            }
          }
        ]
      }
      ```

      Where:

      * `folderId`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) the MCP server is created in. Make sure to assign the [`serverless.mcpGateways.editor`](../../security/index.md#serverless-mcpGateways-editor) and [`iam.serviceAccounts.user`](../../../iam/security/index.md#iam-serviceAccounts-user) roles or higher for this folder to your account.
      * `name`: Name of the new MCP server. Follow these naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}
      
      * `description`: Description of the new MCP server.
      * `serviceAccountId`: ID of the [service account](../../../iam/concepts/users/service-accounts.md) your MCP server will use to access {{ yandex-cloud }} services and resources. The service account should get the [roles](../../../iam/concepts/access-control/roles.md) sufficient to access these resources and services.
      * `public`: [Type](../../concepts/mcp-hub/index.md#server-settings) of the new server. The possible values are:

          * `true`: To create a public MCP server.
          * `false`: To create a private MCP server.
      * `tools`: Description of the tools you add to the MCP server:

          * `name`: Tool name. Follow these naming requirements:

              {% include [name-format](../../../_includes/name-format.md) %}

          * `description`: Tool description.
          * `inputJsonSchema`: [JSON](https://en.wikipedia.org/wiki/JSON) schema describing the tool's input parameters.

              {% include [create-server-json-scheme-example](../../../_includes/ai-studio/mcp-hub/create-server-json-scheme-example.md) %}

          * `action.httpCall`: Description of configuration parameters for a tool of the `HTTPS request` [type](../../concepts/mcp-hub/index.md#brand-new).

              * `url`: URL to send the requests to, e.g., `https://example.com`.
              * `method`: Request method. The possible values are `OPTIONS`, `GET`, `HEAD`, `POST`, `PUT`, `PATCH`, `DELETE`, `TRACE`, and `CONNECT`.
              * `body`: HTTP request body. 
              * `headers`: List of `name:value` pairs of the headers to provide in requests.
              * `query`: List of `name:value` pairs of the query parameters to provide with requests.
              * `useServiceAccount`: If set to `true`, requests will be authenticated using an [IAM token](../../../iam/concepts/authorization/iam-token.md) issued for the [service account](../../../iam/concepts/users/service-accounts.md) attached to the MCP server.

              {% include [https-req-supporting-templates](../../../_includes/ai-studio/mcp-hub/https-req-supporting-templates.md) %}

          {% cut "Request body example" %}

          ```json
          {
            "folderId": "b1gt6g8ht345********",
            "name": "my-mcp-server",
            "description": "My sample MCP-server implementing an HTTPS tool",
            "serviceAccountId": "ajegtlf2q28a********",
            "public": "true",
            "tools": [
              {
                "name": "the-https-tool",
                "description": "My HTTPS tool",
                "inputJsonSchema": "{\"type\":\"object\",\"properties\":{\"location\":{\"type\":\"string\",\"description\":\"City name or zip code\"},\"name\":{\"type\":\"string\",\"description\":\"Full name\"}},\"required\":[\"location\",\"name\"]}",
                "action": {
                  "httpCall": {
                    "url": "https://example.com",
                    "method": "GET",
                    "body": "\\( . )",
                    "headers": {
                      "location": "\\(.location)",
                      "name": "\\(.name)"
                    },
                    "query": {
                      "name": "\\(.name)"
                    },
                    "useServiceAccount": "false"
                  }
                }
              }
            ]
          }
          ```

          {% endcut %}

  1. Use the [McpGateway.Create](../../mcp-gateway/api-ref/McpGateway/create.md) REST API method to create a new MCP server in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --data "@body.json" \
        "https://serverless-mcp-gateway.{{ api-host }}/mcpgateway/v1/mcpGateways"
      ```

      Result:

      ```
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.serverless.mcpgateway.v1.CreateMcpGatewayMetadata",
        "mcpGatewayId": "db8f3fgm7vq1********",
        "folderId": "b1gt6g8ht345********"
      },
      "id": "db8h3djc7vjt********",
      "description": "Create MCP Gateway",
      "createdAt": "2025-12-24T06:38:31.834344392Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2025-12-24T06:38:31.834344392Z"
      }
      ```

      Save the new MCP server's ID (the `mcpGatewayId` field value) for the next step.
  1. Wait until the MCP server is created, then view its details by specifying the ID you saved in the previous step:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        "https://serverless-mcp-gateway.{{ api-host }}/mcpgateway/v1/mcpGateways/<MCP_server_ID>"
      ```

      {% cut "Result" %}

      ```json
      {
        "tools": [
          {
            "action": {
              "httpCall": {
                "headers": {
                  "location": "\\(.location)",
                  "name": "\\(.name)"
                },
                "query": {
                  "name": "\\(.name)"
                },
                "useServiceAccount": false,
                "url": "https://example.com",
                "method": "GET",
                "body": "\\( . )"
              }
            },
            "name": "the-https-tool",
            "description": "My HTTPS tool",
            "inputJsonSchema": "{\"type\":\"object\",\"properties\":{\"location\":{\"type\":\"string\",\"description\":\"City name or zip code\"},\"name\":{\"type\":\"string\",\"description\":\"Full name\"}},\"required\":[\"location\",\"name\"]}"
          }
        ],
        "logOptions": {
          "disabled": false
        },
        "public": true,
        "id": "db8f3fgm7vq1********",
        "folderId": "b1gt6g8ht345********",
        "createdAt": "2025-12-24T06:38:31.884226Z",
        "name": "my-mcp-server",
        "description": "My sample MCP-server implementing an HTTPS tool",
        "status": "ACTIVE",
        "baseDomain": "https://db8f3fgm7vq1********.ibiatp37.mcpgw.serverless.yandexcloud.net",
        "serviceAccountId": "ajegtlf2q28a********",
        "cloudId": "b1gia87mbaom********"
      }
      ```

      {% endcut %}

{% endlist %}

{% include [server-creation-result-phrase](../../../_includes/ai-studio/mcp-hub/server-creation-result-phrase.md) %}

#### See also {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)