---
title: Creating a semantic Pro tag
description: Follow this guide to create a semantic Pro tag for your project.
---

# Creating a semantic Pro tag

You can only create a [semantic Pro tag](../../../concepts/tags.md#sense-pro-tags) in a [project](../../../concepts/resources-hierarchy.md#project). To do this, you need the `{{ roles-speechsense-admin }}` or `{{ roles-speechsense-editor }}` role in the project.


When creating a semantic Pro tag, the following options are available:

* [Create a new tag](#new-tag).
* [Add a dependent tag](create-dependent-tag.md) for an existing tag.

## Creating a tag {#new-tag}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the **{{ ui-key.yc-ui-talkanalytics.tags.tags }}** tab, click ![icon](../../../../_assets/console-icons/tag.svg) **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.
1. Select the tag type: **{{ ui-key.yc-ui-talkanalytics.tags.tags-type.neuro-pro-key-value }}**.
1. Set the tag parameters:

    * Enter a name for the tag.
    * Optionally, enter a tag description.

    * {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
    * {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}
    * {% include [data-analisys-pro](../../../../_includes/speechsense/tag/data-analysis-pro.md) %}

    * Optionally, enable [tag testing](test.md).

    {% note info %}

    By default, semantic Pro tags get the `Agent` and `Customer` channels assigned at the same time, and this cannot be changed.

    {% endnote %}

1. Click **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.

The new tags will only apply to dialogs uploaded after the tag was created. The required tags will be assigned automatically.