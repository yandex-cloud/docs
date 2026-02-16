---
title: Как создать MCP-сервер в {{ mcp-hub-name }} из шаблона
description: Следуя данной инструкции, вы научитесь создавать MCP-серверы в {{ mcp-hub-name }} из готовых шаблонов через интерфейс {{ foundation-models-full-name }}.
---

# Создать MCP-сервер в {{ mcp-hub-name }} из шаблона

{% include [note-preview](../../../_includes/note-preview.md) %}

{{ foundation-models-full-name }} предлагает набор [шаблонов](../../concepts/mcp-hub/templates.md) MCP-серверов от внешних партнеров {{ yandex-cloud }}, которые вы можете использовать в ваших AI-агентах для доступа к сервисам этих партнеров.

{% note tip %}

{% include [roles-to-invoke-mcp](../../../_includes/ai-studio/mcp-hub/roles-to-invoke-mcp.md) %}

{% endnote %}

Чтобы добавить в [{{ mcp-hub-name }}](../../concepts/mcp-hub/index.md) MCP-сервер из готового шаблона:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть роли [`serverless.mcpGateways.editor`](../../security/index.md#serverless-mcpGateways-editor) и [`iam.serviceAccounts.user`](../../../iam/security/index.md#iam-serviceAccounts-user) или выше.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. На панели слева выберите ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **{{ ui-key.yacloud.yagpt.YaGPT.mcp-servers-list-title_snWTf }}** и нажмите кнопку **{{ ui-key.yacloud.yagpt.YaGPT.McpServersList.label_create-mcp-gateway_3o3Vu }}**. В открывшемся окне:

      1. В блоке **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.type_dZSaw }}** выберите один из [шаблонов](../../concepts/mcp-hub/templates.md): [Яндекс Поиск](../../../search-api/index.yaml), [amoCRM](https://www.amocrm.ru/), [{{ src-full-name }}]({{ link-src-docs }}), [Контур.Фокус](https://focus.kontur.ru) или [{{ tracker-full-name }}](https://360.yandex.ru/business/tracker/).
      1. В блоке **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.tools_gkQfS }}** нажмите кнопку **{{ ui-key.yacloud.yagpt.YaGPT.ConnectMcpTools.add-mcp-tool_dyEgv }}**. В открывшемся окне:

          1. В полях **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.transport_q3nD6 }}**, **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.url_bUhZ1 }}** и **Тип авторизации** отобразятся предварительно настроенные значения. Эти значения заданы по умолчанию для выбранного шаблона, изменить их нельзя.
          1. В блоках **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.auth-header_h6kre }}** и (для некоторых шаблонов) **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.headers_wBENR }}** задайте значения для заголовка авторизации и (при необходимости) для других заголовков.

                {% note tip %}

                Чтобы получить токен доступа, обратитесь на сайт подключаемого сервиса.

                {% endnote %}

          1. Нажмите кнопку **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.connect_xY9Zw }}**.
          1. {% include [create-server-console-choose-tools](../../../_includes/ai-studio/mcp-hub/create-server-console-choose-tools.md) %}

      1. В блоке **Параметры сервера**:

          1. {% include [create-server-console-general-params-ss1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss1.md) %}
          1. {% include [create-server-console-general-params-ss2](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss2.md) %}
          1. {% include [create-server-console-general-params-ss3](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss3.md) %}
          1. {% include [create-server-console-general-params-ss4](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss4.md) %}
          1. {% include [create-server-console-general-params-ss4-1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss4-1.md) %}
          1. {% include [create-server-console-general-params-ss5](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss5.md) %}
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

{% include [server-creation-result-phrase](../../../_includes/ai-studio/mcp-hub/server-creation-result-phrase.md) %}

#### См. также {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)
* [{#T}](../../concepts/mcp-hub/templates.md)