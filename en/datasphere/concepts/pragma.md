# #pragma service commands

{% include [serverless-deprecation-note](../../_includes/datasphere/serverless-deprecation-note.md) %}

You can set cell running parameters using the `#pragma` service command.

| Command | Description |
|----|----|
| `#pragma dataset init` | [Create and initialize a dataset](dataset.md#init) |
| `#pragma async` | Start a background operation, such as [model training](async.md#run) |
| `#pragma readonly/ro` | Declare a [read-only variable](magic.md#readonly) |
