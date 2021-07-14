# Saving a state

The notebook state is the cell code, output, and variable values at a specific point in time.

{% include [include](../../_includes/datasphere/saving-variables-warn.md) %}

States is saved as checkpoints. For more information about working with checkpoints, see [{#T}](../operations/projects/checkpoints.md)

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

  1. Open the **Settings** menu in your notebook.
  1. Select **Autosave commit mode**.

### Forcing a state save {#forced-save}

To force the saving of state in auto-save mode, click the ![plus-sign](../../_assets/plus-sign.svg) in the top right-hand corner of the ![checkpoints-panel](../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints** tab. You can also save the state by using the _CMD+K_ or _Ctrl+K_ keyboard shortcut.

