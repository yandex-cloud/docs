---
title: NoOp control step
description: NoOp control step description.
---

# NoOp

This step does nothing. You may need it, e.g., to successfully complete a pipeline if the condition from the `default` field is met in [Switch](switch.md), or as a placeholder for one of the steps when prototyping the workflow.

Field name | Type | Required | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | ---
`output` | `string` | No | Yes | A jq expression to filter the step's output data added into the [workflow state](../../workflow.md#state).
`next` | `string` | No | No | ID of the next step.