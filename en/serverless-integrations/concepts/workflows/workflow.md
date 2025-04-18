---
title: Workflow in {{ sw-full-name }}
description: A workflow in {{ sw-name }} is an event-driven application made up of steps and transitions between them.
keywords:
  - workflows
  - workflow
  - WF
  - workflow
  - YaWL specification
---

# Workflow

A _workflow_ is an event-driven application comprised of [integration](yawl/index.md#integration-steps) and [management](yawl/index.md#management-steps) _steps_ and transitions between them. Possible step attributes:

* Name and description.
* Filters for input and output data, i.e., jq expressions that filter the workflow state either provided to or resulting from the step.
* Actions to perform within a step.
* Execution timeout.
* Retry policy applied if the step throws an error. If a step cannot be completed due to running out of quota or ends with an error, {{ sw-name }} will retry the step according to the retry policy. Eventually the step may succeed or end with an error if the last attempt fails. If the step ends with an error, the whole [run](execution.md) gets the `Failed` status and no further steps are executed.

The steps are described in the [YaWL specification](yawl/index.md). The description of each step, except for the last one, must specify the next step.

In the workflow settings, you can specify the following:
* User network to run the workflow in. The workflow will have access to resources in this network.
* Service account to use for accessing private resources, such as {{ yds-full-name }} data streams.

You can start a workflow using the management console, CLI, API, or {{ er-name }}. For more information, see [{#T}](execution.md).

## Workflow state {#state}

The initial _workflow state_ is a JSON object with the `input` key whose value is the workflow input data. If the input data is a JSON object, all keys from the workflow input data are added in addition to the `input` key.

{% cut "Examples of input data and initial states of a workflow" %}

Payload | Workflow state
--- | ---
`{"a": "b", "c": 12}` | `{"input": {"a": "b", "c": 12}, "a": "b", "c": 12}`
`[1, 2, 3]` | `{"input": [1, 2, 3]}`

{% endcut %}

When executing a run:
* The workflow state is delivered to the step as input data (`input`).
* Output data (`output`) of each step is added to the workflow state in the order of executing the steps.

With jq expressions, you can filter:
* The workflow state delivered to the next step as input data (`input`).
* The output data (`output`) added to the workflow state.

{% note info %}

A workflow state is a JSON object at any given time.

{% endnote %}

The output data of each step is added to the workflow state by merging it with the current state using top-level keys. Therefore, some of the state data can be overwritten. For example, if before running the step the state was a JSON object of the form `{“numbers“: [1,2,3,4], “strings”: [“a”, “b”, “c”]}`, and the step's output was `{“strings”: [“d”, “e”]}`, the new state will be a JSON object of the form `{“numbers“: [1,2,3,4], “strings”: [“d”, “e”]}`.

The workflow execution result is represented by output data of the last step you can set the `output` field value for. 

### Workflow state during the Parallel step {#state-for-Parallel}

In the [Parallel](yawl/management/parallel.md) step, the workflow state is copied to each branch and changes independently within each one. Before filtering, the output data of the Parallel step is an object where keys are the unique names of execution branches, and values are the output data of the last steps of those branches.

### Workflow state during the Foreach step {#state-for-Foreach}

After the input data is filtered, the [Foreach](yawl/management/foreach.md) step accepts at its input a JSON array consisting of JSON objects. After executing a sequence of steps in `do`, a result is generated for each array element. The result is a JSON object which gets the same position in the array the original JSON object was at. This means that the `input` and `output` fields are required for the Foreach step.
* `input`: To convert a state from a JSON object to an array.
* `output`: To convert the step execution result from an array into a JSON object that can be added to the workflow state.

## Use cases {#examples}

* [{#T}](../../tutorials/auto-upload.md)
* [{#T}](../../tutorials/tracker-yandexgpt-postbox-integrations.md)

## See also

* [YaWL specification example](yawl/index.md#spec-example)
