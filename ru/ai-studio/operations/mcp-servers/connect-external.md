---
title: Как подключить к {{ mcp-hub-name }} внешний MCP-сервер
description: Следуя данной инструкции, вы научитесь подключать к {{ mcp-hub-name }} через интерфейс {{ foundation-models-full-name }} действующие сторонние MCP-серверы.
---

# Подключить внешний MCP-сервер к {{ mcp-hub-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

Если у вас уже есть развернутый внешний MCP-сервер, например, на [smithery.ai](https://smithery.ai/), в [{{ marketplace-full-name }}]({{ link-cloud-marketplace }}) или на [виртуальной машине](../../../compute/concepts/vm.md) {{ compute-full-name }}, вы можете подключить его к [{{ mcp-hub-name }}](../../concepts/mcp-hub/index.md).

Чтобы добавить существующий внешний MCP-сервер в {{ mcp-hub-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть роли [`serverless.mcpGateways.editor`](../../security/index.md#serverless-mcpGateways-editor) и [`iam.serviceAccounts.user`](../../../iam/security/index.md#iam-serviceAccounts-user) или выше.
  1. В списке сервисов выберите **{{ ui-key.yacloud.dashboard.DashboardPage.AiStudioSection.section_title_1sDGx }}**.
  1. На панели слева выберите ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **{{ ui-key.yacloud.yagpt.YaGPT.mcp-servers-list-title_snWTf }}** и нажмите кнопку **{{ ui-key.yacloud.yagpt.YaGPT.McpServersList.label_create-mcp-gateway_3o3Vu }}**. В открывшемся окне:

      1. В блоке **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.type_dZSaw }}** выберите опцию ![plug-connection](../../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.form-view_connect_bS8yQ }}**.
      1. В блоке **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.tools_gkQfS }}** нажмите кнопку **{{ ui-key.yacloud.yagpt.YaGPT.ConnectMcpTools.add-mcp-tool_dyEgv }}** и в открывшемся окне:

          {% include [create-server-add-external-steps](../../../_includes/ai-studio/mcp-hub/create-server-add-external-steps.md) %}

      1. В блоке **Параметры сервера**:

          1. {% include [create-server-console-general-params-ss1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss1.md) %}
          1. {% include [create-server-console-general-params-ss2](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss2.md) %}
          1. {% include [create-server-console-general-params-ss3](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss3.md) %}
          1. {% include [create-server-console-general-params-ss4](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss4.md) %}
          1. {% include [create-server-console-general-params-ss4-1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss4-1.md) %}
          1. {% include [create-server-console-general-params-ss5](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss5.md) %}
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- cURL {#curl}

  {% note info %}

  Ниже приведен пример создания простого MCP-сервера, содержащего один инструмент. Чтобы создать MCP-сервер с несколькими инструментами, добавьте описания этих инструментов в виде отдельных [JSON](https://ru.wikipedia.org/wiki/JSON)-объектов в список `tools`. Подробнее о параметрах, доступных при создании MCP-сервера, читайте в справочнике API в разделе [McpGateway.Create](../../mcp-gateway/api-ref/McpGateway/create.md).

  {% endnote %}

  1. [Получите](../../../iam/operations/index.md#authentication) IAM-токен, необходимый для [аутентификации](../../api-ref/authentication.md).
  1. Сохраните полученный [IAM-токен](../../../iam/concepts/authorization/iam-token.md) в переменную окружения:

      ```bash
      export IAM_TOKEN="<содержимое_IAM_токена>"
      ```
  1. Создайте файл с телом запроса (например, `body.json`):

      **body.json**

      ```json
      {
        "folderId": "<идентификатор_каталога>",
        "name": "<имя_MCP-сервера>",
        "description": "<описание_MCP-сервера>",
        "serviceAccountId": "<идентификатор_сервисного_аккаунта>",
        "public": "true|false",
        "tools": [
          {
            "name": "<имя_инструмента>",
            "description": "<описание_инструмента>",
            "inputJsonSchema": "<JSON-схема_инструмента>",
            "action": {
              "mcpCall": {
                "url": "<URL_MCP-сервера>",
                "toolCall": {
                  "toolName": "<имя_инструмента>",
                  "parametersJson": "<передаваемые_параметры>"
                },
                "transport": "<транспортный_механизм>",
                "unauthorized": {}
              }
            }
          }
        ]
      }
      ```

      Где:

      * `folderId` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором создается MCP-сервер. Вашему аккаунту на этот каталог должны быть назначены роли [`serverless.mcpGateways.editor`](../../security/index.md#serverless-mcpGateways-editor) и [`iam.serviceAccounts.user`](../../../iam/security/index.md#iam-serviceAccounts-user) или выше.
      * `name` — имя создаваемого MCP-сервера. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}
      
      * `description` — произвольное описание MCP-сервера.
      * `serviceAccountId` — идентификатор [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого MCP-сервер будет работать с сервисами и ресурсами {{ yandex-cloud }}. Сервисному аккаунту должны быть назначены [роли](../../../iam/concepts/access-control/roles.md), достаточные для доступа к этим ресурсам и сервисам.
      * `public` — параметр, определяющий [тип](../../concepts/mcp-hub/index.md#server-settings) создаваемого сервера. Возможные значения:

          * `true` — чтобы создать публичный MCP-сервер.
          * `false` — чтобы создать приватный MCP-сервер.
      * `tools` — описание добавляемых в MCP-сервер инструментов:

          * `name` — имя добавляемого инструмента. Требования к имени:

              {% include [name-format](../../../_includes/name-format.md) %}

          * `description` — произвольное описание инструмента.
          * `inputJsonSchema` — [JSON](https://ru.wikipedia.org/wiki/JSON)-схема, описывающая входные параметры инструмента.

              {% include [create-server-json-scheme-example](../../../_includes/ai-studio/mcp-hub/create-server-json-scheme-example.md) %}

          * `action.mcpCall` — описание параметров, специфичных для настройки подключения внешнего MCP-сервера:

              * `url` — URL, по которому доступен внешний MCP-сервер. Например: `https://mcp.example.com`.
              * `toolName` — имя добавляемого инструмента. Требования к имени:

                  {% include [name-format](../../../_includes/name-format.md) %}

              * `parametersJson` — параметры, передаваемые в инструмент, в формате [jq-шаблона](https://jqlang.github.io/jq/manual/).
              * `transport` — тип транспортного механизма, который будет использоваться для взаимодействия с MCP-сервером. Доступные типы:

                  * [`STREAMABLE`](https://modelcontextprotocol.io/specification/2025-06-18/basic/transports#streamable-http) — современный и актуальный транспортный механизм. AI-агент сможет получать обновления (события) с сервера без необходимости поддерживать постоянное HTTP-соединение.
                  * [`SSE`](https://modelcontextprotocol.io/specification/2024-11-05/basic/transports#http-with-sse) — устаревший транспортный механизм. AI-агент сможет получать обновления с сервера через одно постоянное HTTP-соединение.
              * `"unauthorized": {}` — передайте это значение, если внешний MCP-сервер не требует аутентификации. Если аутентификация нужна, вместо поля `unauthorized` передайте в теле запроса заголовок авторизации `header` или поле `serviceAccount`. Подробнее читайте в справочнике API в разделе [McpGateway.Create](../../mcp-gateway/api-ref/McpGateway/create.md).

          {% cut "Пример тела запроса" %}

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

  1. Воспользуйтесь методом REST API [McpGateway.Create](../../mcp-gateway/api-ref/McpGateway/create.md), чтобы создать новый MCP-сервер в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --data "@body.json" \
        "https://serverless-mcp-gateway.{{ api-host }}/mcpgateway/v1/mcpGateways"
      ```

      Результат:

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

      Сохраните идентификатор созданного MCP-сервера (значение поля `mcpGatewayId`) — он понадобится на следующем шаге.
  1. Дождитесь завершения создания MCP-сервера и посмотрите подробную информацию о нем, указав его идентификатор, сохраненный на предыдущем шаге:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        "https://serverless-mcp-gateway.{{ api-host }}/mcpgateway/v1/mcpGateways/<идентификатор_MCP-сервера>"
      ```

      {% cut "Результат" %}

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

## Использовать {{ responses-api }} для обращения к внешнему MCP-серверу {#use-responses-api}

{% include [use-responses-api-example](../../../_includes/ai-studio/mcp-hub/use-responses-api-example.md) %}

#### См. также {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)