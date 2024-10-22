# Workflow

A _workflow_ is an event-driven application made up of _steps_ and transitions between them. Step attributes:
* Input data.
* Actions to perform within a step.
* Execution timeout.
* Output data.
* Retry policy applied if the step throws an error. If a step cannot be completed due to running out of quota or ends with an error, {{ sw-name }} will retry the step according to the retry policy. Eventually the step may succeed or end with an error if the last attempt fails. If the step ends with an error, the whole [run](execution.md) gets the `Failed` status and no further steps are executed.

Steps are described in the [YaWL specification](yawl.md) and fall into two groups: integration steps and management steps.

In the workflow settings, you can specify the following:
* User network to run the workflow in. The workflow will have access to resources in this network.
* Service account to use for accessing private resources, such as {{ yds-full-name }} data streams.

You can run a workflow using the management console, API, or {{ er-name }}. For more information, see [{#T}](execution.md).

## Workflow state {#state}

A _workflow state_ is a JSON object. At the beginning of a workflow run, the state stores only the input data provided by the user. When executing a run:
* The workflow state is delivered to the step as input data (`input`).
* Output data (`output`) of each step is added to the workflow state in the order of executing the steps.

With jq expressions, you can filter:
* The workflow state delivered to the next step as input data (`input`).
* The output data (`output`) added to the workflow state.

{% note info %}

A workflow state is a JSON object at any given time.

{% endnote %}

The output data of each step is added to the workflow state by merging it with the current state using top-level keys. Therefore, some of the state data can be overwritten. For example, if before running the step the state was a JSON object of the form `{“numbers“: [1,2,3,4], “strings”: [“a”, “b”, “c”]}`, and the step's output was `{“strings”: [“d”, “e”]}`, the new state will be a JSON object of the form `{“numbers“: [1,2,3,4], “strings”: [“d”, “e”]}`.

The workflow execution result is represented by filtered output data of the last step, if the `output` field has been specified for it. Otherwise, it is the overall state of the whole workflow.

### Workflow state during the Parallel step {#state-for-Parallel}

In the [Parallel](yawl.md#Parallel) step, the workflow state is copied to each branch and changes independently within each one. Before filtering, the output data of the Parallel step is an object where keys are the unique names of execution branches, and values are the output data of the last steps of those branches.

### Workflow state during the Foreach step {#state-for-Foreach}

After the input data is filtered, the [Foreach](yawl.md#Foreach) step accepts an array of JSON objects at its input. After executing a sequence of steps in `do` for each item in the list, an array of JSON objects is generated. This means that the `input` and `output` fields are required for the Foreach step.
* `input`: To convert a state from a JSON object to an array.
* `output`: To convert the step execution result from an array into a JSON object that can be added to the workflow state.

## See also

* [YaWL specification example](yawl.md#spec-example)
