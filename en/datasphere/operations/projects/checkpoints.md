# Working with checkpoints

You can find a list of checkpoints on your project page under **Resources** → ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints**. Checkpoints are only available if you have already run code cells in your project.

## Creating a checkpoint {#create}

In [standard](../../concepts/save-state.md#default-save) state save mode, checkpoints are created automatically after running a cell or group of cells. A checkpoint is also created if computations in a cell failed.

In [automatic](../../concepts/save-state.md#auto-save) state saving mode, you can create a checkpoint manually when working in {{ jlab }}Lab. To do this, use the **Cmd** + **K** or **Ctrl** + **K** shortcut.

A new checkpoint appears at the top of the **Checkpoints** list. If the list already contains 10 unsaved checkpoints, when saving a new checkpoint, the oldest one is deleted.

## Pinning a checkpoint {#pin}

Pinned checkpoints are protected against automatic deletion, you can share them and [use them to create nodes](../deploy/node-create.md).

To pin a checkpoint:
1. Open your project page.
1. Under **Resources**, click ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints**.
1. In the line with the appropriate checkpoint, click ![options](../../../_assets/options.svg) and select ![pin](../../../_assets/datasphere/pin.svg) **Pin**.
1. In the window that opens, enter the name of the checkpoint to save.
1. Click **Pin**.

You can also pin a checkpoint when viewing its information.

Pinned checkpoints are marked with ![pin](../../../_assets/datasphere/pin.svg).

Each project may contain a maximum of 10 pinned checkpoints.

## Unpinning a checkpoint {#unpin}

To unpin a checkpoint, click ![options](../../../_assets/options.svg) and select ![unpin](../../../_assets/datasphere/unpin.svg) **Unpin**. This will remove the checkpoint's saving mark and name.

{% note info %}

If the list of checkpoints already contains 10 checkpoints and you're unpinning the oldest checkpoint, it will be automatically deleted after you unpin it.

{% endnote %}

## Editing a checkpoint {#edit}

Since checkpoints are created automatically, you can only change the name of a pinned checkpoint.

1. Open your project page.
1. Under **Resources**, click ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints**.
1. Select the desired checkpoint from the list.
1. Click **More** and select **Edit**.
1. Enter a new name for the checkpoint.
1. Click **Save**.

## Applying a checkpoint {#apply}

To return to a certain notebook state:
1. Open your project page.
1. Under **Resources**, select ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints**.
1. In the line with the appropriate checkpoint, click ![options](../../../_assets/options.svg) and select **Apply**.
1. Wait for the operation to complete.

After restoring the state, a new checkpoint with the `Rollback` operation type is created.

## Sharing a checkpoint in a community {#share}

Only a community admin can share a checkpoint in the community. A checkpoint available to the community appears in the list of community resources.

1. Open the project page with the checkpoint to share.
1. Under **Resources**, click ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints**.
1. Select the desired checkpoint from the list.
1. Go to the **Access** tab.
1. Enable the visibility option next to the name of the community to share the checkpoint in.

## Sharing a link to a checkpoint {#share-link}

A project or community admin can share a direct link to a checkpoint. This checkpoint will be available at the link to all organization users while it's pinned in the list of project checkpoints.

1. Open your project page.
1. Under **Resources**, click ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints**.
1. Select the desired checkpoint from the list.
1. Click **More** and select **Share**.

The link to the checkpoint is copied to the clipboard.

## Creating a project from a checkpoint {#import}

1. Select the desired checkpoint in the list of project checkpoints or [follow the direct link](#share-link) to the checkpoint.
1. Click ![options](../../../_assets/options.svg) and select **Create project from checkpoint**.
1. In the **Create a project** window, enter the checkpoint name and select the desired community and [availability zone](../../../overview/concepts/geo-scope.md).
1. Click **Create**.

The page of the created project opens.

## Deleting a checkpoint {#delete}

1. Open your project page.
1. Under **Resources**, click ![checkpoints-panel](../../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints**.
1. In the list, select the checkpoint to delete.
1. Click ![options](../../../_assets/options.svg) and select **Delete**.

You'll see a message saying `Resource deleted`.

#### See also {#see-also}

* [{#T}](../../concepts/save-state.md).
* [{#T}](../../concepts/checkpoints.md).
* [{#T}](../../security/index.md).
