# Creating a dictionary

Create a [dictionary](../../concepts/dictionaries.md) to group trigger phrases together and reuse them across multiple [tags](../../concepts/tags.md). If conversations uploaded to {{ speechsense-name }} contain trigger phrases from a dictionary, they will get a tag with that dictionary.

To create a dictionary, you need the `{{ roles-speechsense-admin }}` or `{{ roles-speechsense-editor }}` role in the [space](../../concepts/resources-hierarchy.md#space) or [project](../../concepts/resources-hierarchy.md#project) where you a creating the dictionary.

To create a dictionary:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the appropriate space.

   To create a project dictionary, select the project you need.

1. On the **Dictionaries** tab, click ![icon](../../../_assets/console-icons/plus.svg) **Create dictionary**.
1. Name your dictionary.
1. (Optional) Describe your dictionary.
1. In the **Key phrases** field, list trigger phrases. If a conversation contains one of these phrases, it will get a tag with this dictionary.

   Use a separate line for each each trigger phrase.

   {% cut "Field input example" %}

   ```text
   already contacted
   contacted already
   contacting again
   contacting once again
   contacted the agent
   the agent was contacted
   ```

   {% endcut %}

1. Click **Create dictionary**.

Now you can [add the dictionary](add.md) to the existing tags or specify it when [creating a new tag](../project/tag/create.md#new-tag).

Dictionaries created in a space are available in projects within that space by default. You can [disable a dictionary](change.md#activate) at the space or project level.
