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
`goal`| `string` | Yes | No | Yes | Individual goal that guides the AI agent's decision-making, e.g., _help with choice of parts for the specified vehicle_.
`role`| `string` | Yes | No | Yes | Role that defines the AI agent's functions and experience, e.g., _car parts consultant_.
`backstory`| `string` | Yes | No | Yes | Backstory defining the AI agent's personality and enriching the context, e.g., _you find the best value for money car parts and briefly explain your choice_.
`model`| [AIAgentModel](#AIAgentModel) | No | No | No | LLM the AI agent will use.
`knowledgeSources` | [KnowledgeSource[]](#KnowledgeSource) | No | No | No | AI agent’s knowledge sources.

## AIAgentTask object {#AIAgentTask}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- |--- | --- | --- | ---
`description`| `string` | Yes | No | Yes | Description of the task you want the AI agent to perform, e.g., _find an oil filter for a BMW 320i_.
`result`| `string` | Yes | No | Yes | Description of what you expect to get, e.g., _a list of addresses of stores selling the car parts you need_.

## AIAgentModel object {#AIAgentModel}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- |--- | --- | --- | ---
`name`| `string` | No | `yagpt` | No | Model name. [List of available models](../../../../../foundation-models/concepts/yandexgpt/models.md#generation).

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
`type`| `string` | Yes | No | No | File type containing a knowledge source. Available types: `TEXT`, `JSON`, `CSV`, `PDF`, and `EXCEL`.
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
