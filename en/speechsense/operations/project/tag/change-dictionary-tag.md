---
title: Creating a dictionary tag
description: Follow this guide to change a dictionary tag.
---

# Creating a dictionary tag

When working with a [dictionary tag](../../../concepts/tags.md#dictionary-tags) in a project, you can:

* [Update its settings](#edit).
* [Activate or deactivate the tag](#activate-tag).
* [Change the tag channel](#tag-channel).

To change a project tag, you need either the `{{ roles-speechsense-admin }}` or the `{{ roles-speechsense-editor }}` role for the project.

{% include [after-changing-tags](../../../../_includes/speechsense/tag/after-changing-tags.md) %}

## Updating tag settings {#edit}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab, select the tag you need and click **{{ ui-key.yc-ui-talkanalytics.common.edit }}**.
1. In the window that opens, update the settings as needed:

    * Enter a name and description for the tag.

    * {% include [select-channel](../../../../_includes/speechsense/tag/select-channel.md) %}
    * {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
    * {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}

    {% include [select-conditions](../../../../_includes/speechsense/tag/select-conditions.md) %}

    * Enable [tag testing](test.md).

1. Click **{{ ui-key.yc-ui-talkanalytics.common.save }}**.

## Activating or deactivating a tag {#activate-tag}

{% include notitle [activation](../../../../_includes/speechsense/tag/activation.md) %}

## Changing tag channel {#tag-channel}

### Changing the channel for a single tag {#single-tag}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab.
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
