---
subcategory: Managed Services for Kubernetes
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/kubernetes_cluster_iam_member.md
---

# yandex_kubernetes_cluster_iam_member (Resource)

Allows creation and management of a single binding within IAM policy for an existing `cluster`.

## Example usage

```terraform
//
// Create a new Managed Kubernetes cluster and a new IAM Member for it.
//
data "yandex_kubernetes_cluster" "my_cluster" {
  name = "My Managed Kubernetes cluster"
}

resource "yandex_kubernetes_cluster_iam_member" "viewer" {
  cluster_id = yandex_kubernetes_cluster.my_cluster.id
  role = "viewer"
  member = "userAccount:my_user_account_id"
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of the compute `cluster` to attach the policy to.
- `id` (String). The ID of this resource.
- `member` (**Required**)(String). An array of identities that will be granted the privilege in the `role`. Each entry can have one of the following values:
 * **userAccount:{user_id}**: A unique user ID that represents a specific Yandex account.
 * **serviceAccount:{service_account_id}**: A unique service account ID.
 * **federatedUser:{federated_user_id}**: A unique federated user ID.
 * **federatedUser:{federated_user_id}:**: A unique SAML federation user account ID.
 * **group:{group_id}**: A unique group ID.
 * **system:group:federation:{federation_id}:users**: All users in federation.
 * **system:group:organization:{organization_id}:users**: All users in organization.
 * **system:allAuthenticatedUsers**: All authenticated users.
 * **system:allUsers**: All users, including unauthenticated ones.

{% note warning %}

for more information about system groups, see [Cloud Documentation](https://yandex.cloud/docs/iam/concepts/access-control/system-group).

{% endnote %}



- `role` (**Required**)(String). The role that should be assigned. Only one yandex_kubernetes_cluster_iam_member can be used per role.
- `sleep_after` (Number). For test purposes, to compensate IAM operations delay

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_kubernetes_cluster_iam_member.<Resource Name> "<Cluster ID>,<Role>,<Subject>"
terraform import yandex_kubernetes_cluster_iam_member.viewer "cat7d**********46ehc,viewer,aje2z**********ddmec"
```
