---
title: How to build an MCP server from a template in {{ mcp-hub-name }}
description: Follow this guide to learn how to build MCP servers in {{ mcp-hub-name }} from ready-made templates via the {{ foundation-models-full-name }} interface.
---

# Building an MCP server from a template in {{ mcp-hub-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

{{ foundation-models-full-name }} offers some MCP server [templates](../../concepts/mcp-hub/templates.md) from external {{ yandex-cloud }} partners. You can use these in your AI agents to access these partners’ services.

To add a ready-made template-based MCP server to [{{ mcp-hub-name }}](../../concepts/mcp-hub/index.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the [`serverless.mcpGateways.editor`](../../security/index.md#serverless-mcpGateways-editor) and [`iam.serviceAccounts.user`](../../../iam/security/index.md#iam-serviceAccounts-user) roles or higher.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. In the left-hand panel, select ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **{{ ui-key.yacloud.yagpt.YaGPT.mcp-servers-list-title_snWTf }}** and click **{{ ui-key.yacloud.yagpt.YaGPT.McpServersList.label_create-mcp-gateway_3o3Vu }}**. In the window that opens:

      1. Under **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.type_dZSaw }}**, select one of these [templates](../../concepts/mcp-hub/templates.md): [Yandex Search](../../../search-api/index.yaml), [amoCRM](https://www.amocrm.com/), [{{ src-full-name }}]({{ link-src-docs }}), [Kontur.Focus](https://kontur-inc.com/focus), or [{{ tracker-full-name }}](https://360.yandex.ru/business/tracker/).
      1. Under **{{ ui-key.yacloud.yagpt.YaGPT.CreateMcpServerForm.tools_gkQfS }}**, click **{{ ui-key.yacloud.yagpt.YaGPT.ConnectMcpTools.add-mcp-tool_dyEgv }}**. In the window that opens:

          1. The **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.transport_q3nD6 }}**, **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.url_bUhZ1 }}**, and **Authorization type** fields will show the preset values. These are default values for the selected template and cannot be changed.
          1. Under **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.auth-header_h6kre }}** and (for some templates) **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.headers_wBENR }}**, specify values for the authorization header and (if required) other headers.

                {% note tip %}

                To get an access token, visit the website of the service you are connecting.

                {% endnote %}

          1. Click **{{ ui-key.yacloud.yagpt.YaGPT.McpCallToolForm.connect_xY9Zw }}**.
          1. {% include [create-server-console-choose-tools](../../../_includes/ai-studio/mcp-hub/create-server-console-choose-tools.md) %}

      1. Under **Server parameters**:

          1. {% include [create-server-console-general-params-ss1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss1.md) %}
          1. {% include [create-server-console-general-params-ss2](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss2.md) %}
          1. {% include [create-server-console-general-params-ss3](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss3.md) %}
          1. {% include [create-server-console-general-params-ss4](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss4.md) %}
          1. {% include [create-server-console-general-params-ss4-1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss4-1.md) %}
          1. {% include [create-server-console-general-params-ss5](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss5.md) %}
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

{% include [server-creation-result-phrase](../../../_includes/ai-studio/mcp-hub/server-creation-result-phrase.md) %}

#### See also {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)
* [{#T}](../../concepts/mcp-hub/templates.md)