---
title: AIStudioAgent integration step
description: This article describes the fields for the AIStudioAgent integration step.
---

# AIStudioAgent

Interacting with [{{ ai-studio-name }} agents](../../../../../ai-studio/concepts/agents/index.md).

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`promptTemplateId` | `string` | Yes | No | No | {{ ai-studio-name }} agent ID.
`variables` | `map<string,string>` | No | No | Yes | Variables to use in the prompt, where the key is the variable name, and value, the variable value. Templating is supported for variable values.
