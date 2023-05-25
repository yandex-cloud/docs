# Checkpoints

A checkpoint in {{ ml-platform-name }} is a [saved state](save-state.md). It includes cell code, output, and variable values, as well as project storage data.

You can create a maximum of 10 regular checkpoints per project. If a project already has 10 checkpoints, older checkpoints are automatically erased when creating a new checkpoint. To protect a checkpoint against deletion, [pin](../operations/projects/checkpoints.md#pin) it. You can pin a maximum of 10 checkpoints.

{% note info %}

You can fully use a checkpoint as a resource, that is, share it with other users and create other resources based on it, only after you pin it. Learn more about [working with checkpoints](../operations/projects/checkpoints.md).

{% endnote %}

## Information about a checkpoint as a resource {#info}

A list of project checkpoints provides the following information about each checkpoint:
* The type of the operation after which the checkpoint was created, such as `Cell run`.
* The name of the notebook where the cell is located, such as `Untitled.ipynb`, for a checkpoint created when running the code cell.
* Tag of the checkpoint's additional content. For example, the `GIT` tag indicates that the cell contains a [commit to the Git repository](../operations/projects/work-with-git.md).
* Checkpoint creation date in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format, such as `July 18, 2022, 14:23`.

To view detailed information about a checkpoint, click on it in the list of project checkpoints.

Checkpoint details also include:
* Checkpoint name for a pinned checkpoint or the name of the operation that resulted in a checkpoint for non-pinned checkpoints.
* Unique resource ID.
* Name of the user who pinned the checkpoint.

For checkpoints created after running cells, the project cell code is available in the **{{ ui-key.yc-ui-datasphere.checkpoint.cell-code }}** section. If a saved state contains variables, you can view their current values in the **{{ ui-key.yc-ui-datasphere.checkpoint.variables }}** tab.

#### See also {#see-also}

* [{#T}](save-state.md).
* [{#T}](../operations/projects/checkpoints.md).