---
subcategory: Cloud DNS
---

# yandex_dns_firewall_iam_binding (Resource)

Manages the members of a single IAM role on an existing `dns_firewall`.

On creation, the specified members are added to the role without removing existing members. On update, the resource replaces the members of the previously managed role with the configured bindings. On deletion, it removes the managed role from all of its members, including those not listed in this resource. Other roles on the target resource are preserved.

{% note warning %}

**Warning:** Updating or deleting `yandex_dns_firewall_iam_binding` can revoke access granted outside this resource, including access granted through `*_iam_member`, the management console, CLI or API. Those subjects are not tracked in this resource's Terraform state and are not shown in its normal plan diff. The provider attempts to list affected subjects in a separate warning during planning when it can read the current access bindings. An absent warning does not guarantee that no other subjects will lose access.

{% endnote %}


{% note warning %}

Only one `yandex_dns_firewall_iam_binding` resource may manage a given role on a given `dns_firewall`. Do not use `*_iam_binding` and `*_iam_member` for the same role on the same target resource: they will conflict over the role's members. They can be used together for different roles. Use `*_iam_member` to manage an individual member while preserving other members of the role.

{% endnote %}


## Example usage

```terraform
//
// Create a new DNS Firewall and new IAM Binding for it.
//
resource "yandex_dns_firewall" "fw1" {
  name = "my-firewall"
}

resource "yandex_dns_firewall_iam_binding" "fw-editor" {
  dns_firewall_id = yandex_dns_firewall.fw1.id
  role        = "dns.firewallEditor"
  members     = ["userAccount:foo_user_id"]
}
```

## Arguments & Attributes Reference

- `dns_firewall_id` (**Required**)(String). The ID of the `dns_firewall` to attach the policy to.
- `id` (String). The ID of this resource.
- `members` (**Required**)(Set Of String). An array of identities that will be granted the privilege in the `role`. Each entry can have one of the following values:
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



- `role` (**Required**)(String). The role that should be assigned. Only one yandex_dns_firewall_iam_binding can be used per role.
- `sleep_after` (Number). For test purposes, to compensate IAM operations delay

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_dns_firewall_iam_binding.<resource Name> "dns_firewall_id,dns.viewer"
terraform import yandex_dns_firewall_iam_binding.viewer "dns7f**********dkhh6,dns.viewer"
```
