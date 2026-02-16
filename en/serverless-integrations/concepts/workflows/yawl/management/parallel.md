---
title: Parallel control step
description: This article describes the fields for the Parallel control step.
---

# Parallel

Executes multiple branches (sequences of steps) concurrently. Execution result is an object where key is the execution branch name, and value is the execution branch outputs. Read more about the [workflow state during the Parallel step](../../workflow.md#state-for-Parallel).

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`input` | `string` | No | [Overall state of the workflow](../../workflow.md#state) | Yes | A jq template to filter the workflow state fed into the step.
`output` | `string` | No | Step output data | Yes | A jq template to filter the step outputs added into the workflow state.
`branches` | `map<string,` [Branch](#Branch)`>` | Yes | No | No | Object containing description of execution branches. Key: branch ID; value: description of steps in the branch.
`concurrency` | `int` | No | 30 | No | Number of concurrent branches. For example, if `concurrency` is set to 2, and 5 branches are described in `branches`, at most 2 randomly selected branches will be executed simultaneously.
`next` | `string` | No | No | No | ID of the next step.

## Branch object {#Branch}

Field name | Type | Required | Description
--- | --- | --- | ---
`start` | `string` | Yes | ID of the step to start off the branch execution.
`steps` | `map<string, Step>` | Yes | Description of steps in the execution branch. Object where key is the step ID, and value is the object describing the step parameters. The structure is similar to the `steps` field in the [high-level specification](../index.md#workflow).
