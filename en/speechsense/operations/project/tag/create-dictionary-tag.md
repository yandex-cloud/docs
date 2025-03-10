---
title: Creating a dictionary tag
description: Follow this guide to create a dictionary tag for a project in different ways.
---

# Creating a dictionary tag

You can only create a [dictionary tag](../../../concepts/tags.md#dictionary-tags) in a [project](../../../concepts/resources-hierarchy.md#project). To do this, you need the `{{ roles-speechsense-admin }}` or `{{ roles-speechsense-editor }}` role in the project.

When creating a dictionary tag, the following options are available:

* [Create a new tag](#new-tag).
* [Duplicate an existing tag](#duplicate).
* [Add a dependent tag](create-dependent-tag.md) for an existing tag.

## Creating a tag {#new-tag}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab, click ![icon](../../../../_assets/console-icons/tag.svg) **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.
1. Select the tag type: **{{ ui-key.yc-ui-talkanalytics.tags.tags-type.dictionary-key-value }}**.
1. Set the tag parameters:

    * Name the tag.
    * (Optional) Describe the tag.

    * {% include [select-channel](../../../../_includes/speechsense/tag/select-channel.md) %}
    * {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
    * {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}

    {% include [select-conditions](../../../../_includes/speechsense/tag/select-conditions.md) %}

    * (Optional) Enable [tag testing](test.md).

1. Click **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.

Once created, the tag is activated automatically.

## Duplicating a tag {#duplicate}

When duplicating, a new tag gets the settings of the original one. Later on, you can change the settings as needed. This is convenient if you want to create a tag set up in the same way as the previously created one.

To duplicate a tag:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab.
1. In the line with the tag you need to duplicate, click ![icon](../../../../_assets/console-icons/ellipsis.svg) and then ![icon](../../../../_assets/console-icons/copy.svg) **{{ ui-key.yc-ui-talkanalytics.common.duplicate }}**.

    In the window that opens, you will see that the new tag uses the source tag settings as default values. The default name of the new tag is `<source_tag_name> copy`.

1. Optionally, [configure](#new-tag) tag settings. These are the same settings you specify when creating a new tag.
1. Click **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.
