---
subcategory: Container Registry
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/container_repository_iam_binding.md
---

# yandex_container_repository_iam_binding (Resource)

Allows creation and management of a single binding within IAM policy for an existing `repository`.

## Example usage

```terraform
//
// Create a new Container Repository and new IAM Binding for it.
//
resource "yandex_container_registry" "your-registry" {
  folder_id = "your-folder-id"
  name      = "registry-name"
}

resource "yandex_container_repository" "repo-1" {
  name = "${yandex_container_registry.your-registry.id}/repo-1"
}

resource "yandex_container_repository_iam_binding" "puller" {
  repository_id = yandex_container_repository.repo-1.id
  role          = "container-registry.images.puller"

  members = [
    "system:allUsers",
  ]
}
```
```terraform
//
// Get information about existing Container Repository 
// and create new IAM Binding for it.
//
data "yandex_container_repository" "repo-2" {
  name = "some_repository_name"
}

resource "yandex_container_repository_iam_binding" "pusher" {
  repository_id = yandex_container_repository.repo-2.id
  role          = "container-registry.images.pusher"

  members = [
    "serviceAccount:your-service-account-id",
  ]
}
```

## Arguments & Attributes Reference

- `id` (String). The ID of this resource.
- `members` (**Required**)(Set Of String). An array of identities that will be granted the privilege in the `role`. Each entry can have one of the following values: * **userAccount:{user_id}**: A unique user ID that represents a specific Yandex account. * **serviceAccount:{service_account_id}**: A unique service account ID. * **federatedUser:{federated_user_id}**: A unique federated user ID. * **federatedUser:{federated_user_id}:**: A unique SAML federation user account ID. * **group:{group_id}**: A unique group ID. * **system:group:federation:{federation_id}:users**: All users in federation. * **system:group:organization:{organization_id}:users**: All users in organization. * **system:allAuthenticatedUsers**: All authenticated users. * **system:allUsers**: All users, including unauthenticated ones.

    {% note warning %}

    for more information about system groups, see [Cloud Documentation](https://yandex.cloud/docs/iam/concepts/access-control/system-group).

    {% endnote %}
- `repository_id` (**Required**)(String). The ID of the compute `repository` to attach the policy to.
- `role` (**Required**)(String). The role that should be assigned. Only one yandex_container_repository_iam_binding can be used per role.
- `sleep_after` (Number). For test purposes, to compensate IAM operations delay

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_container_repository_iam_binding.<binding Name> "<repository_id>,<resource Role>"
terraform import yandex_container_repository_iam_binding.puller "crps9**********k9psn,container-registry.images.puller"
```
