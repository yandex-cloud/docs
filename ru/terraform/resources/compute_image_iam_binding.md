---
subcategory: Compute Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/compute_image_iam_binding.md
---

# yandex_compute_image_iam_binding (Resource)

Allows creation and management of a single binding within IAM policy for an existing `image`.

## Example usage

```terraform
//
// Create a new Compute Image and new IAM Binding for it.
//
resource "yandex_compute_image" "image1" {
  name       = "my-custom-image"
  source_url = "https://storage.yandexcloud.net/lucky-images/kube-it.img"
}

resource "yandex_compute_image_iam_binding" "editor" {
  image_id = data.yandex_compute_image.image1.id

  role = "editor"

  members = [
    "userAccount:some_user_id",
  ]
}
```

## Arguments & Attributes Reference

- `id` (String). The ID of this resource.
- `image_id` (**Required**)(String). The ID of the compute `image` to attach the policy to.
- `members` (**Required**)(Set Of String). An array of identities that will be granted the privilege in the `role`. Each entry can have one of the following values: * **userAccount:{user_id}**: A unique user ID that represents a specific Yandex account. * **serviceAccount:{service_account_id}**: A unique service account ID. * **federatedUser:{federated_user_id}**: A unique federated user ID. * **federatedUser:{federated_user_id}:**: A unique SAML federation user account ID. * **group:{group_id}**: A unique group ID. * **system:group:federation:{federation_id}:users**: All users in federation. * **system:group:organization:{organization_id}:users**: All users in organization. * **system:allAuthenticatedUsers**: All authenticated users. * **system:allUsers**: All users, including unauthenticated ones.

    {% note warning %}

    for more information about system groups, see [Cloud Documentation](https://yandex.cloud/docs/iam/concepts/access-control/system-group).

    {% endnote %}
- `role` (**Required**)(String). The role that should be assigned. Only one yandex_compute_image_iam_binding can be used per role.
- `sleep_after` (Number). For test purposes, to compensate IAM operations delay


