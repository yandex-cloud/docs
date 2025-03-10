---
title: Creating a dependent tag
description: Follow this guide to create a dependent semantic or dictionary tag for a project.
---

# Creating a dependent tag

For any tag in your project, you can create a [dependent tag](../../../concepts/tags.md#dependent-tags):

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab, select a tag and click ![icon](../../../../_assets/console-icons/ellipsis.svg).
1. From the drop-down list, select ![icon](../../../../_assets/console-icons/link.svg) **{{ ui-key.yc-ui-talkanalytics.tags.create-dependent-tag }}**.
1. Depending on the type of the tag you are creating, configure the [semantic](create-sense-tag.md#new-tag) or [dictionary](create-dictionary-tag.md#new-tag) tag and click **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.

Both dictionary and semantic tags can act as basic and dependent tags, in any combination. If you create a dependent dictionary tag for a semantic tag, you cannot set a constraint for this dictionary tag.

You can edit dependent tags in accordance with their type as basic [semantic](change-sense-tag.md) or [dictionary](change-dictionary-tag.md) tags.
