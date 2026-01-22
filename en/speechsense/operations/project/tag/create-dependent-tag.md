---
title: Creating a dependent tag
description: Follow this guide to create a dependent semantic or dictionary tag for a project and turn on remainder display for the main tag.
---

# Creating a dependent tag

For any tag in your project, you can create a [dependent tag](../../../concepts/tags.md#dependent-tags). For a tag that has dependent tags, you can turn on and off the [remainder](../../../concepts/tags.md#remaining-tags) display.

The role of main and dependent tags can be played by both dictionary and semantic tags in any combination. If you create a dependent dictionary tag for a semantic tag, you cannot set a constraint for this dictionary tag.

Dependent tags can be edited based on their type as basic [semantic](change-sense-tag.md), [semantic Pro](change-sense-pro-tag.md), or [dictionary](change-dictionary-tag.md) tags.

## Creating a dependent semantic or dictionary tag {#create-tag}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the **{{ ui-key.yc-ui-talkanalytics.tags.tags }}** tab, select a tag and click ![icon](../../../../_assets/console-icons/ellipsis.svg).
1. From the drop-down list, select ![icon](../../../../_assets/console-icons/link.svg) **{{ ui-key.yc-ui-talkanalytics.tags.create-dependent-tag }}**.
1. Depending on the type of the tag you are creating, configure the [semantic](create-sense-tag.md#new-tag), [semantic Pro](create-sense-pro-tag.md), or [dictionary](create-dictionary-tag.md#new-tag) tag and click **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.

## Turning tag remainder display on and off {#enable-remainder}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. On the **{{ ui-key.yc-ui-talkanalytics.tags.tags }}** tab, find the tag of interest and turn the **Remainder** option on or off.

Once enabled, the tag remainder will be applied to all new dialogs.
