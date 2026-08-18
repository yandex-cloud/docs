---
title: Foreach control step
description: This article describes the fields for the Foreach control step.
---

# Foreach

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

Executes the sequence of steps specified in `do` on each input data item. Outputs are an array of execution results of the steps specified in `do`. For steps from `do`, in the `next` field, you can only specify steps listed in `do`. Read more about the [workflow state during the Foreach step](../../workflow.md#state-for-Foreach).

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`input` | `string` | Yes | None | Yes | jq template that forms an array of objects. If the result is not an array of objects, the execution will terminate with an error.
`output` | `string` | Yes | None | Yes | jq template that forms an object with the `foreach` output. If the result is not an object, the execution will terminate with an error.
`do` | [ForeachDo](#ForeachDo) | Yes | None | None | Sequence of steps to apply to each input data item.
`concurrency` | `int` | None | 1 | None | Number of input data items on which the sequence of steps from `do` is being performed at the same time.
`next` | `string` | None | None | None | ID of the next step.

## ForeachDo object {#ForeachDo}

Field name | Type | Required | Description
--- | --- | --- | ---
`start` | `string` | Yes | ID of the step to start the execution from.
`steps` | `map<string, Step>` | Yes | Description of the steps. Object where key is the step ID, and value is the object describing the step parameters. The structure is similar to the `steps` field in the [high-level specification](../index.md#workflow).
