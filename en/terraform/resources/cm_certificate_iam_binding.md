---
subcategory: Certificate Manager
---

# yandex_cm_certificate_iam_binding (Resource)

Allows creation and management of a single binding within IAM policy for an existing `certificate`.

## Example usage

```terraform
//
// Create a new CM Certificate IAM Binding.
//
resource "yandex_cm_certificate" "your-certificate" {
  name    = "certificate-name"
  domains = ["example.com"]
  managed {
    challenge_type = "DNS_CNAME"
  }
}

resource "yandex_cm_certificate_iam_binding" "viewer_binding" {
  certificate_id = yandex_cm_certificate.your-certificate.id
  role           = "viewer"

  members = [
    "userAccount:foo_user_id",
  ]
}
```

## Arguments & Attributes Reference

- `certificate_id` (**Required**)(String). The ID of the compute `certificate` to attach the policy to.
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



- `role` (**Required**)(String). The role that should be assigned. Only one yandex_cm_certificate_iam_binding can be used per role.
- `sleep_after` (Number). For test purposes, to compensate IAM operations delay

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_cm_certificate_iam_binding.<resource Name> "<resource Id>,<role Id>"
terraform import yandex_cm_certificate_iam_binding.viewer_binding "...,viewer"
```
