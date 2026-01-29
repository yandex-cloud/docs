---
title: How to connect an external MCP server to {{ mcp-hub-name }}
description: Follow this guide to learn how to connect third-party MCP servers to {{ mcp-hub-name }} through the {{ foundation-models-full-name }} interface.
---

# Connecting an external MCP server to {{ mcp-hub-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

If you already have deployed an external MCP server, e.g., on [smithery.ai](https://smithery.ai/), in [{{ marketplace-full-name }}]({{ link-cloud-marketplace }}), or on a {{ compute-full-name }} [VM](../../../compute/concepts/vm.md), you can connect it to [{{ mcp-hub-name }}](../../concepts/mcp-hub/index.md).

To add an existing external MCP server to {{ mcp-hub-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the [`serverless.mcpGateways.editor`](../../security/index.md#serverless-mcpGateways-editor) and [`iam.serviceAccounts.user`](../../../iam/security/index.md#iam-serviceAccounts-user) roles or higher.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. In the left-hand panel, select ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **{{ ui-key.yacloud.yagpt.YaGPT.mcp-servers-list-title_snWTf }}** and click **{{ ui-key.yacloud.yagpt.YaGPT.McpServersList.label_create-mcp-gateway_3o3Vu }}**. In the window that opens:

      1. Under **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.type_dZSaw }}**, select ![plug-connection](../../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.form-view_connect_bS8yQ }}**.
      1. Under **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.tools_gkQfS }}**, click **{{ ui-key.yacloud.yagpt.YaGPT.ConnectMcpTools.add-mcp-tool_dyEgv }}**, and in the window that opens:

          {% include [create-server-add-external-steps](../../../_includes/ai-studio/mcp-hub/create-server-add-external-steps.md) %}

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

  The example below demonstrates how to create a simple MCP server with a single tool. To create an MCP server with multiple tools, add the descriptions of these tools as separate [JSON](https://en.wikipedia.org/wiki/JSON) objects into the `tools` list. For more information about the parameters used to create an MCP server, see [McpGateway.Create](../../mcp-gateway/api-ref/McpGateway/create.md) in the API reference.

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
              "mcpCall": {
                "url": "<MCP_server_URL>",
                "toolCall": {
                  "toolName": "<tool_name>",
                  "parametersJson": "<input_parameters>"
                },
                "transport": "<transport_mechanism>",
                "unauthorized": {}
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

          * `action.httpCall`: Description of configuration parameters for connection to an external MCP server:

              * `url`: External MCP server URL, e.g., `https://mcp.example.com`.
              * `toolName`: Tool name. Follow these naming requirements:

                  {% include [name-format](../../../_includes/name-format.md) %}

              * `parametersJson`: Parameters fed into the tool, in [jq template](https://jqlang.github.io/jq/manual/) format.
              * `transport`: Transport mechanism type for interacting with the MCP server. Available types:

                  * [`STREAMABLE`](https://modelcontextprotocol.io/specification/2025-06-18/basic/transports#streamable-http): State-of-the-art transport mechanism. Your AI agent will be able to get updates (events) from the server without a persistent HTTP connection.
                  * [`SSE`](https://modelcontextprotocol.io/specification/2024-11-05/basic/transports#http-with-sse): Legacy transport mechanism. Your AI agent will be able to get updates from the server over the same persistent HTTP connection.
              * `"unauthorized": {}`: Provide this value if the external MCP server does not require authentication. If authentication is required, provide either the authorization `header` or `serviceAccount` field in the request body instead of `unauthorized`. For more information, see [McpGateway.Create](../../mcp-gateway/api-ref/McpGateway/create.md) in the API reference.

          {% cut "Request body example" %}

          ```json
          {
            "folderId": "b1gt6g8ht345********",
            "name": "my-external-mcp-server",
            "description": "my sample external MCP-server",
            "serviceAccountId": "ajegtlf2q28a********",
            "public": "true",
            "tools": [
              {
                "name": "tool-name",
                "description": "tool description",
                "inputJsonSchema": "{\"type\":\"object\",\"properties\":{\"location\":{\"type\":\"string\",\"description\":\"City name or zip code\"}},\"required\":[\"location\"]}",
                "action": {
                  "mcpCall": {
                    "url": "https://mcp.example.com",
                    "toolCall": {
                      "toolName": "tool-name",
                      "parametersJson": "//( . )"
                    },
                    "transport": "SSE",
                    "unauthorized": {}
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
          "mcpGatewayId": "db815a8nma7u********",
          "folderId": "b1gt6g8ht345********"
        },
        "id": "db8o404e7f2v********",
        "description": "Create MCP Gateway",
        "createdAt": "2025-12-22T18:04:42.776181560Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2025-12-22T18:04:42.776181560Z"
      }
      ```

      Save the new MCP server's ID (the `mcpGatewayId` field value) for the next step.
  1. Wait until the MCP server is created, then view its details by specifying the ID you saved in the previous step.

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
              "mcpCall": {
                "toolCall": {
                  "toolName": "tool-name",
                  "parametersJson": "//( . )"
                },
                "unauthorized": {},
                "url": "https://mcp.example.com",
                "transport": "SSE"
              }
            },
            "name": "tool-name",
            "description": "tool description",
            "inputJsonSchema": "{\"type\":\"object\",\"properties\":{\"location\":{\"type\":\"string\",\"description\":\"City name or zip code\"}},\"required\":[\"location\"]}"
          }
        ],
        "logOptions": {
          "disabled": false
        },
        "public": true,
        "id": "db815a8nma7u********",
        "folderId": "b1gt6g8ht345********",
        "createdAt": "2025-12-22T18:04:42.819804Z",
        "name": "my-external-mcp-server",
        "description": "my sample external MCP-server",
        "status": "ACTIVE",
        "baseDomain": "https://db815a8nma7u********.99igvxy3.mcpgw.serverless.yandexcloud.net",
        "serviceAccountId": "ajegtlf2q28a********",
        "cloudId": "b1gia87mbaom********"
      }
      ```

      {% endcut %}

{% endlist %}

{% include [server-creation-result-phrase](../../../_includes/ai-studio/mcp-hub/server-creation-result-phrase.md) %}

## Using the {{ responses-api }} to access an external MCP server {#use-responses-api}

{% include [use-responses-api-example](../../../_includes/ai-studio/mcp-hub/use-responses-api-example.md) %}

#### See also {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)