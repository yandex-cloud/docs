# Editing a bucket ACL

In addition to [{{ iam-short-name }}](../../../iam/index.yaml), {{ objstorage-name }} supports access control using [ACLs](../../concepts/acl.md).

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the appropriate folder.

    1. Select **{{ objstorage-name }}**.

    1. To edit the ACL, click ![image](../../../_assets/horizontal-ellipsis.svg) to the right of the bucket name and select **Bucket ACL**.

        You can also click the bucket name and then click **Bucket ACL** on the page that opens.

    1. In the **Edit ACL** window, grant or revoke the desired permissions.

- {{ TF }}

  If you don't have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Before you start, get [static access keys](../../../iam/operations/sa/create-access-key.md): a private key and key ID used for authentication in {{ objstorage-short-name }}.

  1. In the configuration file, describe the parameters of resources that you want to create:

     ```
     resource "yandex_storage_bucket" "test" {
       access_key = "<static key identifier>"
       secret_key = "<secret key>"
       bucket = "<bucket name>"
       grant {
         id          = "<user ID>"
         type        = "CanonicalUser"
         permissions = ["FULL_CONTROL"]
       }
     
       grant {
         type        = "Group"
         permissions = ["READ", "WRITE"]
         uri         = "http://acs.amazonaws.com/groups/global/AllUsers"
       }
     }
     ```

     Where:

     * `access_key`: The ID of the static access key.
     * `secret_key`: The value of the private access key.
     * `bucket`: Bucket name. Required parameter.
     * `grant`: [ACL](../../concepts/acl.md) access policy settings. Optional. For access management, use a service account with administrator rights.

       * `id`: User ID.
       * `type`: System group type.
       * `permissions`: Types of permissions according to the [ACL](../../concepts/acl.md#permissions-types).
       * `uri`: System group ID.

     For more information about the resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}).

  1. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.
     1. Run the check using the command:

        ```
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

  1. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:
     ```
     terraform apply
     ```

     1. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

{% endlist %}

