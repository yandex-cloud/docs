---
title: How to view information about an MCP server
description: Follow this guide to learn how to view information about MCP servers and their settings in {{ mcp-hub-name }}.
---

# Viewing information about an MCP server in {{ mcp-hub-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

To view information about an MCP server:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your MCP server.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. In the left-hand panel, select ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **{{ ui-key.yacloud.yagpt.YaGPT.mcp-servers-list-title_snWTf }}** and select the MCP server from the list that opens.
  1. In the window that opens, view the selected MCP server's info:

      * On the **{{ ui-key.yacloud.common.overview }}** tab, you can view some general information on the MCP server, including its name, ID, status, creation date, base URL, access type, and information about the [service account](../../../iam/concepts/users/service-accounts.md) and [cloud network](../../../vpc/concepts/network.md#network) associated with this MCP server.

          This tab also gives information about the logging settings, tools added to the MCP server, and their settings.

      * On the **{{ ui-key.yacloud.common.monitoring }}** tab, you can monitor the MCP server's real-time access session and tool [metrics](../../../monitoring/concepts/index.md).

      * On the **{{ ui-key.yacloud.common.logs }}** tab, you can view the MCP server's logs, if [logging](../../../logging/concepts/log-group.md) is enabled in its settings.

      * On the **{{ ui-key.yacloud.common.operations-key-value }}** tab, you can view the information about the MCP server's past and current operations.

- cURL {#curl}

  1. [Get an IAM token](../../../iam/operations/index.md#authentication), which is required for [authentication](../../api-ref/authentication.md).
  1. Save the [IAM token](../../../iam/concepts/authorization/iam-token.md) to an environment variable:

      ```bash
      export IAM_TOKEN="<IAM_token_contents>"
      ```
  1. {% include [api-list-mcp-servers](../../../_includes/ai-studio/mcp-hub/api-list-mcp-servers.md) %}

      Save the MCP server's `id`. You will need later to request detailed information about the server.
  1. Use the [McpGateway.Get](../../mcp-gateway/api-ref/McpGateway/get.md) REST API method to get detailed information about the selected MCP server by specifying its ID:

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
            "toolName": "web_search_post",
            "parametersJson": "\\( . )"
          },
          "header": {
            "headerName": "ApiKey",
            "headerValue": "AQVNzoyHxiIXq********-_Aip6c2Oo3********"
          },
          "forwardHeaders": {
            "FolderId": "b1gt6g8ht345********"
          },
          "url": "https://d5dj4o5pbnqg********.cmxivbes.apigw.yandexcloud.net:3000/sse",
          "transport": "SSE"
          }
        },
        "name": "web_search_post",
        "description": "Perform web search (preferred).\n\nUse this tool when the user needs to search online and the search query is simple. minimal example:     \"body_application_json\": {\"query\": \u003cyour question\u003e, \"search_region\": \u003csearch_region\u003e}\n",
        "inputJsonSchema": "{\"properties\":{\"body_application_json\":{\"description\":\"Required request body containing all search parameters.\\n\",\"properties\":{\"query\":{\"description\":\"Required. The search query string to be executed against the Yandex search database.\",\"type\":\"string\"},\"search_region\":{\"default\":\"tr\",\"description\":\"Required. Search region. Valid values: 'tr' - Turkish region/query, 'en' - Not turkish region/query\",\"enum\":[\"tr\",\"en\"],\"type\":\"string\"}},\"type\":\"object\"}},\"type\":\"object\"}"
        }
      ],
      "logOptions": {
        "disabled": true
      },
      "public": true,
      "id": "db82gpat2rsc********",
      "folderId": "b1gt6g8ht345********",
      "createdAt": "2025-12-18T14:00:39.911359Z",
      "name": "search-api-mcp",
      "status": "ACTIVE",
      "baseDomain": "https://db82gpat2rsc********.58zke0qh.mcpgw.serverless.yandexcloud.net",
      "serviceAccountId": "ajegtlf2q28a********",
      "cloudId": "b1gia87mbaom********"
      }
      ```

      {% endcut %}

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)