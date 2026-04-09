---
subcategory: Identity and Access Management
---

# yandex_iam_workload_identity_oidc_federation (Resource)

A OIDC workload identity federation.

## Example usage

```terraform
//
// Create a new IAM Workload Identity OIDC Federation.
//
resource "yandex_iam_workload_identity_oidc_federation" "wlif" {
  name        = "some_wlif_name"
  folder_id   = "some_folder_id"
  description = "some description"
  disabled    = false
  audiences   = ["aud1", "aud2"]
  issuer      = "https://example-issuer.com"
  jwks_url    = "https://example-issuer.com/jwks"
  labels = {
    key1 = "value1"
    key2 = "value2"
  }
}
```

## Arguments & Attributes Reference

- `audiences` (*Read-Only*) (Set Of String). List of trusted values for aud claim.
- `created_at` (*Read-Only*) (String). Creation timestamp.
- `description` (*Read-Only*) (String). Description of the OIDC workload identity federation.
- `disabled` (Bool). True - the OIDC workload identity federation is disabled and cannot be used for authentication.
 False - the OIDC workload identity federation is enabled and can be used for authentication.
- `enabled` (*Read-Only*) (Bool). Enabled flag.
- `federation_id` (String). Id of the OIDC workload identity federation.
- `folder_id` (*Read-Only*) (String). Id of the folder that the OIDC workload identity federation belongs to.
- `id` (String). 
- `issuer` (*Read-Only*) (String). Issuer identifier of the external IdP server to be used for authentication.
- `jwks_url` (*Read-Only*) (String). URL reference to trusted keys in format of JSON Web Key Set.
- `labels` (*Read-Only*) (Map Of String). Resource labels as key-value pairs.
- `name` (String). Name of the OIDC workload identity federation. The name is unique within the folder.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_iam_workload_identity_oidc_federation.<resource Name> <resource Id>
terraform import yandex_iam_workload_identity_oidc_federation.wlif ...
```
