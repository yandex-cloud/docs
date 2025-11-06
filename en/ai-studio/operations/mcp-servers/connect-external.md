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

  1. In the [management console]({{ link-console-main }}), select a folder for which your account has the [`serverless.mcpGateways.editor`](../../security/index.md#serverless-mcpGateways-editor) and [`serverless.mcpGateways.anonymousInvoker`](../../security/index.md#serverless-mcpGateways-anonymousInvoker) roles or higher.
  1. In the list of services, select **{{ ui-key.yacloud.dashboard.DashboardPage.AiStudioSection.section_title_1sDGx }}**.
  1. In the left-hand panel, select ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **MCP servers** and click **Create MCP server**. In the window that opens, do the following:

      1. Under **Add Method**, select ![plug-connection](../../../_assets/console-icons/plug-connection.svg) **Connect**.
      1. Under **Tools**, click **Add tools** and in the window that opens:

          {% include [create-server-add-external-steps](../../../_includes/ai-studio/mcp-hub/create-server-add-external-steps.md) %}

      1. Under **Server parameters**:

          1. {% include [create-server-console-general-params-ss1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss1.md) %}
          1. {% include [create-server-console-general-params-ss2](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss2.md) %}
          1. {% include [create-server-console-general-params-ss3](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss3.md) %}
          1. {% include [create-server-console-general-params-ss4](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss4.md) %}
          1. {% include [create-server-console-general-params-ss4-1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss4-1.md) %}
          1. {% include [create-server-console-general-params-ss5](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss5.md) %}
      1. Click **Save**.

{% endlist %}

{% include [server-creation-result-phrase](../../../_includes/ai-studio/mcp-hub/server-creation-result-phrase.md) %}

## Using the {{ responses-api }} to access an external MCP server {#use-responses-api}

{% include [use-responses-api-example](../../../_includes/ai-studio/mcp-hub/use-responses-api-example.md) %}

#### See also {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)
* [{#T}](./create-from-template.md)
* [{#T}](./create-brand-new.md)