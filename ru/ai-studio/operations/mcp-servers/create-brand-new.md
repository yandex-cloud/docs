---
title: Как с нуля создать MCP-сервер в {{ mcp-hub-name }}
description: Следуя данной инструкции, вы научитесь с нуля создавать собственные MCP-серверы в {{ mcp-hub-name }} через интерфейс {{ foundation-models-full-name }}.
---

# Создать MCP-сервер в {{ mcp-hub-name }} с нуля

{% include [note-preview](../../../_includes/note-preview.md) %}

В [{{ mcp-hub-name }}](../../concepts/mcp-hub/index.md) вы можете с нуля создавать новые MCP-серверы, содержащие такие инструменты, как HTTPS-запрос к внешнему API, [функция](../../../functions/concepts/function.md) {{ sf-full-name }} или [рабочий процесс](../../../serverless-integrations/concepts/workflows/workflow.md) {{ sw-full-name }}.

{% note tip %}

{% include [roles-to-invoke-mcp](../../../_includes/ai-studio/mcp-hub/roles-to-invoke-mcp.md) %}

{% endnote %}

Чтобы создать новый MCP-сервер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть роли [`serverless.mcpGateways.editor`](../../security/index.md#serverless-mcpGateways-editor) и [`iam.serviceAccounts.user`](../../../iam/security/index.md#iam-serviceAccounts-user) или выше.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. На панели слева выберите ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **{{ ui-key.yacloud.yagpt.YaGPT.mcp-servers-list-title_snWTf }}** и нажмите кнопку **{{ ui-key.yacloud.yagpt.YaGPT.McpServersList.label_create-mcp-gateway_3o3Vu }}**. В открывшемся окне:

      1. В блоке **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.type_dZSaw }}** выберите опцию ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.form-view_create_8RLHn }}**.
      1. В блоке **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.tools_gkQfS }}** выберите [тип](../../concepts/mcp-hub/index.md#brand-new) добавляемого в MCP-сервер инструмента — `{{ ui-key.yacloud.yagpt.YaGPT.HttpCallTool.http-tool_7afuQ }}`, `{{ ui-key.yacloud.yagpt.YaGPT.FunctionCallToolCard.function-tool_vSycC }}` или `{{ ui-key.yacloud.yagpt.YaGPT.WorkflowCallToolCard.workflow-tool_k663q }}`:

          {% list tabs %}

          - HTTPS-запрос

            1. В поле **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.tool-name_1jNyn }}** задайте имя для создаваемого инструмента. Требования к имени:

                {% include [name-format](../../../_includes/name-format.md) %}

            1. В поле **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.instruct-for-agent_gXCHg }}** задайте обязательное текстовое описание инструмента. Описание должно содержать информацию об условиях, при которых AI-агент должен использовать этот инструмент. Например:

                ```text
                Инструмент для создания тикетов в корпоративной системе обработки задач. Используй этот 
                инструмент, чтобы регистрировать жалобы клиентов, запросы на получение консультаций, отчеты 
                об ошибках. При использовании инструмента задавай параметры queue, type, priority и summary. 
                В параметре queue (имя очереди) всегда передавай константу SUPPORT. В параметре type (тип 
                обращения) передавай одно из значений: bug (отчет об ошибке), complaint (жалоба клиента) или 
                support-request (запрос на получение консультации). В параметре priority (приоритет) 
                передавай одно из значений: low (низкий), medium (средний) или high (высокий). В параметре 
                summary передавай значение в виде текста, описывающего суть обращения словами пользователя.
                ```
            1. В поле **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.url_w32Uc }}** укажите эндпоинт, на который будет отправляться HTTPS-запрос.

                * Чтобы добавить path-параметры в значение эндпоинта, вы можете использовать [jq-шаблоны](https://jqlang.github.io/jq/manual/). Например:

                    ```text
                    {{ link-console-main }}/folders/\(.folder-id)
                    ```

                    В указанном примере поле `folder-id` также должно быть добавлено в блоке **{{ ui-key.yacloud.yagpt.YaGPT.ToolParams.tool-params_d87zq }}** настроек MCP-сервера.

                * Чтобы передавать query-параметры в запросе на эндпоинт:

                    * Добавьте поля с нужными именами в блоке **{{ ui-key.yacloud.yagpt.YaGPT.ToolParams.tool-params_d87zq }}** настроек создаваемого MCP-сервера. Например: `country`, `city` и `name`.
                    * Добавьте нужные query-параметры в блоке **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolCallParams.http-call-tool-call-params_tBsF4 }}** настроек создаваемого MCP-сервера. В качестве значений добавляемых query-параметров укажите jq-шаблоны с именами заданных выше полей. Например: `\(.country)`, `\(.city)` и `\(.name)`.
            1. В поле **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.method_wzMu6 }}** выберите HTTP-метод запроса: `{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.method_get_rrb42 }}`, `{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.method_post_omtdL }}`, `{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.method_delete_dzg1G }}`, `{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.method_patch_qxnSP }}`, `{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.method_options_oi6ea }}` или `{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.method_head_1gdE5 }}`.
            1. Разверните блок **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolForm.extra_3crF8 }}** и укажите аутентификационные данные, которые будут передаваться в HTTPS-запросах:

                {% include [create-server-console-auth-params](../../../_includes/ai-studio/mcp-hub/create-server-console-auth-params.md) %}

            1. {% include [create-server-console-tool-params](../../../_includes/ai-studio/mcp-hub/create-server-console-tool-params.md) %}
            1. В блоке **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolCallParams.http-call-tool-call-params_tBsF4 }}** настройте параметры HTTPS-запросов:

                * В секции **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolCallParams.http-call-tool-call-params_headers_8ziH9 }}** укажите имена и значения заголовков, которые будут передаваться в запросах.
                * В секции **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolCallParams.http-call-tool-call-params_query_aWDHd }}** задайте имена и значения параметров, которые будут передаваться в запросе.
                * В секции **{{ ui-key.yacloud.yagpt.YaGPT.HttpCallToolCallParams.http-call-tool-call-params_body_pbgxV }}** посмотрите пример получившегося запроса и при необходимости скорректируйте его.

                    {% include [empty-request-body](../../../_includes/ai-studio/mcp-hub/empty-request-body.md) %}

                {% include [https-req-supporting-templates](../../../_includes/ai-studio/mcp-hub/https-req-supporting-templates.md) %}

          - {{ sf-name }}

            1. В поле **{{ ui-key.yacloud.yagpt.YaGPT.FunctionCallToolForm.tool-name_wys4v }}** задайте имя для создаваемого инструмента. Требования к имени:

                {% include [name-format](../../../_includes/name-format.md) %}

            1. В поле **{{ ui-key.yacloud.yagpt.YaGPT.FunctionCallToolForm.instruct-for-agent_qcH1R }}** задайте обязательное текстовое описание инструмента. Описание должно содержать информацию об условиях, при которых AI-агент должен использовать этот инструмент. Например:

                ```text
                Инструмент распознает текст на изображении, передаваемом в кодировке base64. В распознанном 
                тексте инструмент выделяет пары "артикул":"количество" и возвращает в формате JSON-структуры.
                ```
            1. В поле **{{ ui-key.yacloud.yagpt.YaGPT.FunctionCallToolForm.function_nqzGL }}** выберите [функцию](../../../functions/concepts/function.md) {{ sf-name }}, которая будет выполнять обработку запросов, и ее [версию](../../../functions/concepts/function.md#version).
            1. {% include [create-server-console-tool-params](../../../_includes/ai-studio/mcp-hub/create-server-console-tool-params.md) %}

            {% include [empty-request-body](../../../_includes/ai-studio/mcp-hub/empty-request-body.md) %}

          - {{ sw-name }}

            1. В поле **{{ ui-key.yacloud.yagpt.YaGPT.WorkflowCallToolForm.tool-name_1by52 }}** задайте имя для создаваемого инструмента. Требования к имени:

                {% include [name-format](../../../_includes/name-format.md) %}

            1. В поле **{{ ui-key.yacloud.yagpt.YaGPT.WorkflowCallToolForm.instruct-for-agent_3aVyw }}** задайте обязательное текстовое описание инструмента. Описание должно содержать информацию об условиях, при которых AI-агент должен использовать этот инструмент. Например:

                ```text
                Инструмент вызывает рабочий процесс для автоматической суммаризации длинного текста. Передает 
                исходный текст, максимальную длину суммаризации и язык.
                ```
            1. В поле **{{ ui-key.yacloud.yagpt.YaGPT.WorkflowCallToolForm.workflow_oHNAL }}** выберите [рабочий процесс](../../../serverless-integrations/concepts/workflows/workflow.md) {{ sw-name }}, который будет выполнять обработку запросов.
            1. {% include [create-server-console-tool-params](../../../_includes/ai-studio/mcp-hub/create-server-console-tool-params.md) %}

            {% include [empty-request-body](../../../_includes/ai-studio/mcp-hub/empty-request-body.md) %}

          {% endlist %}

      1. Чтобы добавить в MCP-сервер дополнительный инструмент, нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.yagpt.YaGPT.Tools.add-tool_86ss3 }}**.

          {% include [server-tool-number-notice](../../../_includes/ai-studio/mcp-hub/server-tool-number-notice.md) %}

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

  Ниже приведен пример создания простого MCP-сервера, содержащего один инструмент — HTTPS-запрос. Чтобы создать MCP-сервер с несколькими инструментами, добавьте описания этих инструментов в виде отдельных [JSON](https://ru.wikipedia.org/wiki/JSON)-объектов в список `tools`. Подробнее о параметрах, доступных при создании MCP-сервера, читайте в справочнике API в разделе [McpGateway.Create](../../mcp-gateway/api-ref/McpGateway/create.md).

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
              "httpCall": {
                "url": "<URL_эндпоинта>",
                "method": "<HTTP-метод>",
                "body": "<тело_запроса>",
                "headers": {
                  "header1": "<значение_заголовка_header1>",
                  "header2": "<значение_заголовка_header2>"
                },
                "query": {
                  "parameter1": "<значение_параметра_parameter1>"
                },
                "useServiceAccount": "true|false"
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

          * `action.httpCall` — описание параметров, специфичных для настройки инструмента [типа](../../concepts/mcp-hub/index.md#brand-new) `HTTPS-запрос`:

              * `url` — URL, на который будут отправляться запросы. Например: `https://example.com`.
              * `method` — метод запроса. Возможные значения: `OPTIONS`, `GET`, `HEAD`, `POST`, `PUT`, `PATCH`, `DELETE`, `TRACE` и `CONNECT`.
              * `body` — содержимое тела HTTPS-запроса. 
              * `headers` — список пар `имя:значение` заголовков, которые будут передаваться в запросах.
              * `query` — список пар `имя:значение` query-параметров, которые будут передаваться с запросами.
              * `useServiceAccount` — если значение параметра `true`, для аутентификации запроса будет передаваться [IAM-токен](../../../iam/concepts/authorization/iam-token.md), выпущенный для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), который привязан к MCP-серверу.

              {% include [https-req-supporting-templates](../../../_includes/ai-studio/mcp-hub/https-req-supporting-templates.md) %}

          {% cut "Пример тела запроса" %}

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

#### См. также {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)