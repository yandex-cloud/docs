[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Service for YDB > Resources > ydb_database_iam_member

# yandex_ydb_database_iam_member (Resource)

Allows creation and management of a single binding within IAM policy for an existing `database`.

## Example usage

```terraform
//
// Create a new YDB Serverless Database and grant one IAM member access to it.
//
resource "yandex_ydb_database_serverless" "database1" {
  name      = "test-ydb-serverless"
  folder_id = data.yandex_resourcemanager_folder.test_folder.id
}

resource "yandex_ydb_database_iam_member" "viewer" {
  database_id = yandex_ydb_database_serverless.database1.id
  role        = "ydb.viewer"
  member      = "userAccount:foo_user_id"
}
```

## Arguments & Attributes Reference

- `database_id` (**Required**)(String). The ID of the `database` to attach the policy to.
- `id` (String). The ID of this resource.
- `member` (**Required**)(String). An identity that will be granted the privilege in the `role`. It can have one of the following values:
 * **userAccount:{user_id}**: A unique user ID that represents a specific Yandex account.
 * **serviceAccount:{service_account_id}**: A unique service account ID.
 * **federatedUser:{federated_user_id}**: A unique federated user ID.
 * **group:{group_id}**: A unique group ID.
 * **system:group:federation:{federation_id}:users**: All users in federation.
 * **system:group:organization:{organization_id}:users**: All users in organization.
 * **system:allAuthenticatedUsers**: All authenticated users.
 * **system:allUsers**: All users, including unauthenticated ones.

{% note warning %}

for more information about system groups, see [Cloud Documentation](../../iam/concepts/access-control/system-group.md).

{% endnote %}



- `role` (**Required**)(String). The role that should be assigned to the member.
- `sleep_after` (Number). For test purposes, to compensate IAM operations delay

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](../../cli/quickstart.md).

```shell
# terraform import yandex_ydb_database_iam_member.<resource Name> "<database Id>,<role>,<member>"
terraform import yandex_ydb_database_iam_member.viewer "etn***************,ydb.viewer,userAccount:aje***************"
```