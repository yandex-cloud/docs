# Removing a dictionary

In {{ speechsense-name }}, you can delete space or project [dictionaries](../../concepts/dictionaries.md), but you cannot delete system ones.

To delete a dictionary, you need the `{{ roles-speechsense-admin }}` or `{{ roles-speechsense-editor }}` role in the [space](../../concepts/resources-hierarchy.md#space) or [project](../../concepts/resources-hierarchy.md#project), depending on where the dictionary resides.

To delete a dictionary:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.

   To delete a project dictionary, select the project.

1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.dictionaries.dictionaries }}** tab.
1. In the dictionary row, click ![icon](../../../_assets/console-icons/ellipsis.svg), then click ![icon](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yc-ui-talkanalytics.common.delete-key-value }}**.
1. Confirm dictionary deletion.

If you did not remove the dictionary from the tag before deleting it, you will still see that dictionary on the tag page, marked as deleted. The tag with the dictionary will apply to the already uploaded conversations but not the new ones.
