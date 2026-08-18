---
title: Workflow integration step
description: This article describes the fields for the Workflow integration step.
---

# Workflow

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

Synchronized start of a [{{ sw-full-name }}](../../../index.md) workflow.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- |--- | --- | --- | ---
`workflowId`| `string` | Yes | None | None | Workflow ID.
`executionInput `| `string` | None | None | Yes | Workflow input data.

