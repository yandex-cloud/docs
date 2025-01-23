---
title: Editing a dictionary
description: Follow this guide to edit a space or project dictionary.
---

# Editing a dictionary

When working with a space or project [dictionary](../../concepts/dictionaries.md), you can:

* [Edit the dictionary](#edit).
* [Activate or deactivate the dictionary](#activate).

For system dictionaries, you can only change their activation status.

To edit a dictionary, you need the `{{ roles-speechsense-admin }}` or `{{ roles-speechsense-editor }}` role in the [space](../../concepts/resources-hierarchy.md#space) or [project](../../concepts/resources-hierarchy.md#project) where the dictionary resides.

{% note warning %}

Changes to a dictionary will only apply to conversations you upload to the project after the changes are made.

{% endnote %}

## Editing a dictionary {#edit}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the appropriate space.

   To edit a project dictionary, select the project you need.

1. On the **Dictionaries** tab, click the line with the dictionary.
1. In the window that opens, set the following configuration:

   * Dictionary name and description.
   * **Keywords**: Use a separate line for each trigger phrase. {{ speechsense-name }} will scan the conversation for the keywords and assign a [tag](../../concepts/tags.md) with the dictionary to the recording if it finds any.

1. Click **Save**.

## Activating or deactivating a dictionary {#activate}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the appropriate space.

   To change the project dictionary activation status, select the project.

1. Go to the **Dictionaries** tab.
1. In the line with the dictionary you need, enable **Use in projects** to activate the dictionary. Disable to deactivate it.
1. When deactivating, you will be prompted to confirm the action. Confirm to proceed.

Changes apply to new conversations only:

* Tag containing an activated dictionary will apply to conversations uploaded after activation.
* Tags containing a deactivated dictionary will apply to the already uploaded conversations but not the new ones.
