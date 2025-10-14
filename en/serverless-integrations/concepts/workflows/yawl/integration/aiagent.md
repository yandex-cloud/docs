---
title: AIAgent integration step
description: This article describes the fields for the AIAgent integration step.
---

# AIAgent

AI agent to help you put together your prompt to {{ yagpt-name }}.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- |--- | --- | --- | ---
`agentConfig`| [AIAgentConfig](#AIAgentConfig) | Yes | No | No | AI agent settings.
`tasks`| [AIAgentTask[]](#AIAgentTask) | Yes | No | No | Tasks the AI agent has to complete.

## AIAgentConfig object {#AIAgentConfig}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- |--- | --- | --- | ---
`goal`| `string` | Yes | No | Yes | Individual goal that guides the AI agent's decision-making. For example: "help with the choice of parts for the specified vehicle".
`role`| `string` | Yes | No | Yes | Role that defines the AI agent's functions and experience. For example: "car parts consultant".
`backstory`| `string` | No | No | Yes | Backstory defining the AI agent's personality and enriching the context. For example: "you find the best value for money car parts and briefly explain your choice".
`model`| [AIAgentModel](#AIAgentModel) | No | No | No | LLM the AI agent will use.
`knowledgeSources` | [KnowledgeSource[]](#KnowledgeSource) | No | No | No | AI agent’s knowledge sources.
`tools` | [AIAgentTool[]](#AIAgentTool) | No | No | No | Tools for your AI ​agent to use for obtaining external data when generating a response.

## AIAgentTask object {#AIAgentTask}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- |--- | --- | --- | ---
`description`| `string` | Yes | No | Yes | Description of the task you want the AI agent to perform. For example: "find an oil filter for a BMW 320i".
`result`| `string` | No | No | Yes | Description of what you expect to get. For example: "a list of addresses of stores selling the car parts you need".

## AIAgentModel object {#AIAgentModel}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- |--- | --- | --- | ---
`name`| `string` | No | `yagpt` | No | Model name. [List of available models](../../../../../ai-studio/concepts/generation/models.md#generation).

## KnowledgeSource object {#KnowledgeSource}

The `textSource` and `fileSource` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`textSource`| [TextKnowledgeSource](#TextKnowledgeSource) | No | No | No | Text-based knowledge source.
`fileSource`| [FileKnowledgeSource](#FileKnowledgeSource) | No | No | No | File-based knowledge source.

## TextKnowledgeSource object {#TextKnowledgeSource}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`content`| `string` | Yes | No | Yes | Text containing a knowledge source.

## FileKnowledgeSource object {#FileKnowledgeSource}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`type`| `string` | Yes | No | No | File type containing a knowledge source. Available types: `TEXT`, `JSON`, `CSV`, `PDF`, `EXCEL`.
`dataSource`| [DataSource](#DataSource) | Yes | No | No | Data source:

## DataSource object {#DataSource}

The `urlSource` and `objectStorageSource` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`urlSource`| [UrlDataSource](#UrlDataSource) | No | No | No | File accessible via a public URL.
`objectStorageSource`| [ObjectStorageDataSource](#ObjectStorageDataSource) | No | No | No | File residing in an {{ objstorage-name }} [bucket](../../../../../storage/concepts/bucket.md).

## UrlDataSource object {#UrlDataSource}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`url`| `string` | Yes | No | Yes | Public URL.

## ObjectStorageDataSource object {#ObjectStorageDataSource}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`bucket`| `string` | Yes | No | No | Name of the bucket the file resides in.
`object`| `string` | Yes | No | Yes | Name of the [object](../../../../../storage/concepts/object.md) containing the file, e.g., `prefix/subprefix/data.json`.

## AIAgentTool object {#AIAgentTool}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`mcpServer`| [MCPServer](#MCPServer) | No | No | No | MCP server.

## MCPServer object {#MCPServer}

The `useServiceAccount` and `token` fields are mutually exclusive: you can use only one of them.

#|
|| Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description ||
|| `endpoint`| `string` | Yes | No | No | MCP server URL, e.g., `https://mcp.example.com/sse`. ||
|| `transport`| `string` | Yes | No | No | Transport mechanism type for interacting with the MCP server. Available types:
* `STREAMABLE`: Your AI ​agent receives updates (events) from the server with no need for a persistent HTTP connection. Data exchange between the AI ​agent and the server is bidirectional.
* `SSE`: Your AI ​agent receives updates from the server over a persistent HTTP connection. Data is only transmitted from the server to the AI ​agent.
* `UNSPECIFIED`: Transport mechanism type is not specified. ||
|| `useServiceAccount`| `bool` | No | No | No | If set to:
* `true`: For agent authentication, the MCP server requires an [IAM token](../../../../../iam/concepts/authorization/iam-token.md) of the [service account](../../../../../iam/concepts/users/service-accounts.md) associated with the workflow.
* `false`: Agent can access the MCP server without authentication.||
|| `token`| `string` | No | No | No | [OAuth token](../../../../../iam/concepts/authorization/oauth-token.md) to use for authentication in the MCP server. ||
|#
