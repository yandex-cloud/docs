---
title: AIAgent integration step
description: This article describes the fields for the AIAgent integration step.
---

# AIAgent

AI agent to help you put together your prompt to {{ yagpt-name }}.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- |--- | --- | --- | ---
`agentConfig`| [AgentConfig](#AgentConfig) | Yes | No | No | AI agent settings.
`tasks`| [Tasks[]](#Tasks) | Yes | No | No | Tasks the AI agent has to complete.

## AgentConfig object {#AgentConfig}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- |--- | --- | --- | ---
`goal`| `string` | Yes | No | Yes | Individual goal that guides the AI agent's decision-making, e.g., _help with choice of parts for the specified vehicle_.
`role`| `string` | Yes | No | Yes | Role that defines the AI agent's functions and experience, e.g., _car parts consultant_.
`backstory`| `string` | Yes | No | Yes | Backstory defining the AI agent's personality and enriching the context, e.g., _you find the best value for money car parts and briefly explain your choice_.
`model`| [Model](#Model) | No | No | No | LLM the AI agent will use.

## Tasks object {#Tasks}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- |--- | --- | --- | ---
`description`| `string` | Yes | No | Yes | Description of the task you want the AI agent to perform, e.g., _find an oil filter for a BMW 320i_.
`result`| `string` | Yes | No | Yes | Description of what you expect to get, e.g., _a list of addresses of stores selling the car parts you need_.

## Model object {#Model}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- |--------------|-----------------------|-------------------------------------------------| ---
`name`| `string` | No | `yagpt` | No | Model name. [List of available models](../../../../../foundation-models/concepts/yandexgpt/models.md#generation).
