---
title: Foreach control step
description: This article describes the fields for the Foreach control step.
---

# Foreach

Executes the sequence of steps specified in `do` on each input data item. Outputs are an array of execution results of the steps specified in `do`. In the `next` field in `do`, only steps listed in `do` can be specified. Read more about the [workflow state during the Foreach step](../../workflow.md#state-for-Foreach).

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`input` | `string` | Yes | No | Yes | A jq expression that forms an array of objects. If the result is not an array of objects, the run will be terminated with an error.
`output` | `string` | Yes | No | Yes | A jq expression that forms an object to contain the `foreach` output. If the result is not an object, the run will be terminated with an error.
`do` | [ForeachDo](#ForeachDo) | Yes | No | No | Sequence of steps to apply to each input data item.
`next` | `string` | No | No | No | ID of the next step.

## ForeachDo object {#ForeachDo}

Field name | Type | Required | Description
--- | --- | --- | ---
`start` | `string` | Yes | ID of the step to start the execution from.
`steps` | `map<string, Step>` | Yes | Description of the steps. Object where key is the step ID, and value is the object describing the step parameters. The structure is similar to the `steps` field in the [high-level specification](../index.md#workflow).