

To create a [bucket](../../storage/concepts/bucket.md), you need the _minimum_ `storage.editor` [role](../../storage/security/#storage-editor) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a bucket in.
  1. Select **{{ objstorage-name }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
  1. On the bucket creation page:
      1. Enter a name for the bucket according to the [naming requirements](../../storage/concepts/bucket.md#naming).


          By default, a bucket with a dot in the name is only available over HTTP. To provide HTTPS support for your bucket, [upload your own security certificate](../../storage/operations/hosting/certificate.md) to {{ objstorage-name }}.


      1. Limit the maximum bucket size, if required.

          {% include [storage-no-max-limit](../../storage/_includes_service/storage-no-max-limit.md) %}

      1. Set the public [public access](../../storage/security/public-access.md) parameters to read [objects](../../storage/concepts/object.md) in the bucket, get a list of objects, and read bucket settings:
          * `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`: Authorized {{ yandex-cloud }} users only
          * `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`: All users

          {% include [public-access-warning](./security/public-access-warning.md) %}

      1. Select the default [storage class](../../storage/concepts/storage-class.md):
          * `{{ ui-key.yacloud.storage.bucket.settings.class_value_standard }}`.
          * `{{ ui-key.yacloud.storage.bucket.settings.class_value_cold }}`.
          * `{{ ui-key.yacloud.storage.bucket.settings.class_value_ice }}`.

          "Cold" classes are designed to store objects that you plan to use less frequently for longer periods of time. The "colder" your storage is, the less you pay for storing data; however, the costs of reading and writing data increase.

      1. Add [labels](../../storage/concepts/tags.md), if required:
          1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          1. Enter a label in `key: value` format.
          1. Click **Enter**.

      1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}** to complete the operation.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. View a description of the CLI command to create a bucket:

      ```bash
      yc storage bucket create --help
      ```

  1. Create a bucket in the default folder:

      ```bash
      yc storage bucket create --name <bucket_name>
      ```

      Where `--name` is the name of the bucket. This is a required parameter. For more information, see [Bucket naming rules](../../storage/concepts/bucket.md#naming).


      By default, a bucket with a dot in the name is only available over HTTP. To provide HTTPS support for your bucket, [upload](../../storage/operations/hosting/certificate.md) your own security certificate to {{ objstorage-name }}.


      Result:

      ```text
      name: example
      folder_id: b1gmit33ngp6********
      anonymous_access_flags:
        read: false
        list: false
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "53687091200"
      acl: {}
      created_at: "2022-12-16T14:05:12.196007Z"
      ```

      {% cut "Optional parameters" %}

      * `--default-storage-class`: [Storage class](../../storage/concepts/storage-class.md). Possible values:
        * `standard`: Standard storage. It is installed by default.
        * `cold`: Cold storage.
        * `ice`: Ice storage.

        "Cold" classes are designed to store [objects](../../storage/concepts/object.md) that you plan to use less frequently for longer periods of time. The "colder" your storage is, the less you pay for storing data; however, the costs of reading and writing data increase.

      * `--max-size`: Maximum bucket size, in bytes. Default value: `0` (unlimited).
      * Parameters for enabling [public access](../../storage/security/public-access.md) to a bucket:
        * `--public-read`: Enables public access to reading bucket objects.
        * `--public-list`: Enables public access to viewing the list of bucket objects.
        * `--public-config-read`: Enables public access to reading bucket settings.

        By default, no public access to buckets is allowed.

        {% include [public-access-warning](./security/public-access-warning.md) %}

      * Parameters to configure the bucket [ACL](../../storage/concepts/acl.md):
        * `--acl`: Predefined ACL. For a list of possible values, see [Predefined ACLs](../../storage/concepts/acl.md#predefined-acls). You cannot use this parameter together with the `--grants` parameter.
        * `--grants`: Configures permissions for individual users, [service accounts](../../iam/concepts/users/service-accounts.md), [user groups](../../organization/concepts/groups.md), and [public groups](../../storage/concepts/acl.md#public-groups) (a group of all internet users or a group of all authenticated {{ yandex-cloud }} users). You cannot use this parameter together with the `--acl` parameter. The parameter value is specified in the following format: `grant-type=<permission_grantee_type>,grantee-id=<grantee_ID>,permission=<permission_type>`, where:
          * `grant-type`: Permission grantee type. The possible values are:
            * `grant-type-account`: User, [service account](../../iam/concepts/users/service-accounts.md), or [user group](../../organization/concepts/groups.md).
            * `grant-type-all-authenticated-users`: [Public group](../../storage/concepts/acl.md#public-groups) that includes all authenticated {{ yandex-cloud }} users.
            * `grant-type-all-users`: Public group that includes all internet users.
          * `grantee-id`: ID of the user, service account, or user group you need to grant a permission to. Specified only if `grant-type=grant-type-account`.
          * `permission`: ACL permission type. Possible values: `permission-full-control`, `permission-write`, `permission-read`. For more information about permissions, see [Permission types](../../storage/concepts/acl.md#permissions-types).

          To configure multiple permissions, specify the `--grants` parameter multiple times.

        By default, an empty ACL is created for each new bucket.

      {% endcut %}

      For more information about the `yc storage bucket create` command, see the [YC CLI reference](../../cli/cli-ref/managed-services/storage/bucket/create.md).

- AWS CLI {#aws-cli}

  If you do not have the AWS CLI yet, [install and configure it](../../storage/tools/aws-cli.md).

  To create a bucket, [assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.editor` [role](../../storage/security/#storage-editor) to the service account used by the AWS CLI.

  In the terminal, run this command:

  ```bash
  aws s3api create-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <bucket_name>
  ```

  Where:

  * `--endpoint-url`: {{ objstorage-name }} endpoint
  * `--bucket`: Bucket name


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
  * No limitations to the maximum size.
  * Limited [access](../../storage/concepts/bucket.md#bucket-access) to read objects, get a list of objects, and read bucket setting.
  * [Storage class](../../storage/concepts/storage-class.md): `Standard`.

  {% cut "Optional parameters" %}

  You can apply a [predefined ACL](../../storage/concepts/acl.md#predefined-acls) to a bucket or configure permissions for individual users, [service accounts](../../iam/concepts/users/service-accounts.md), [user groups](../../organization/concepts/groups.md) and [public groups](../../storage/concepts/acl.md#public-groups) (e.g., a group of all internet users or a group of all authenticated {{ yandex-cloud }} users). These settings are not compatible: a bucket should have either a predefined ACL or a set of individual permissions.

  {% note info %}

  To manage bucket [ACL](../../storage/concepts/acl.md) settings, [assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.admin` [role[ to the service account used by the AWS CLI.

  {% endnote %}

  **Predefined ACL**

  ```bash
  aws s3api create-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <bucket_name> \
    --acl <predefined_ACL>
  ```

  Where `--acl` is a predefined ACL. For the list of values, see [{#T}](../../storage/concepts/acl.md#predefined-acls).

  **Individual permissions**

  ```bash
  aws s3api create-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <bucket_name> \
    <permission_type> <permission_grantee>
  ```

  Where:
  * Possible types of ACL permissions:
    * `--grant-read`: Permission to access the list of objects in the bucket, read various bucket settings (lifecycle, CORS, or static hosting), and read all objects in the bucket.
    * `--grant-write`: Permission to write, overwrite, and delete objects in the bucket. Can only be used together with `--grant-read`.
    * `--grant-full-control`: Full access to the bucket and the objects in it.

    You can set multiple permissions within the same command.
  * The possible permission grantees are:
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


  1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      terraform {
        required_providers {
          yandex = {
            source = "yandex-cloud/yandex"
          }
        }
        required_version = ">= 0.13"
      }

      // Configuring a provider
      provider "yandex" {
        token     = "<IAM_or_OAuth_token>"
        cloud_id  = "<cloud_ID>"
        folder_id = "<folder_ID>"
        zone      = "{{ region-id }}-a"
      }

      // Creating a service account
      resource "yandex_iam_service_account" "sa" {
        name = "<service_account_name>"
      }

      // Assigning a role to a service account
      resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
        folder_id = "<folder_ID>"
        role      = "storage.admin"
        member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
      }

      // Creating a static access key
      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
        service_account_id = yandex_iam_service_account.sa.id
        description        = "static access key for object storage"
      }

      // Creating a bucket using a key
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

      Where:
      * `yandex_iam_service_account`: Description of the [service account](../../iam/concepts/users/service-accounts.md) to create and use the [bucket](../../storage/concepts/bucket.md):

        * `name`: Service account name
        * `bucket`: Bucket name


          By default, a bucket with a dot in the name is only available over HTTP. To provide HTTPS support for your bucket, [upload your own security certificate](../../storage/operations/hosting/certificate.md) to {{ objstorage-name }}.


        * `max_size`: Maximum bucket size, in bytes.
        * `default_storage_class`: [Storage class](../../storage/concepts/storage-class.md). Possible values:

          * `standard`: Standard storage.
          * `cold`: Cold storage.
          * `ice`: Ice storage.

          "Cold" classes are designed to store objects that you plan to use less frequently for longer periods of time. The "colder" your storage is, the less you pay for storing data; however, the costs of reading and writing data increase.

        * `anonymous_access_flags`: [Access](../../storage/concepts/bucket.md#bucket-access) settings:

          * `read`: Public access to read bucket objects.
          * `list`: Public access to view the list of bucket objects.
          * `config_read`: Public access to read bucket settings.

        * `tags`: Bucket [labels](../../storage/concepts/tags.md) in `key = "value"` format.

      `name`: Required parameter. Other parameters are optional. By default, the `max-size` value is `0`, public access to the bucket is disabled, and the storage class is set to `standard`.

      For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/storage_bucket).

  1. Create resources:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  {{ TF }} will create all the required resources. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API {#api}

  To create a bucket, use the [create](../../storage/api-ref/Bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) gRPC API call, or the [create](../../storage/s3/api-ref/bucket/create.md) S3 API method.

{% endlist %}