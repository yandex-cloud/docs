# Saving a state

The interpreter state is the cell code, output, and variable values at a specific point in time.

{% include [include](../../_includes/datasphere/saving-variables-warn.md) %}

{% note info %}

You cannot save a state in [{{ dd }} mode](project.md#dedicated).

{% endnote %}

States are saved as _checkpoints_. For more information about working with checkpoints, see [{#T}](../operations/projects/checkpoints.md).

There are two save state modes: standard and automatic. Save modes only apply to regular cells. Cells with [background operations](async.md) create a checkpoint automatically after execution is complete or prompt the user to create one by running `%apply_state`.

## Standard save {#default-save}

In standard save mode, saving occurs after a cell or a group of cells is executed, or after execution throws an error.

If a group contains cells with [background operations](async.md), then the state will be saved before the background operations are completed.

## Auto-save {#auto-save}

In auto-save mode, the state is saved in the following situations:

* If there are no computations for a while, {{ ml-platform-short-name }} checks if the state of a notebook has changed, and saves the changes if necessary.
* If computing resources were switched to a different type.
* If you force a state save.

The auto save state mode is enabled by default for any new project.

You can [change](../operations/projects/update.md) the save state mode in the project settings.

### Forcing a state save {#forced-save}

To force a state save in auto-save mode , press **Cmd** + **K** or **Ctrl** + **K**.

#### See also {#see-also}

* [{#T}](../operations/projects/checkpoints.md)