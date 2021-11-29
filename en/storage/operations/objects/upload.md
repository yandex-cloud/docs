# Uploading an object

You can create folders inside buckets and upload objects there. Keep in mind that in the SDK and HTTP API, an object key is the entire path to the object from the bucket root. For more information, see [{#T}](../../concepts/object.md).

{% note info %}

You can upload objects of up to 5 GB via the management console (see [{#T}](../../concepts/limits.md)). Also, when uploading via the console, you can't set `content-type` or other headers. To upload large objects or specify object headers, use other [tools](../../tools/index.md).

{% endnote %}

{% list tabs %}

- Management console

  In the management console, you can work with {{ objstorage-name }} buckets like a hierarchical file system.

  To upload an object:
  1. In the [management console]({{ link-console-main }}), select the folder to upload the object to.
  1. Select **{{ objstorage-name }}**.
  1. Click the name of the desired bucket.
  1. If you want to upload the object to a particular folder, go to that folder by clicking on its name. If you want to create a new folder, click **Create folder**.
  1. Once you are in the appropriate folder, click **Upload**.
  1. In the window that opens, select the required files and click **Open**.
  1. The management console displays all the objects selected for uploading and prompts you to select a [storage class](../../concepts/storage-class.md). The default storage class is defined in the [bucket settings](../../concepts/bucket.md#bucket-settings).
  1. Click **Upload**.

- AWS CLI

  To load all objects from the local directory, use the following command:

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }}/ \
  s3 cp --recursive <path to local directory>/ s3://<bucket name>/<prefix>/
  ```

  Where:
  * `<path to local directory>`: Path to the folder on your device that contains the files to copy.
  * `<bucket name>`: Name of your bucket.
  * `<prefix>`: ID of a folder in storage as described in [{#T}](../../concepts/object.md#folder).

- Terraform

  Example of creating an object in an existing bucket.

  If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  Before you start, get [static access keys](../../../iam/operations/sa/create-access-key.md): a private key and key ID used for authentication in {{ objstorage-short-name }}.

  1. In the configuration file, describe the parameters of resources that you want to create:

     ```
     provider "yandex" {
       token     = "<OAuth>"
       cloud_id  = "<cloud ID>"
       folder_id = "<folder ID>"
       zone      = "ru-central1-a"
     }
     
     resource "yandex_storage_object" "test-object" {
       access_key = "<static key ID>" # Static access key ID.
       secret_key = "<secret key>" # Secret access key value.
       bucket = "<bucket name>" # Name of the bucket to add an object to. Required parameter.
       key    = "<object name>" # Name of object in bucket. Required parameter.
       source = "<file path>" # Relative or absolute path to a file uploaded as an object.
     }
     ```

     For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

  1. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.

     1. Run the check using the command:

        ```bash
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

  1. Deploy the cloud resources.
     1. If the configuration doesn't contain any errors, run the command:
        
        ```bash
        terraform apply
        ```
     1. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

{% endlist %}

