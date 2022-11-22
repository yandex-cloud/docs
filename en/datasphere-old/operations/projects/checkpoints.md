# Versioning. Working with checkpoints

{% include [link-on-new-ui-datasphere-in-old-ui](../../../_includes/datasphere/datasphere-old-note.md) %}

A checkpoint in {{ ml-platform-name }} is the [saved state](../../concepts/save-state.md). A checkpoint includes cell code, output, and variable values as well as project storage data. Data versioning is maintained if the amount of data does not exceed {{ ml-project-size }}. Checkpoints with versioned data are marked with ![](../../../_assets/datasphere/disk.svg).

## Before you begin {#before-begin}

If the project is already open, go to the notebook tab.

If not, open the project:

{% include [include](../../../_includes/datasphere/before-begin.md) %}

## Creating a checkpoint {#create}

To create a checkpoint in a [standard](../../concepts/save-state.md#default-save) state-saving state:

1. Open the ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints** panel.

   If you already executed the open project's code, the **Checkpoints** list will contain the checkpoints created earlier.
1. Run the code in a notebook cell or group of cells.

   Run your own code or use an [example](snippets.md#run).
1. Wait for the code to run.

In the [automatic](../../concepts/save-state.md#auto-save) state saving mode, you can create a checkpoint manually. For this, in the upper-right corner of the ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints** tab, click ![plus-sign](../../../_assets/plus-sign.svg) or use the **Cmd** + **K** or **Ctrl** + **K** hotkeys.

This creates a checkpoint that appears at the top of the **Checkpoints** list. The checkpoint name consists of the following elements:
* The key of the operation after which the checkpoint was created, such as `[1]`.

   The same key is displayed in the notebook to the left of the executed cell.
* The type of this operation, such as `CELL_RUN`.
* The name of the notebook in which a cell was executed. For example, `Untitled.ipynb`.
* The checkpoint creation date and time in [UTC]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Всемирное_координированное_время){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Coordinated_Universal_Time){% endif %}, for example: `2020-10-09 06:12:08`.

A maximum of 10 checkpoints can be created for a single project. Older checkpoints are automatically erased.

## Applying a checkpoint {#apply}

To return to the state of a notebook at a certain checkpoint:
1. Open the ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints** panel.
1. Select the desired checkpoint from the list.
1. Click **Apply**.
1. Wait for the operation to complete.

After restoring the state, a checkpoint with the `ROLLBACK` operation type in its name is created.

## Pinning a checkpoint {#pin}

To protect a checkpoint from being automatically deleted, it needs to be pinned:
1. Open the ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints** panel.
1. Select the desired checkpoint from the **Checkpoints** list and click **Pin**.
1. In the window that opens, enter the name of the checkpoint to save.
1. Click **Save**.

The saved checkpoint is moved to the **Pinned checkpoints** list.

A maximum of five checkpoints can be pinned for a single project. The checkpoints pinned earlier are automatically erased.

To unpin a checkpoint, click **Unpin**. The checkpoint will move to the **Checkpoints** list.

## Exporting a checkpoint {#export}

You can export a pinned checkpoint:

1. Open the ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints** panel.
1. Select the desired checkpoint from the **Pinned checkpoints** list.
1. Click **Share**.
1. In the window that opens, click **Copy to clipboard**.

The link to the notebook checkpoint is copied to the clipboard.

## Importing a checkpoint {#import}

To import a notebook from a checkpoint:

1. In the top panel, click **File** and select **Import notebook from checkpoint**.
1. In the window that opens, enter the checkpoint `URI`.
1. Click **import**.
1. Wait for the operation to complete.
