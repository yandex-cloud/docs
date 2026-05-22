---
title: AIStudioAgent integration step
description: This article describes the fields for the AIStudioAgent integration step.
---

# AIStudioAgent

Interacting with [{{ ai-studio-name }}]({{ link-docs-ai }}ai-studio/concepts/agents/index) agents.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`promptTemplateId`  | `string`              | Yes  | No | No | Agent ID.
`message`           | `string`              | No | No | Yes  | Incoming message to provide to the agent together with the prompt.
`variables`         | `map<string,string>`  | No | No | Yes  | Variables for substitution in the prompt, where key is the name of the variable, and value is its value. Templating is supported for variable values.
`auto_approve` | `bool` | No | `false` | No | If set to `true`, [tools]({{ link-docs-ai }}ai-studio/concepts/agents/index#tools) are automatically allowed. If set to `false`, and the tool requires confirmation of use, the step will end with an error.
