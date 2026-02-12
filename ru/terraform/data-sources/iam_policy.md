---
subcategory: Identity and Access Management
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/iam_policy.md
---

# yandex_iam_policy (DataSource)

Generates an [IAM](https://yandex.cloud/docs/iam/) policy document that may be referenced by and applied to other Yandex Cloud Platform resources, such as the `yandex_resourcemanager_folder` resource.

This data source is used to define [IAM](https://yandex.cloud/docs/iam/) policies to apply to other resources. Currently, defining a policy through a data source and referencing that policy from another resource is the only way to apply an IAM policy to a resource.

## Example usage

```terraform
//
// Get information about existing IAM Policy.
//
data "yandex_iam_policy" "admin" {
  binding {
    role = "admin"

    members = [
      "userAccount:user_id_1"
    ]
  }

  binding {
    role = "viewer"

    members = [
      "userAccount:user_id_2"
    ]
  }
}
```

## Arguments & Attributes Reference

- `id` (String). 
- `policy_data` (*Read-Only*) (String). The above bindings serialized in a format suitable for referencing from a resource that supports IAM.
- `binding` [Block]. Defines a binding to be included in the policy document. Multiple `binding` arguments are supported.
  - `members` (**Required**)(Set Of String). An array of identities that will be granted the privilege in the `role`. Each entry can have one of the following values:
* **userAccount:{user_id}**: A unique user ID that represents a specific Yandex account.
* **serviceAccount:{service_account_id}**: A unique service account ID.
* **federatedUser:{federated_user_id}:**: A unique saml federation user account ID.
* **group:{group_id}**: A unique group ID.
* **system:group:federation:{federation_id}:users**: All users in federation.
* **system:group:organization:{organization_id}:users**: All users in organization.
* **system:allAuthenticatedUsers**: All authenticated users.
* **system:allUsers**: All users, including unauthenticated ones.

{% note warning %}

For more information about system groups, see the [documentation](https://yandex.cloud/docs/iam/concepts/access-control/system-group).

{% endnote %}


  - `role` (**Required**)(String). The role/permission that will be granted to the members. See the [IAM Roles](https://yandex.cloud/docs/iam/concepts/access-control/roles) documentation for a complete list of roles.


