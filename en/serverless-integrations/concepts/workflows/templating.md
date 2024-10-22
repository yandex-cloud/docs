# Templating

For the [YaWL specification](#yawl.md) fields that support templating, values can be generated dynamically using the data obtained from the workflow state. The templating language is jq. For more information, see the [jq documentation](https://jqlang.github.io/jq/manual/).

By default, templating is not used for string values of fields; use [string interpolation](https://jqlang.github.io/jq/manual/#string-interpolation) instead.

## Input data for the templater {#input-data}

The templater input data will be different depending on the field.

Field | Payload
--- | ---
`input` | Overall [state of the workflow](workflow.md#state)
`output` | Step output data
Other fields that do not support templating | JSON object filtered by `input`

## Examples {#examples}

Field value | Templater interpretation
--- | ---
`this is just string` | Non-templated string
`this is value from workflow state \(.data[1].some_property)` | `this is value from workflow state <workflow_state_data>`
`\({x: 1, y: .a.b.c})` | `{“x”: 1, “y”: “<workflow_state_data>”}`