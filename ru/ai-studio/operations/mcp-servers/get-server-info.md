---
title: Как посмотреть информацию об MCP-сервере
description: Следуя данной инструкции, вы научитесь просматривать информацию об MCP-серверах и их настройки в {{ mcp-hub-name }}.
---

# Посмотреть информацию об MCP-сервере в {{ mcp-hub-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

Чтобы посмотреть информацию об [MCP-сервере](../../../glossary/mcp.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужный MCP-сервер.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. На панели слева выберите ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **{{ ui-key.yacloud.yagpt.YaGPT.mcp-servers-list-title_snWTf }}** и в открывшемся списке выберите нужный MCP-сервер.
  1. В открывшемся окне посмотрите информацию о выбранном MCP-сервере:

      * На вкладке **{{ ui-key.yacloud.common.overview }}** вы можете посмотреть общую информацию об MCP-сервере: его имя, идентификатор, статус, дату создания, базовый URL, тип доступа, а также информацию о [сервисном аккаунте](../../../iam/concepts/users/service-accounts.md) и [облачной сети](../../../vpc/concepts/network.md#network), которые привязаны к MCP-серверу.

          Также на этой вкладке доступна информация о настройках логирования и добавленных на MCP-сервер инструментах и их настройках.

      * На вкладке **{{ ui-key.yacloud.common.monitoring }}** вы можете в режиме реального времени отслеживать [метрики](../../../monitoring/concepts/index.md) сессий доступа к MCP-серверу и использования его инструментов.

      * На вкладке **{{ ui-key.yacloud.common.logs }}** вы можете посмотреть логи работы MCP-сервера, если в его настройках включено [логирование](../../../logging/concepts/log-group.md).

      * На вкладке **{{ ui-key.yacloud.common.operations-key-value }}** вы можете посмотреть информацию об [операциях](../../../api-design-guide/concepts/async.md), выполненных или выполняемых с MCP-сервером.

- cURL {#curl}

  1. [Получите](../../../iam/operations/index.md#authentication) IAM-токен, необходимый для [аутентификации](../../api-ref/authentication.md).
  1. Сохраните полученный [IAM-токен](../../../iam/concepts/authorization/iam-token.md) в переменную окружения:

      ```bash
      export IAM_TOKEN="<содержимое_IAM_токена>"
      ```
  1. {% include [api-list-mcp-servers](../../../_includes/ai-studio/mcp-hub/api-list-mcp-servers.md) %}

      Сохраните идентификатор (значение поля `id`) нужного MCP-сервера. Он потребуется при отправке запроса на получение подробной информации о нем.
  1. Воспользуйтесь методом REST API [McpGateway.Get](../../mcp-gateway/api-ref/McpGateway/get.md), чтобы получить подробную информацию о выбранном MCP-сервере, указав его идентификатор:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        "https://ai.{{ api-host }}/mcpgateway/v1/mcpGateways/<идентификатор_MCP-сервера>"
      ```

      {% cut "Результат" %}

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

#### См. также {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)