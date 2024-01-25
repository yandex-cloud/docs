# Working with checkpoints

You can find a list of checkpoints on your project page under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** → ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**. Checkpoints are only available if you have already run code cells in your project.

{% include [save-state-dedicated](../../../_includes/datasphere/save-state-dedicated.md) %}

## Creating a checkpoint {#create}

In [standard](../../concepts/save-state.md#default-save) state save mode, checkpoints are created automatically after running a cell or group of cells. A checkpoint is also created if computations in a cell failed.

In [automatic](../../concepts/save-state.md#auto-save) state saving mode, you can create a checkpoint manually when working in {{ jlab }}Lab. To do this, use the **Cmd** + **K** or **Ctrl** + **K** shortcut.

A new checkpoint appears at the top of the **{{ ui-key.yc-ui-datasphere.checkpoint-list-page.page-title }}** list. If the list already contains 10 unsaved checkpoints, when saving a new checkpoint, the oldest one is deleted.

## Pinning a checkpoint {#pin}

Pinned checkpoints are protected against automatic deletion, you can share them and [use them to create nodes](../deploy/node-create.md).

1. {% include [ui-find-project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
1. In the line with the appropriate checkpoint, click ![options](../../../_assets/console-icons/ellipsis.svg) and select ![pin](../../../_assets/datasphere/pin.svg) **{{ ui-key.yc-ui-datasphere.common.pin }}**.
1. In the window that opens, enter the name of the checkpoint to save.
1. Click **{{ ui-key.yc-ui-datasphere.common.pin }}**.

You can also pin a checkpoint when viewing its information.

Pinned checkpoints are marked with ![pin](../../../_assets/datasphere/pin.svg).

Each project may contain a maximum of 10 pinned checkpoints.

## Unpinning a checkpoint {#unpin}

1. {% include [ui-find-project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
1. In the line with the appropriate checkpoint, click ![options](../../../_assets/console-icons/ellipsis.svg) and select ![unpin](../../../_assets/datasphere/unpin.svg) **{{ ui-key.yc-ui-datasphere.common.unpin }}**.

{% note info %}

If the list of checkpoints already contains 10 checkpoints and you're unpinning the oldest checkpoint, it will be automatically deleted after you unpin it.

{% endnote %}

## Editing a checkpoint {#edit}

Since checkpoints are created automatically, you can only change the name of a pinned checkpoint.

1. {% include [ui-find-project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
1. In the line with the appropriate checkpoint, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Enter a new name for the checkpoint.
1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Applying a checkpoint {#apply}

1. {% include [ui-find-project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
1. Select the checkpoint from the list.
1. Click **{{ ui-key.yc-ui-datasphere.common.apply }}** at the top right.
1. Click **{{ ui-key.yc-ui-datasphere.checkpoint.apply }}**.

Wait for the operation to complete.

After restoring the state, a new checkpoint with the `{{ ui-key.yc-ui-datasphere.checkpoint.type.rollback }}` operation type is created.

## Sharing a checkpoint in a community {#share}

Only a community admin can share a checkpoint in the community. A checkpoint available to the community appears in the list of community resources.

1. {% include [ui-find-project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
1. Select the checkpoint from the list.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.access }}** tab.
1. Enable the visibility option next to the name of the community to share the checkpoint in.

## Sharing a link to a checkpoint {#share-link}

A project or community admin can share a direct link to a checkpoint. This checkpoint will be available at the link to all organization users while it's pinned in the list of project checkpoints.

1. {% include [ui-find-project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
1. In the line with the appropriate checkpoint, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yc-ui-datasphere.common.share }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.copy-link }}**.

The link to the checkpoint is copied to the clipboard.

## Creating a project from a checkpoint {#import}

1. Select the checkpoint in the list of project checkpoints or [follow the direct link](#share-link) to the checkpoint.
1. Click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yc-ui-datasphere.checkpoint.create-project-from-checkpoint }}**.
1. In the **{{ ui-key.yc-ui-datasphere.projects.create-project }}** window, enter a name and description for the project.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

The page of the created project opens.

## Deleting a checkpoint {#delete}

1. {% include [ui-find-project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![checkpoints-panel](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
1. In the list, select the checkpoint to delete.
1. Click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.submit }}**.

You will see a message saying that the resource has been deleted.

#### See also {#see-also}

* [{#T}](../../concepts/save-state.md)
* [{#T}](../../concepts/checkpoints.md)
* [{#T}](../../security/index.md)
