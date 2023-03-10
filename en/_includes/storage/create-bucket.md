The minimum role required to create a bucket is `storage.editor`. See the [role description](../../storage/security/#storage-editor).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [bucket](../../storage/concepts/bucket.md).
   1. Select **{{ objstorage-name }}**.
   1. Click **Create bucket**.
   1. On the bucket creation page:
      1. Enter the bucket name, following the [naming guidelines](../../storage/concepts/bucket.md#naming).

         By default, a bucket with a dot in the name is only available over HTTP. To provide HTTPS support for your bucket, [upload your own security certificate](../../storage/operations/hosting/certificate.md) to{{ objstorage-name }} .

      1. If necessary, limit the maximum bucket size.

         {% include [storage-no-max-limit](../../storage/_includes_service/storage-no-max-limit.md) %}

      1. Selected the type of [access](../../storage/concepts/bucket.md#bucket-access).
      1. Select the default [storage class](../../storage/concepts/storage-class.md).
      1. Click **Create bucket** to complete the operation.

- {{ yandex-cloud }} CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   1. View a description of the CLI command to create a bucket:

      ```bash
      yc storage bucket create --help
      ```

   1. Create a bucket in the default folder:

      ```bash
      yc storage bucket create \
        --name <bucket_name> \
        --default-storage-class <storage_class> \
        --max-size <maximum_bucket_size> \
        --public-read \
        --public-list \
        --public-config-read
      ```

      Where:

      * `--name`: Bucket name. For more information, see [Bucket naming rules](../../storage/concepts/bucket.md#naming).

         By default, a bucket with a dot in the name is only available over HTTP. To provide HTTPS support for your bucket, [upload](../../storage/operations/hosting/certificate.md) your own security certificate to {{ objstorage-name }}.
      * `--default-storage-class`: [Storage class](../../storage/concepts/storage-class.md). Possible values:
         * `standard`: Standard storage.
         * `cold`: Cold storage.
         * `ice`: Ice storage.
      * `--max_size`: Maximum bucket size (bytes). `0`: No limit.
      * `--public-read`: Flag to enable public read access to bucket objects.
      * `--public-list`: Flag to enable public access to view the list of bucket objects.
      * `--public-config-read`: Flag to enable public read access to the bucket configuration.

      The `name` parameter is required. Other parameters are optional. By default, the `--max-size` parameter is set to `0` and public access to the bucket is disabled.

      Result:

      ```yaml
      name: first-bucket
      folder_id: b1gmit33ngp6cv2mhjmo
      anonymous_access_flags:
        read: false
        list: false
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "53687091200"
      acl: {}
      created_at: "2022-12-16T14:05:12.196007Z"
      ```

- {{ TF }}

   If you do not have {{ TF }} yet, {% if audience != "internal" %}[install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}install it and configure the {{ yandex-cloud }} provider{% endif %}.

   1. In the configuration file, describe the parameters of resources that you want to create:

      {% if product == "yandex-cloud" %}

      ```
      provider "yandex" {
        token     = "<IAM_or_OAuth_token>"
        cloud_id  = "<cloud_ID>"
        folder_id = "<folder_ID>"
        zone      = "{{ region-id }}-a"
      }

      resource "yandex_iam_service_account" "sa" {
        name = "<service_account_name>"
      }

      // Assigning roles to the service account
      resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
        folder_id = "<folder_ID>"
        role      = "storage.editor"
        member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
      }

      // Creating a static access key
      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
        service_account_id = yandex_iam_service_account.sa.id
        description        = "static access key for object storage"
      }

      // Creating a bucket using the key
      resource "yandex_storage_bucket" "test" {
        access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
        secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
        bucket     = "<bucket_name>"
      }
      ```

      {% endif %}

      {% if product == "cloud-il" %}

      ```
      provider "yandex" {
        endpoint         = "{{ api-host }}:443"
        token            = "<IAM token>"
        cloud_id         = "<cloud_ID>"
        folder_id        = "<folder_ID>"
        zone             = "{{ region-id }}-a"
        storage_endpoint = "{{ s3-storage-host }}"
      }

      resource "yandex_iam_service_account" "sa" {
        name = "<service_account_name>"
      }

      // Assigning roles to the service account
      resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
        folder_id = "<folder_ID>"
        role      = "storage.editor"
        member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
      }

      // Creating a static access key
      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
        service_account_id = yandex_iam_service_account.sa.id
        description        = "static access key for object storage"
      }

      // Creating a bucket using the key
      resource "yandex_storage_bucket" "test" {
        access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
        secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
        bucket     = "<bucket_name>"
      }
      ```

      {% endif %}

      Where:

      * `yandex_iam_service_account` is the description of the service account that will create and use a bucket:
         * `name`: Service account name.
      * `yandex_storage_bucket`: Bucket description:
         * `bucket`: Bucket name.

      For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/storage_bucket).

   1. Make sure that the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:
         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contains errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:
         ```
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

{% endlist %}
