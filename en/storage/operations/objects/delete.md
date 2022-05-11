# Deleting an object

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ objstorage-name }}**.
   1. Click the name of the desired bucket.
   1. To delete a single object, click ![image](../../../_assets/horizontal-ellipsis.svg) to the right of the object name and click **Delete** in the resulting window.

      To do the same with multiple objects, select them in the list and click **Delete** at the bottom of the screen.

      {% note info %}

      You can delete a folder with objects. This is an asynchronous operation. Once run, objects are gradually deleted from the bucket instead of all at once. During this time, you can perform other operations in the management console, including upload new objects to the folder being deleted. For more information, see [Folder](../../concepts/object.md#folder).

      {% endnote %}
   1. Confirm the deletion.

{% endlist %}
