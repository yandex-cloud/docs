# Adding a dictionary to a tag

After [creating a dictionary](create.md), you can edit a [dictionary tag](../../concepts/tags.md#dictionary-tags) and add the [dictionary](../../concepts/dictionaries.md) to it. The tag will then apply to conversations containing trigger phrases from the dictionary.

You can also add a dictionary when [creating a dictionary tag](../project/tag/create-dictionary-tag.md#new-tag).

To change a project tag, you need either the `{{ roles-speechsense-admin }}` or the `{{ roles-speechsense-editor }}` role for the project.

To add a dictionary to an existing tag:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. On the **{{ ui-key.yc-ui-talkanalytics.tags.tags }}** tab, click the line with the required tag.
1. In the window that opens, click ![icon](../../../_assets/console-icons/book-open.svg) **{{ ui-key.yc-ui-talkanalytics.dictionaries.add-dictionary }}** in the **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** field.
1. Select the dictionaries you need from the drop-down list.
1. Click **{{ ui-key.yc-ui-talkanalytics.common.apply }}** and then **{{ ui-key.yc-ui-talkanalytics.common.save }}**.
