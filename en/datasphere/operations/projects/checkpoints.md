# Version control. Working with checkpoints

A checkpoint in {{ ml-platform-name }} is a notebook's state automatically saved after each run of a code cell. A checkpoint consists of the cell code, output, and variable values.

## Before you start {#before-begin}

If the project is already open, go to the notebook tab.

If not, open the project:

1. {% include [include](../../../_includes/datasphere/first-step.md) %}
1. Go to the **Projects** tab.
1. Select the project you want to open and click ![image](../../../_assets/datalens/horizontal-ellipsis.svg).
1. Choose **Open** and wait for the project to open.

## Creating checkpoints {#create}

1. Open the ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints-panel** panel.

   If you already executed the open project's code, the **Checkpoints** list will contain the checkpoints created earlier.

1. Run code in the notebook cell.

   Run your own code or use an [example](snippets.md#run).

1. Wait for the code to run.

This creates a checkpoint that appears at the top of the **Checkpoints** list. The checkpoint name consists of the following elements:

* The key of the operation after which the checkpoint was created, such as `[1]`.

   The same key is displayed in the notebook to the left of the executed cell.

* The type of this operation, such as `CELL_RUN`.

* The name of the notebook where the cell was run, such as `Untitled.ipynb`.

* The checkpoint creation date and time in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time). For example, `2020-10-09 06:12:08`.

A maximum of 10 checkpoints can be created for a single project. Older checkpoints are automatically erased.

## Using checkpoints {#apply}

To return to the state of a notebook at a certain checkpoint:

1. Open the ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints-panel** panel.
1. Select the desired checkpoint from the list.
1. Click **Apply**.
1. Wait for the operation to complete.

After restoring the state, a checkpoint with the `ROLLBACK` operation type in its name is created.

## Pinning checkpoints {#pin}

To protect a checkpoint from being automatically deleted, it needs to be pinned:

1. Open the ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints-panel** panel.
1. Select the desired checkpoint from the **Checkpoints** list and click **Pin**.
1. In the window that opens, enter the name of the checkpoint to save.
1. Click **Save**.

The saved checkpoint is moved to the **Pinned checkpoints** list.

A maximum of five checkpoints can be pinned for a single project. The checkpoints pinned earlier are automatically erased.

To unpin a checkpoint, click **Unpin**. This moves it to the **Checkpoints** list.

## Exporting checkpoints {#export}

You can export a pinned checkpoint:

1. Open the ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints-panel** panel.
1. Select the desired checkpoint from the **Pinned checkpoints** list.
1. Click **Share**.
1. In the window that opens, click **Copy to clipboard**.

The link to the notebook checkpoint is copied to the clipboard.

## Importing checkpoints {#import}

To import a notebook from a checkpoint:

1. In the top panel, click **File** and select **Import notebook from checkpoint**.
1. In the window that opens, enter the checkpoint `URI`.
1. Click **import**.
1. Wait for the operation to complete.

