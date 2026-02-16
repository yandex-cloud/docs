---
subcategory: Identity and Access Management
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/iam_workload_identity_federated_credential.md
---

# yandex_iam_workload_identity_federated_credential (DataSource)

A federated credential.

## Example usage

```terraform
//
// Get information about existing IAM Workload Identity Federated Credential.
//
data "yandex_iam_workload_identity_federated_credential" "fed_cred" {
  federated_credential_id = "some_fed_cred_id"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Creation timestamp.
- `external_subject_id` (**Required**)(String). Id of the external subject.
- `federated_credential_id` (String). ID of the federated credential to return.
 To get the federated credential ID, make a [FederatedCredentialService.List] request.
- `federation_id` (**Required**)(String). ID of the workload identity federation which is used for authentication.
- `id` (String). ID of the federated credential to return.
 To get the federated credential ID, make a [FederatedCredentialService.List] request.
- `service_account_id` (String). Id of the service account that the federated credential belongs to.


