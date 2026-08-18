---
title: While control step
description: This article describes the fields for the While control step.
---

# While

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

Performs the sequence of steps specified in `do` as long as the `condition` is met and the number of iterations does not exceed `max_iterations`. If the `condition` is not specified, the step is performed the number of times set in `max_iterations`. If `max_iterations` is not set, the loop will continue until the condition is met or the workflow [timeout](../../../limits.md) is reached.

The result is the output data of the last iteration's last step for which you can set the `output` field value.

Each execution branch within the While step (including all [Switch](switch.md) steps) must contain an [integration step](../index.md#integration-steps) or a [Success](success.md), [Fail](fail.md), or [Wait](wait.md) step.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`input` | `string` | None | [Overall state of the workflow](../../workflow.md#state) | Yes | jq template to filter the workflow state fed into the step.
`output` | `string` | None | Step output data | Yes | A jq template to filter the step outputs added into the workflow state.
`do` | [WhileDo](#WhileDo) | Yes | None | None | The sequence of steps to performed in the loop.
`condition` | `string` | Required unless `max_iterations` is specified | None | Yes. The `$counter` variable is additionally available, which is equal to the iteration number (indexing starts from zero). | A condition in jq format that returns either the `true` or the `false` string.
`max_iterations` | `int` | Required unless `condition` is specified | None | Yes | The maximum number of iterations the cycle can complete. 
`next` | `string` | None | None | None | ID of the next step.

## WhileDo object {#WhileDo}

Field name | Type | Required | Description
--- | --- | --- | ---
`start` | `string` | Yes | ID of the step to start the execution from.
`steps` | `map<string, Step>` | Yes | Description of the steps. Object where key is the step ID, and value is the object describing the step parameters. The structure is similar to the `steps` field in the [high-level specification](../index.md#workflow).
