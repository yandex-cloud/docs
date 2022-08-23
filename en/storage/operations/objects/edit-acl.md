# Editing an object ACL

Aside from [{{ iam-short-name }}](../../../iam/index.yaml), {{ objstorage-name }} supports access control through [ACL](../../concepts/acl.md).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ objstorage-name }}**.
   1. Click the bucket name.
   1. To edit an ACL, click ![image](../../../_assets/horizontal-ellipsis.svg) to the right of an object name and select the **object ACL**.

      You can also click the object name, click ![image](../../../_assets/horizontal-ellipsis.svg) on the resulting page, and select the **object ACL**.

   1. In the **Edit ACL** window, grant or revoke the desired permissions.

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To edit an object ACL:

   1. Open the {{ TF }} configuration file and add the `acl` parameter to the object description.

      ```hcl
      ...
      resource "yandex_storage_object" "cute-cat-picture" {
        access_key = "<static_key_ID>"
        secret_key = "<secret_key>"
        bucket     = "cat-pictures"
        key        = "cute-cat"
        source     = "/images/cats/cute-cat.jpg"
        acl        = "public-read"
      }
      ...
      ```

      Where:
      * `access_key`: The ID of the static access key.
      * `secret_key`: The value of the secret access key.
      * `acl`: [Predefined ACL](../../../storage/concepts/acl.md#predefined-acls) of an object. `private` (default): {{ yandex-cloud }} users are authorized based on their roles in {{ iam-short-name }}.

      For more information about the `yandex_storage_object` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/storage_object).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contain errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change to a security group in the [management console]({{ link-console-main }}).

{% endlist %}
