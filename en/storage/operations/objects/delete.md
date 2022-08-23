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

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete an object created with {{ TF }} from a bucket:

   1. Open the {{ TF }} configuration file and delete the fragment with the object description.

      {% cut "Example object description in a {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_storage_object" "cute-cat-picture" {
        access_key = "YCAJEX9Aw2ge1VKjlYXf-w-lJ"
        secret_key = "YCONxG7rSdzVF9UMxLA_NRy5VbKzKlqZMcSJz2N0"
        bucket     = "cat-pictures"
        key        = "cute-cat"
        source     = "/images/cats/cute-cat.jpg"
      }
      ...
      ```

      {% endcut %}

   1. In the command line, go to the directory with the {{ TF }} configuration file.

   1. Check the configuration using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contain errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes in the [management console]({{ link-console-main }}).

{% endlist %}
