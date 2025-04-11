---
title: Editing a dictionary
description: Follow this guide to edit a space or project dictionary.
---

# Editing a dictionary

You can edit space or project dictionaries. You cannot edit system dictionaries marked with ![icon](../../../_assets/console-icons/lock.svg).

To edit a [dictionary](../../concepts/dictionaries.md), you need the `{{ roles-speechsense-admin }}` or `{{ roles-speechsense-editor }}` role in the [space](../../concepts/resources-hierarchy.md#space) or [project](../../concepts/resources-hierarchy.md#project) where the dictionary resides.

{% note warning %}

Changes to a dictionary apply to dialogs you upload to the project afterwards as well as existing dialogs no more than 60 days old.

{% endnote %}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space of your choice.

   To edit a project dictionary, select the project you need.

1. On the **{{ ui-key.yc-ui-talkanalytics.dictionaries.dictionaries }}** tab, click the line with the required dictionary.
1. In the window that opens, set the following configuration:

   * Dictionary name and description.
   * **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}**: Use a separate line for each trigger phrase. {{ speechsense-name }} will scan the conversation for the keywords and assign a [dictionary tag](../../concepts/tags.md#dictionary-tags) to the recording if it finds any.

1. Click **{{ ui-key.yc-ui-talkanalytics.common.save }}**.
