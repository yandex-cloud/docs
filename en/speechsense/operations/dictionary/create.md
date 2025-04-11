# Creating a dictionary

Create a [dictionary](../../concepts/dictionaries.md) to group trigger phrases together and reuse them across multiple [dictionary tags](../../concepts/tags.md#dictionary-tags). If conversations uploaded to {{ speechsense-name }} contain trigger phrases from a dictionary, they will get a tag with that dictionary.

To create a dictionary, you need the `{{ roles-speechsense-admin }}` or `{{ roles-speechsense-editor }}` role in the [space](../../concepts/resources-hierarchy.md#space) or [project](../../concepts/resources-hierarchy.md#project) where you a creating the dictionary.

To create a dictionary:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space of your choice.

   To create a project dictionary, select the project you need.

1. In the **{{ ui-key.yc-ui-talkanalytics.dictionaries.dictionaries }}** tab, click ![icon](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.dictionaries.create-dictionary-key-value }}**.
1. Name your dictionary.
1. (Optional) Describe your dictionary.
1. In the **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** field, list trigger phrases. If a conversation contains one of these phrases, it will get a tag with this dictionary.

   Use a separate line for each one.

   {% cut "Field input example" %}

   ```text
   already contacted
   contacted already
   contacting again
   contacting once again
   contacted an agent
   an agent was contacted by
   ```

   {% endcut %}

1. Click **{{ ui-key.yc-ui-talkanalytics.dictionaries.create-dictionary-key-value }}**.

Now you can [add the dictionary](add.md) to the existing dictionary tags or specify it when [creating a new dictionary tag](../project/tag/create-dictionary-tag.md#new-tag).

Dictionaries created in a space are available in projects within that space by default.
