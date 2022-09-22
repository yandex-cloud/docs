# Saving a state

An interpreter state includes cell code, output, and variable values at a specific point in time, as well as project storage data.

{% include [include](../../_includes/datasphere/saving-variables-warn.md) %}

States is saved as _checkpoints_. For more information about working with checkpoints, see [{#T}](../operations/projects/checkpoints.md).

If the amount of data in project storage does not exceed {{ ml-project-size }}, the state of the data is also stored in checkpoints. If project storage data exceeds {{ ml-project-size }}, they will not be included in versioning, the rest of the notebook's state will be saved, however.

There are two save state modes: standard and automatic. Save modes only apply to regular cells. Cells with [background operations](async.md) create a checkpoint automatically after execution is complete or prompt the user to create one by running `%apply_state`.

## Standard save {#default-save}

In standard save mode, saving occurs after a cell or a group of cells is executed, or after execution throws an error.

If a group contains cells with [background operations](async.md), then the state will be saved before the background operations are completed.

## Auto-save {#auto-save}

In auto-save mode, the state is saved in the following situations:

* If there are no computations for a while, {{ ml-platform-short-name }} checks if the state of a notebook has changed, and saves the changes if necessary.
* If computing resources were switched to a different type.
* If you force a state save.

To enable auto-save mode:

1. Open the **Settings** tab of your project.
1. Enable **Autosave commit mode**.

### Forcing a state save {#forced-save}

To force a state save in auto-save mode , press **Cmd** + **K** or **Ctrl** + **K**.

#### See also {#see-also}

* [{#T}](../operations/projects/checkpoints.md)