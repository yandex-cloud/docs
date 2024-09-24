# Changing a tag

When managing a project [tag](../../../concepts/tags.md), you can:

* [Update its settings](#edit).
* [Change the tag channel](#tag-channel).

To change a project tag, you need either the `{{ roles-speechsense-admin }}` or the `{{ roles-speechsense-editor }}` role for the project.

After changing a tag, {{ speechsense-name }} will re-analyze the dialogs uploaded during the month before the tag change. The required tags will be assigned automatically. All dialogs uploaded after the change will have the new rules applied immediately.

## Updating tag settings {#edit}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab, select the tag you need and click **{{ ui-key.yc-ui-talkanalytics.common.edit }}**.
1. In the window that opens, set the following configuration:

   {% include [tag-settings](../../../../_includes/speechsense/tag/tag-settings.md) %}

1. Click **{{ ui-key.yc-ui-talkanalytics.common.save }}**.

## Activating or deactivating a tag {#activate-tag}

Once created, the tag is activated by default. If you do not want the tag to apply to dialogs, deactivate it. You can activate it again later.

To activate or deactivate a tag:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **Tags** tab.
1. In the line with the tag you need, enable **Use in projects** to activate the tag. Disable to deactivate the tag.

{% include [changes-after-activation](../../../../_includes/speechsense/tag/changes-after-activation.md) %}

## Changing tag channel {#tag-channel}

### Changing the channel for a single tag {#single-tag}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab.
1. In the line with the tag, click ![icon](../../../../_assets/console-icons/ellipsis.svg) and then ![icon](../../../../_assets/console-icons/arrow-right-arrow-left.svg) **Change channel**.
1. Specify the channel based on where you want {{ speechsense-name }} to look for the tag keywords:

   * **{{ ui-key.yc-ui-talkanalytics.tags.channel.operator-and-client }}**: Whole dialog.
   * **{{ ui-key.yc-ui-talkanalytics.tags.channel.operator }}**: Agent's utterances or messages only.
   * **{{ ui-key.yc-ui-talkanalytics.tags.channel.client }}**: Customer's utterances or messages only.

1. Click **{{ ui-key.yc-ui-talkanalytics.common.save }}**.

### Changing the channel for multiple tags {#multiple-tags}

You can change the channel for multiple tags at the same time:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab and select the tags you need.
1. In the pop-up window, click ![icon](../../../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yc-ui-talkanalytics.tags.change-channel }}**.
1. Specify the channel for each tag. If you need the same channel for all tags, select it in the **{{ ui-key.yc-ui-talkanalytics.tags.new-channel }}** field above the tag list.
1. Click **{{ ui-key.yc-ui-talkanalytics.common.save }}**.
