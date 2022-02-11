# Hosting setup

{{ objstorage-name }} lets you configure a bucket:

- For static website hosting.
- For request redirects.

{% list tabs %}

- Management console

  1. In the management console, go to the bucket you want to configure hosting for.
  1. Make sure public access is allowed to the bucket. If not, follow the instructions [{#T}](../buckets/bucket-availability.md).
  1. In the left pane, select **Website**.
  1. Set up hosting or redirects in the corresponding section of the settings.
      - When setting up hosting, specify:
        - The website homepage.
        - The page to be displayed to the user in the event of 4xx errors. Optional.
      - When setting up redirects, specify:
        - The host where all requests to the current bucket will be redirected.
        - The protocol if the specified host accepts requests strictly over a specific protocol.

- Terraform

  If you don't have Terraform yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Before you start, get [static access keys](../../../iam/operations/sa/create-access-key.md): a private key and key ID used for authentication in {{ objstorage-short-name }}.

  1. In the configuration file, describe the parameters of resources that you want to create:

     * `access_key`: The ID of the static access key.
     * `secret_key`: The value of the private access key.
     * `bucket`: Bucket name.
     * `acl`: Parameters for [ACL](../../concepts/acl.md#predefined-acls) access control.
     * `website`: Website parameters:

       * `index_document`: Absolute path to the file of the website's homepage. Required parameter.
       * `error_document`: Absolute path to the file to be displayed to the user in the event of `4xx` errors. Optional.

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
       acl    = "public-read"
     
       website {
         index_document = "index.html"
         error_document = "error.html"
       }
     
     }
     ```

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

