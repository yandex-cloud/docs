---
title: Changing a semantic tag
description: Follow this guide to change a project semantic tag.
---

# Changing a semantic tag

You can do the following with a project [semantic tag](../../../concepts/tags.md#sense-tags):

* [Update its settings](#edit).
* [Activate or deactivate the tag](#activate-tag).

To change a project tag, you need either the `{{ roles-speechsense-admin }}` or the `{{ roles-speechsense-editor }}` role for the project.

{% include [after-changing-tags](../../../../_includes/speechsense/tag/after-changing-tags.md) %}

## Updating tag settings {#edit}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the **{{ ui-key.yc-ui-talkanalytics.tags.tags }}** tab, select the tag you need and click **{{ ui-key.yc-ui-talkanalytics.common.edit }}**.
1. In the window that opens, update the settings as needed:

    * Enter a name and description for the tag.
    * {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
    * {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}
    * {% include [data-analisys](../../../../_includes/speechsense/tag/data-analysis.md) %}
    * Enable [tag testing](test.md).

1. Click **{{ ui-key.yc-ui-talkanalytics.common.save }}**.

## Activating or deactivating a tag {#activate-tag}

{% include notitle [activation](../../../../_includes/speechsense/tag/activation.md) %}
