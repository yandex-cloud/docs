# Changing a tag

When managing a project [tag](../../../concepts/tags.md), you can:

* [Edit it](#edit).
* [Activate or deactivate the tag](#activate-tag).
* [Change the tag channel](#tag-channel).

For system tags, you can only change the channel and the activation status.

To change a project tag, you need either the `{{ roles-speechsense-admin }}` or the `{{ roles-speechsense-editor }}` role for the project.

{% note warning %}

Changes to the tag apply only to the dialogs uploaded to the project after the changes are made.

{% endnote %}

## Editing a project tag {#edit}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. On the **Tags** tab, click the line with the tag.
1. In the window that opens, set the following configuration:

   {% include [tag-settings](../../../../_includes/speechsense/tag/tag-settings.md) %}

1. Click **Save**.

## Activating or deactivating a tag {#activate-tag}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **Tags** tab.
1. In the line with the tag you need, enable **Use in projects** to activate the tag. Disable to deactivate the tag.

{% include [changes-after-activation](../../../../_includes/speechsense/tag/changes-after-activation.md) %}

## Change the tag channel {#tag-channel}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **Tags** tab.
1. To change the channel of a single tag:

   1. In the line with the tag, click ![icon](../../../../_assets/console-icons/ellipsis.svg) and then ![icon](../../../../_assets/console-icons/arrow-right-arrow-left.svg) **Change channel**.
   1. Specify the channel based on where you want {{ speechsense-name }} to look for the tag keywords:

      * **Agent and customer**: Whole dialog
      * **Agent**: Agent's utterances or messages only
      * **Customer**: Customer's utterances or messages only

   1. Click **Save**.

1. To change the channel for multiple tags at the same time:

   1. Select the tags.
   1. In the pop-up window, click ![icon](../../../../_assets/console-icons/arrow-right-arrow-left.svg) **Change channel**.
   1. Specify the channel for each tag. If you need one channel for all tags, select it in the **New channel** field above the tag list.
   1. Click **Save**.
