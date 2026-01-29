---
title: How to delete an MCP server
description: Follow this guide to learn how to delete MCP servers from {{ mcp-hub-name }}.
---

# Deleting an MCP server from {{ mcp-hub-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

To delete an MCP server from [{{ mcp-hub-name }}](../../concepts/mcp-hub/index.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `serverless.mcpGateways.editor` [role](../../security/index.md#serverless-mcpGateways-editor) or higher.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. In the left-hand panel, select ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **{{ ui-key.yacloud.yagpt.YaGPT.mcp-servers-list-title_snWTf }}**.
  1. In the list that opens, next to the MCP server you want to delete, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the deletion.

- cURL {#curl}

  1. [Get an IAM token](../../../iam/operations/index.md#authentication), which is required for [authentication](../../api-ref/authentication.md).
  1. Save the [IAM token](../../../iam/concepts/authorization/iam-token.md) to an environment variable:

      ```bash
      export IAM_TOKEN="<IAM_token_contents>"
      ```
  1. {% include [api-list-mcp-servers](../../../_includes/ai-studio/mcp-hub/api-list-mcp-servers.md) %}

      Save the MCP server's `id`. You will need it to send a deletion request.
  1. Use the [McpGateway.Delete](../../mcp-gateway/api-ref/McpGateway/delete.md) REST API method to delete the selected MCP server by specifying its ID:

      {% note info %}

      To delete an MCP server, your account must have the `serverless.mcpGateways.editor` [role](../../security/index.md#serverless-mcpGateways-editor) or higher for the folder containing the MCP server.

      {% endnote %}

      ```bash
      curl \
        --request DELETE \
        --header "Authorization: Bearer $IAM_TOKEN" \
        "https://serverless-mcp-gateway.{{ api-host }}/mcpgateway/v1/mcpGateways/<MCP_server_ID>"
      ```

      {% cut "Result" %}

      ```json
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.serverless.mcpgateway.v1.DeleteMcpGatewayMetadata",
        "mcpGatewayId": "db82gpat2rsc********"
      },
      "id": "db8p2dihieai********",
      "description": "Delete MCP Gateway",
      "createdAt": "2025-12-24T12:05:59.101410969Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2025-12-24T12:05:59.101410969Z"
      }
      ```

      {% endcut %}

  1. Use the [McpGateway.List](../../mcp-gateway/api-ref/McpGateway/list.md) REST API method again to make sure the MCP server has been deleted.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)