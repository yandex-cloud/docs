---
title: Switch control step
description: This article describes the fields for the Switch control step.
---

# Switch

Selecting the further execution path. Only one path can be selected: the one for which the condition first returns `true`. If all conditions have returned `false`, and no value is set in the `default` field, the run will be terminated with an error.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`input` | `string` | No | [Overall state of the workflow](../../workflow.md#state) | Yes | A jq expression to filter the workflow state fed into the step.
`choices` | [Choice](#Choice)[] | Yes | No | No | List of possible further execution paths.
`default` | `string` | No | No | No | ID of the step to execute if none of the conditions specified in `choices` return `true`.

## Choice object {#Choice}

Field name | Type | Required | Description
--- | --- | --- | ---
`condition` | `string` | Yes | Condition in the form of a jq expression that returns either `true` or `false` string.
`next` | `string` | Yes | ID of the step to execute if the condition returns `true`.