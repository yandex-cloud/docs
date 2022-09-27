# #pragma service commands

You can set cell running parameters using the `#pragma` service command.

| Team | Description |
|----|----|
| `#pragma dataset init` | [Create and initialize a dataset](dataset.md#init). |
| `#pragma dataset delete` | [Delete a dataset](dataset.md#delete). |
| `#pragma datasets list` | Display a [list of all the datasets available in a project](dataset.md#use). |
| `#pragma async` | Start a background operation, such as [model training](async.md#run). |
| `#pragma repeat` | Run [sequential background operations](../concepts/repeat.md#run) in a cell (command available as [EAP](../concepts/early-access.md)). |
| `#pragma readonly/ro` | Declare a [read-only variable](magic.md#readonly). |
| `#pragma parallel` | Run special background cells in parallel (command available as [EAP](../concepts/early-access.md)). |
