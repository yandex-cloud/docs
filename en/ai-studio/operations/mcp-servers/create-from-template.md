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

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `serverless.mcpGateways.editor` [role](../../security/index.md#serverless-mcpGateways-editor) or higher.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. In the left-hand panel, select ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **MCP servers**, and in the window that opens:

      1. Under **How to add**, select one of the [templates](../../concepts/mcp-hub/templates.md): [Kontur.Focus](https://kontur-inc.com/focus), [{{ tracker-full-name }}](https://360.yandex.ru/business/tracker/), [{{ search-api-full-name }}](../../../search-api/index.yaml), or [amoCRM](https://www.amocrm.com/).
      1. Under **Tools**:

          {% note tip %}

          To get an access token, visit the website of the service you are connecting.

          {% endnote %}

          {% include [create-server-add-external-steps](../../../_includes/ai-studio/mcp-hub/create-server-add-external-steps.md) %}

      1. Under **Server parameters**:

          1. {% include [create-server-console-general-params-ss1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss1.md) %}
          1. {% include [create-server-console-general-params-ss2](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss2.md) %}
          1. {% include [create-server-console-general-params-ss3](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss3.md) %}
          1. {% include [create-server-console-general-params-ss5](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss5.md) %}
      1. Click **Add**.

{% endlist %}

{% include [server-creation-result-phrase](../../../_includes/ai-studio/mcp-hub/server-creation-result-phrase.md) %}

#### See also {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)
* [{#T}](../../concepts/mcp-hub/templates.md)
* [{#T}](./connect-external.md)
* [{#T}](./create-brand-new.md)