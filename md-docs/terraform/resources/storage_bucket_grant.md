[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Object Storage > Resources > storage_bucket_grant

# yandex_storage_bucket_grant (Resource)

Allows management of grants on an existing [Yandex Cloud Storage Bucket](../../storage/concepts/bucket.md).

{% note warning %}

By default, for authentication, you need to use [IAM token](../../iam/concepts/authorization/iam-token.md) with the necessary permissions.

{% endnote %}


{% note warning %}

Alternatively, you can provide [static access keys](../../iam/concepts/authorization/access-key.md) (Access and Secret). To generate these keys, you will need a Service Account with the appropriate permissions.

{% endnote %}


This resource should be used for managing [Primitive roles](../../storage/security/index.md#primitive-roles) only.

Declaring multiple yandex_storage_bucket_grant resources to the same bucket will cause a perpetual difference in configuration.

## Example usage

```terraform
provider "yandex" {
  cloud_id           = "<my_cloud_id>"
  folder_id          = "<my_folder_id>"
  storage_access_key = "<my_storage_access_key>"
  storage_secret_key = "<my_storage_secret_key>"
  token              = "<my_iam_token>"
}

resource "yandex_storage_bucket_grant" "my_grant_0" {
  bucket = "my_bucket_name_0"
  grant {
    id          = "<user_id>"
    permissions = ["READ", "WRITE", "FULL_CONTROL"]
    type        = "CanonicalUser"
  }
}

resource "yandex_storage_bucket_grant" "my_grant_1" {
  bucket = "my_bucket_name_1"
  grant {
    id          = "<user_id>"
    permissions = ["FULL_CONTROL"]
    type        = "CanonicalUser"
  }
  grant {
    uri         = "<group_uri>"
    permissions = ["READ"]
    type        = "Group"
  }
}
```
```terraform
//
// Create new grants on an existing Storage Bucket.
//
resource "yandex_storage_bucket_grant" "my_bucket_grant" {
  bucket = "my_bucket_name_0"
  grant {
    id          = "<user0_id>"
    permissions = ["READ", "WRITE"]
    type        = "CanonicalUser"
  }
  grant {
    id          = "<user1_id>"
    permissions = ["FULL_CONTROL"]
    type        = "CanonicalUser"
  }
  grant {
    uri         = "http://acs.amazonaws.com/groups/global/AuthenticatedUsers"
    permissions = ["READ"]
    type        = "Group"
  }
}
```

## Arguments & Attributes Reference

- `access_key` (String). The access key to use when applying changes. This value can also be provided as `storage_access_key` specified in provider config (explicitly or within `shared_credentials_file`) is used.
- `acl` (String). The [predefined ACL](../../storage/concepts/acl.md#predefined_acls) to apply. Defaults to `private`. Conflicts with `grant`.

{% note warning %}

To change ACL after creation, service account with `storage.admin` role should be used, though this role is not necessary to create a bucket with any ACL.

{% endnote %}


- `bucket` (**Required**)(String). The name of the bucket.
- `secret_key` (String). The secret key to use when applying changes. This value can also be provided as `storage_secret_key` specified in provider config (explicitly or within `shared_credentials_file`) is used.
- `grant` [Block]. An [ACL policy grant](../../storage/concepts/acl.md#permissions-types). Conflicts with `acl`.
All permissions for a single grantee must be specified in a single `grant` block.

{% note warning %}

To manage `grant` argument, service account with `storage.admin` role should be used.

{% endnote %}


  - `id` (String). Canonical user id to grant for. Used only when type is `CanonicalUser`.
  - `permissions` (**Required**)(Set Of String). List of permissions to apply for grantee. Valid values are `READ`, `WRITE`, `FULL_CONTROL`.
  - `type` (**Required**)(String). Type of grantee to apply for. Valid values are `CanonicalUser` and `Group`.
  - `uri` (String). URI address to grant for. Used only when type is Group.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](../../cli/quickstart.md).

```shell
# The resource can be imported by using their resource ID.
# For getting a resource ID you can use Yandex Cloud Web UI or YC CLI.

# terraform import yandex_storage_bucket_grant.<resource_name> resource_id
terraform import yandex_storage_bucket_grant.<resource_name> ...
```