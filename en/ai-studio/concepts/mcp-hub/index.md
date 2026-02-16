---
title: '{{ mcp-hub-name }} in {{ foundation-models-full-name }}'
description: '{{ mcp-hub-name }} is a {{ foundation-models-full-name }} tool for creating and managing MCP servers.'
---

# {{ mcp-hub-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

{{ foundation-models-full-name }} enables using MCP servers in AI agents to work with external systems to get additional context or perform actions, e.g., by calling an external [API](https://en.wikipedia.org/wiki/API).

_{{ mcp-hub-name }}_ is a {{ foundation-models-name }} tool for creating, managing, and monitoring MCP servers. {{ mcp-hub-name }} allows you to hook up external MCP servers or create your own either from scratch or using pre-configured templates.

{% include [roles-to-invoke-mcp](../../../_includes/ai-studio/mcp-hub/roles-to-invoke-mcp.md) %}

## MCP servers {#servers}

MCP servers enable large language models (LLMs) to integrate with third-party tools, such as APIs, databases, and various services that provide access to external information and allow handling complex tasks. MCP servers use the [MCP (Model Context Protocol)](https://modelcontextprotocol.io/docs/getting-started/intro) to ensure model communication with those third-party tools.

{% include [server-tool-number-notice](../../../_includes/ai-studio/mcp-hub/server-tool-number-notice.md) %}

The MCP enables you to:

* Integrate LLMs into enterprise systems, services, and internal knowledge bases.
* Provide models with standardized access to external data and tools.
* Streamline the development and scaling of LLM-based solutions.

### MCP transport methods {#transport}

The MCP supports communication through one of the following transport methods:

{% include [transportation-methods](../../../_includes/ai-studio/mcp-hub/transportation-methods.md) %}

### MCP server use cases {#mcp-use-cases}

MCP servers support the following use cases:

* Connecting models to [CRM](https://en.wikipedia.org/wiki/Customer_relationship_management) and [ERP](https://en.wikipedia.org/wiki/Enterprise_resource_planning) systems or internal storages.
* Using [AI](https://en.wikipedia.org/wiki/Artificial_intelligence) to automate business and operational workflows.
* Building field-specific AI assistants (legal, medical, technical, and more).
* Integrating with external APIs to access up-to-date information, such as news or exchange rates.

## Adding MCP servers in {{ mcp-hub-name }} {#adding-servers}

In {{ mcp-hub-name }}, you can add MCP servers in three ways: connect an existing external server, build a new server from a template, or build a new one from scratch.

To create an MCP server, you need the `serverless.mcpGateways.editor` [role](../../security/index.md#serverless-mcpGateways-editor) or higher.

### Connecting an external MCP server {#connect-external}

This approach works well if you have already deployed an external MCP server, e.g., on [smithery.ai](https://smithery.ai/), from [{{ marketplace-full-name }}]({{ link-cloud-marketplace }}), or on a {{ compute-full-name }} [VM](../../../compute/concepts/vm.md). To [add](../../operations/mcp-servers/connect-external.md) such an MCP server to {{ mcp-hub-name }}, provide the server address and authentication credentials. This will make it available for connection to agents.

For more information, see [{#T}](../../operations/mcp-servers/connect-external.md).

{% include [use-responses-api-example](../../../_includes/ai-studio/mcp-hub/use-responses-api-example.md) %}

### Building an MCP server from a template {#from-template}

{{ foundation-models-name }} offers some MCP server templates from external {{ yandex-cloud }} partners. You can use these in your AI agents to access these partners' services. To [add](../../operations/mcp-servers/create-from-template.md) such an MCP server to {{ mcp-hub-name }}, select the template you need and provide authentication credentials. This will make the server available for connection to your agents.

For more information, see [{#T}](../../operations/mcp-servers/create-from-template.md).

For the list of available templates, see [{#T}](./templates.md).

### Building an MCP server from scratch {#brand-new}

In {{ mcp-hub-name }}, you can manually [build a new MCP server](../../operations/mcp-servers/create-brand-new.md) featuring the following _tools_:

* [Function](../../../functions/concepts/function.md) in {{ sf-full-name }}: Enables you to run your code in one of the supported programming languages with the required dependencies within a managed [runtime environment](../../../functions/concepts/runtime/index.md). When you increase the number of function calls, {{ sf-full-name }} performs [autoscaling](../../../functions/concepts/function.md#scaling) and creates additional instances of your function.
* HTTP request: Enables you to access external [APIs](https://en.wikipedia.org/wiki/API). If your service already exposes an API, you can adapt it for MCP. Describe the available API methods, and they will be automatically converted for use in agents.
* [Workflow](../../../serverless-integrations/concepts/workflows/workflow.md) in {{ sw-full-name }}: Enables you to create complex workflows composed of interacting tools and services that implement their own control and error-handling logic and integrate these workflows with the agent.

For more information, see [{#T}](../../operations/mcp-servers/create-brand-new.md).

### General MCP server settings {#server-settings}

MCP servers in {{ mcp-hub-name }} can be either private or public.

Unauthenticated access to a private MCP server in a folder is only allowed for AI agents initiated by the user or service account assigned a [role](../../security/index.md#serverless-mcpGateways-invoker) permitting access to MCP servers in this folder. To connect to a private MCP server, other agents must authenticate using the service account's [IAM token](../../../iam/concepts/authorization/iam-token.md) or [API key](../../../iam/concepts/authorization/api-key.md) with `yc.serverless.mcpGateways.invoke` as the specified [scope](../../../iam/concepts/authorization/api-key.md#scoped-api-keys).

Public MCP servers allow unauthenticated access for all agents.

In the MCP server settings, you can enable [logging](../../../logging/concepts/log-group.md) to save server access information to a log.

#### See also {#see-also}

* [{#T}](./templates.md)
* [{#T}](../../operations/mcp-servers/connect-external.md)
* [{#T}](../../operations/mcp-servers/create-from-template.md)
* [{#T}](../../operations/mcp-servers/create-brand-new.md)
* [{#T}](../../operations/mcp-servers/get-server-info.md)
* [{#T}](../../operations/mcp-servers/delete-server.md)