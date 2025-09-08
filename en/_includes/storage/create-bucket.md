

To create a [bucket](../../storage/concepts/bucket.md), you need the _minimum_ `storage.editor` [role](../../storage/security/#storage-editor) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
  1. Select **{{ objstorage-name }}**.
  1. In the top panel, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. On the bucket creation page:

      1. Enter the bucket name consistent with the [naming conventions](../../storage/concepts/bucket.md#naming).

          
          By default, a bucket with a dot in the name is only available over HTTP. To provide HTTPS support for your bucket, [upload your own security certificate](../../storage/operations/hosting/certificate.md) to {{ objstorage-name }}.


      1. Add [labels](../../storage/concepts/tags.md), if required:

          1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          1. Enter a label in `key: value` format.
          1. Press **Enter**.

      1. Limit the maximum bucket size, if required.

          {% include [storage-no-max-limit](../../storage/_includes_service/storage-no-max-limit.md) %}

      1. Configure [public access](../../storage/security/public-access.md) to read [objects](../../storage/concepts/object.md) in the bucket, get a list of objects, and read bucket settings:

          * `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`: Authorized {{ yandex-cloud }} users only.
          * `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`: All users.

          {% include [public-access-warning](./security/public-access-warning.md) %}

      1. Select the default [storage class](../../storage/concepts/storage-class.md):

          * `{{ ui-key.yacloud.storage.bucket.settings.class_value_standard }}`
          * `{{ ui-key.yacloud.storage.bucket.settings.class_value_cold }}`
          * `{{ ui-key.yacloud.storage.bucket.settings.class_value_ice }}`

          Cold classes are for long-term storage of objects you intend to use less frequently. The colder the storage, the cheaper it is to store data in, but the more expensive it is to read from and write to it.

      1. Enable encryption if you need to: in the **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** field, select an existing [symmetric key](../../kms/concepts/key.md) or [create](../../kms/operations/key.md#create) a new one.

      1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}** to complete the operation.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  {% include [create-bucket-via-cli](./create-bucket-via-cli.md) %}

- AWS CLI {#aws-cli}

  {% include [aws-cli-install](../../_includes/aws-cli-install.md) %}

  To create a bucket, [assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.editor` [role](../../storage/security/index.md#storage-editor) to the service account used by the AWS CLI.

  In the terminal, run this command:

  ```bash
  aws s3api create-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <bucket_name>
  ```

  Where:

  * `--endpoint-url`: {{ objstorage-name }} endpoint.
  * `--bucket`: Bucket name.

  
  {% note info %}

  By default, a bucket with a dot in the name is only available over HTTP. To provide HTTPS support for your bucket, [upload](../../storage/operations/hosting/certificate.md) your own security certificate to {{ objstorage-name }}. For more information, see [Bucket naming rules](../../storage/concepts/bucket.md#naming).

  {% endnote %}


  Result:

  ```text
  {
    "Location": "/<bucket_name>"
  }
  ```

  The new bucket will have the following parameters:
  * Maximum size unlimited.
  * Limited [access](../../storage/concepts/bucket.md#bucket-access) to read objects, get a list of objects, and read bucket setting.
  * [Storage class](../../storage/concepts/storage-class.md): `Standard`.

  {% cut "Optional parameters" %}

  You can apply a [predefined ACL](../../storage/concepts/acl.md#predefined-acls) to a bucket or configure permissions for individual users, [service accounts](../../iam/concepts/users/service-accounts.md), [user groups](../../organization/concepts/groups.md), and [public groups](../../storage/concepts/acl.md#public-groups), such as a group of all internet users or a group of all authenticated {{ yandex-cloud }} users. You cannot use these settings together: a bucket can have either a predefined ACL or individual permissions.

  {% note info %}

  To manage bucket [ACL](../../storage/concepts/acl.md) settings, [assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.admin` [role](../../storage/security/index.md#storage-admin) to the service account used by the AWS CLI.

  {% endnote %}

  **Predefined ACL**

  ```bash
  aws s3api create-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <bucket_name> \
    --acl <predefined_ACL>
  ```

  Where `--acl` is a predefined ACL. For a list of values, see [Predefined ACLs](../../storage/concepts/acl.md#predefined-acls).

  **Individual permissions**

  ```bash
  aws s3api create-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <bucket_name> \
    <permission_type> <permission_grantee>
  ```

  Where:
  * The possible types of ACL permissions are as follows:
    * `--grant-read`: Permission to access the list of objects in the bucket, read various bucket settings (lifecycle, CORS, and static hosting), and read all objects in the bucket.
    * `--grant-write`: Permission to write, overwrite, and delete objects in the bucket. It can only be used together with `--grant-read`.
    * `--grant-full-control`: Full access to the bucket and objects in it.

    You can specify multiple permissions in a single command.
  * The possible permission grantees are as follows:
    * `id=<grantee_ID>`: ID of the user, service account, or user group you need to grant a permission to.
    * `uri=http://acs.amazonaws.com/groups/global/AuthenticatedUsers`: [Public group](../../storage/concepts/acl.md#public-groups) that includes all authenticated {{ yandex-cloud }} users.
    * `uri=http://acs.amazonaws.com/groups/global/AllUsers`: Public group that includes all internet users.

  By default, an empty ACL is created for each new bucket.

  {% endcut %}

  For more information about the `aws s3api create-bucket` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/create-bucket.html).

- {{ TF }} {#tf}

  {% include [terraform-role](terraform-role.md) %}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  
  {% include [terraform-install](../../_includes/terraform-install.md) %}


  {% include [iam-auth-note](iam-auth-note.md) %}

  **Creating a bucket using an IAM token**

  
  1. [Get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) and add them to environment variables.


  1. In the configuration file, describe the parameters of resources you want to create:

      ```hcl
      # Creating a bucket using an IAM token

      resource "yandex_storage_bucket" "iam-bucket" {
        bucket    = "<bucket_name>"
        folder_id = "<folder_ID>"
      }
      ```

      Where:
      * `bucket`: Bucket name. This is a required parameter.

        
        By default, a bucket with a dot in the name is only available over HTTP. To provide HTTPS support for your bucket, [upload your own security certificate](../../storage/operations/hosting/certificate.md) to {{ objstorage-name }}.

      
      * `folder_id`: Folder ID

         If using a user account IAM token, specify `folder_id` in the `yandex_storage_bucket` resource.

         If using an IAM token of a service account or static access keys, you do not have to specify `folder_id`. You will only need it to create a resource in a folder other than the service account folder.

         {% endnote %}

      For more information about `yandex_storage_bucket` properties, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/storage_bucket).

  1. Create the resources:

        {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  {{ TF }} will create all the required resources. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).


  **Creating a bucket using a static key**

  1. In the configuration file, describe the parameters of resources you want to create:

      {% cut "Creating a bucket using a key" %}

      ```hcl
      terraform {
        required_providers {
          yandex = {
            source = "yandex-cloud/yandex"
          }
        }
        required_version = ">= 0.13"
      }

      # Configuring the provider
      
      provider "yandex" {
        token     = "<IAM_or_OAuth_token>"
        cloud_id  = "<cloud_ID>"
        folder_id = "<folder_ID>"
        zone      = "{{ region-id }}-a"
      }

      # Creating a service account
      
      resource "yandex_iam_service_account" "sa" {
        name = "<service_account_name>"
      }

      # Assigning roles to a service account
      
      resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
        folder_id = "<folder_ID>"
        role      = "storage.admin"
        member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
      }

      # Creating a static access key
      
      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
        service_account_id = yandex_iam_service_account.sa.id
        description        = "static access key for object storage"
      }

      # Creating a bucket using a static key
      
      resource "yandex_storage_bucket" "test" {
        access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
        secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
        bucket                = "<bucket_name>"
        max_size              = <maximum_bucket_size>
        default_storage_class = "<storage_class>"
        anonymous_access_flags {
          read        = <true|false>
          list        = <true|false>
          config_read = <true|false>
        }
        tags = {
          <key_1> = "<value_1>"
          <key_2> = "<value_2>"
          ...
          <key_n> = "<value_n>"
        }
      }
      ```

      {% endcut %}

      Where:
      * `yandex_iam_service_account`: Description of the [service account](../../iam/concepts/users/service-accounts.md) to create and use the [bucket](../../storage/concepts/bucket.md):

        * `name`: Service account name. This is a required parameter.
        * `bucket`: Bucket name.

          
          By default, a bucket with a dot in the name is only available over HTTP. To provide HTTPS support for your bucket, [upload your own security certificate](../../storage/operations/hosting/certificate.md) to {{ objstorage-name }}.


        * `max_size`: Maximum bucket size, in bytes. The default value is `0`, unlimited. 
        * `default_storage_class`: [Storage class](../../storage/concepts/storage-class.md). The possible values are:

          * `standard`: Standard storage. This is a default value.
          * `cold`: Cold storage.
          * `ice`: Ice storage.

          <q>Cold</q> classes are designed to store objects that you plan to use less frequently for longer periods of time. The <q>colder</q> your storage is, the less you pay for storing data; however, the costs of reading and writing data increase.

        * `anonymous_access_flags`: [Access](../../storage/concepts/bucket.md#bucket-access) settings:

          * `read`: Public read access to bucket objects.
          * `list`: Public view access to the list of bucket objects.
          * `config_read`: Public read access to bucket settings. Disabled by default.

        * `tags`: Bucket [labels](../../storage/concepts/tags.md) in `key = "value"` format.

      For more information about `yandex_storage_bucket` properties, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/storage_bucket).

  1. Create the resources:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  {{ TF }} will create all the required resources. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API {#api}

  To create a bucket, use the [create](../../storage/api-ref/Bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) gRPC API call, or the [create](../../storage/s3/api-ref/bucket/create.md) S3 API method.

{% endlist %}