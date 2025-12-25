---
title: AIStudioAgent integration step
description: This article describes the fields for the AIStudioAgent integration step.
---

# AIStudioAgent

Interacting with [{{ ai-studio-name }} agents](../../../../../ai-studio/concepts/agents/index.md).

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`promptTemplateId`  | `string`              | Yes  | No | No | Agent ID.
`message`           | `string`              | No | No | Yes  | Incoming message that will be provided to the agent together with the prompt.
`variables`         | `map<string,string>`  | No | No | Yes  | Variables for substitution in the prompt, where key is the name of the variable, and value is its value. Templating is supported for variable values.
