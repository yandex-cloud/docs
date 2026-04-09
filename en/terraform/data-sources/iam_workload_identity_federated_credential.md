---
subcategory: Identity and Access Management
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
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


