---
title: Как удалить MCP-сервер
description: Следуя данной инструкции, вы научитесь удалять MCP-серверы из {{ mcp-hub-name }}.
---

# Удалить MCP-сервер из {{ mcp-hub-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

Чтобы удалить MCP-сервер из [{{ mcp-hub-name }}](../../concepts/mcp-hub/index.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть [роль](../../security/index.md#serverless-mcpGateways-editor) `serverless.mcpGateways.editor` или выше.
  1. В списке сервисов выберите **{{ ui-key.yacloud.dashboard.DashboardPage.AiStudioSection.section_title_1sDGx }}**.
  1. На панели слева выберите ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **{{ ui-key.yacloud.yagpt.YaGPT.mcp-servers-list-title_snWTf }}**.
  1. В открывшемся списке в строке с MCP-сервером, который вы хотите удалить, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление.

- cURL {#curl}

  1. [Получите](../../../iam/operations/index.md#authentication) IAM-токен, необходимый для [аутентификации](../../api-ref/authentication.md).
  1. Сохраните полученный [IAM-токен](../../../iam/concepts/authorization/iam-token.md) в переменную окружения:

      ```bash
      export IAM_TOKEN="<содержимое_IAM_токена>"
      ```
  1. {% include [api-list-mcp-servers](../../../_includes/ai-studio/mcp-hub/api-list-mcp-servers.md) %}

      Сохраните идентификатор (значение поля `id`) нужного MCP-сервера. Он потребуется при отправке запроса на удаление.
  1. Воспользуйтесь методом REST API [McpGateway.Delete](../../mcp-gateway/api-ref/McpGateway/delete.md), чтобы удалить выбранный MCP-сервер, указав его идентификатор:

      {% note info %}

      Чтобы удалить MCP-сервер, у вашего аккаунта должна быть [роль](../../security/index.md#serverless-mcpGateways-editor) `serverless.mcpGateways.editor` или выше на каталог, в котором находится этот MCP-сервер.

      {% endnote %}

      ```bash
      curl \
        --request DELETE \
        --header "Authorization: Bearer $IAM_TOKEN" \
        "https://serverless-mcp-gateway.{{ api-host }}/mcpgateway/v1/mcpGateways/<идентификатор_MCP-сервера>"
      ```

      {% cut "Результат" %}

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

  1. Повторно воспользуйтесь методом REST API [McpGateway.List](../../mcp-gateway/api-ref/McpGateway/list.md), чтобы убедиться, что MCP-сервер был удален.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)