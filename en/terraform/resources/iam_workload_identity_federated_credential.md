---
subcategory: Identity and Access Management
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/iam_workload_identity_federated_credential.md
---

# yandex_iam_workload_identity_federated_credential (Resource)

A federated credential.

## Example usage

```terraform
//
// Create a new IAM Workload Identity Federated Credential.
//
resource "yandex_iam_workload_identity_federated_credential" "fed_cred" {
  service_account_id  = "some_sa_id"
  federation_id       = "some_wli_federation_id"
  external_subject_id = "some_external_subject_id"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Creation timestamp.
- `external_subject_id` (**Required**)(String). Id of the external subject.
- `federated_credential_id` (String). ID of the federated credential to return. To get the federated credential ID, make a [FederatedCredentialService.List] request.
- `federation_id` (**Required**)(String). ID of the workload identity federation which is used for authentication.
- `id` (String). ID of the federated credential to return. To get the federated credential ID, make a [FederatedCredentialService.List] request.
- `service_account_id` (String). Id of the service account that the federated credential belongs to.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_iam_workload_identity_federated_credential.<resource Name> <resource Id>
terraform import yandex_iam_workload_identity_federated_credential.fed_cred ...
```
