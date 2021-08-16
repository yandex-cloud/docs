# Deleting an object

{% list tabs %}

- Management console

  1. In the management console, select the appropriate folder.

  1. Select **Object Storage**.

  1. Click the name of the desired bucket.

  1. To delete a single object, click ![image](../../../_assets/vertical-ellipsis.svg) to the left of the object name, and in the menu that opens, click **Delete**.

      To do the same with multiple objects, select them from the list, and at the bottom of the screen, click **Delete**.

      {% note info %}

      You can delete a folder with objects. This is an asynchronous operation. Once run, objects are gradually deleted from the bucket instead of all at once. During this time, you can perform other operations in the management console, including upload new objects to the folder being deleted. For more information, see [Folder](../../concepts/object.md#folder).

      {% endnote %}

  1. Confirm the deletion.

{% endlist %}

