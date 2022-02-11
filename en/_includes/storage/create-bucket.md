{% list tabs %}

- Management console
  1. In the management console, select the folder where you want to create a [bucket](../../storage/concepts/bucket.md) name.
  1. Select **Object Storage**.
  1. Click **Create bucket**.
  1. On the bucket creation page:
      1. Enter the bucket name, following the [naming guidelines](../../storage/concepts/bucket.md#naming).
      1. If necessary, limit the maximum bucket size.

         {% include [storage-no-max-limit](../../storage/_includes_service/storage-no-max-limit.md) %}

      1. Select the type of [access](../../storage/concepts/bucket.md#bucket-access).
      1. Select the default [storage class](../../storage/concepts/storage-class.md).
      1. Click **Create bucket** to complete the operation.

- Terraform

  If you don't have Terraform yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Before you start, get [static access keys](../../iam/operations/sa/create-access-key.md): a private key and key ID used for authentication in {{ objstorage-short-name }}.

  1. In the configuration file, describe the parameters of resources that you want to create:

     * `access_key`: The ID of the static access key.
     * `secret_key`: The value of the private access key.
     * `bucket`: The name of the bucket being created. Optional parameter. If omitted, a random unique bucket name is generated.

     ```
     provider "yandex" {
       token     = "<OAuth>"
       cloud_id  = "<cloud ID>"
       folder_id = "<folder ID>"
       zone      = "ru-central1-a"
     }
     
     resource "yandex_storage_bucket" "test" {
       access_key = "<static key identifier>"
       secret_key = "<secret key>"
       bucket = "<bucket name>"
     }
     ```

     For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

  1. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.
     1. Run the check using the command:
        ```
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

  1. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:
     ```
     terraform apply
     ```
     1. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

{% endlist %}
