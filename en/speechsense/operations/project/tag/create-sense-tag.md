---
title: Creating a semantic tag
description: Follow this guide to create a semantic tag of your project.
---

# Creating a semantic tag

You can only create a [semantic tag](../../../concepts/tags.md#sense-tags) in a [project](../../../concepts/resources-hierarchy.md#project). To do this, you need the `{{ roles-speechsense-admin }}` or `{{ roles-speechsense-editor }}` role in the project.

When creating a semantic tag, the following options are available:

* [Create a new tag](#new-tag).
* [Add a dependent tag](create-dependent-tag.md) for an existing tag.

## Creating a tag {#new-tag}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the **{{ ui-key.yc-ui-talkanalytics.tags.tags }}** tab, click ![icon](../../../../_assets/console-icons/tag.svg) **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.
1. Select the tag type: **{{ ui-key.yc-ui-talkanalytics.tags.tags-type.neuro-key-value }}**.
1. Set the tag parameters:

    * Enter a name for the tag.
    * (Optional) Enter a tag description.

    * {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
    * {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}
    * {% include [data-analisys](../../../../_includes/speechsense/tag/data-analysis.md) %}

    * (Optional) Enable [tag testing](test.md).

    {% note info %}

    By default, semantic tags get the `Agent` and `Customer` channels assigned at the same time, and this cannot be changed.

    {% endnote %}

1. Click **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.

Once created, tags are applied to all new dialogs in one go. The markup of previously created dialogs starts at 09:00 p.m. Moscow time.