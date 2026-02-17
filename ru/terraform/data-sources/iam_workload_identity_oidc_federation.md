---
subcategory: Identity and Access Management
---

# yandex_iam_workload_identity_oidc_federation (DataSource)

Get information about a [Yandex Cloud IAM workload identity OIDC federation](https://yandex.cloud/docs/iam/concepts/workload-identity).

## Example usage

```terraform
//
// Get information about existing IAM Workload Identity OIDC Federation.
//
data "yandex_iam_workload_identity_oidc_federation" "wlif" {
  federation_id = "some_federation_id"
}

data "yandex_iam_workload_identity_oidc_federation" "wlif" {
  name = "some_federation_name"
}
```

## Arguments & Attributes Reference

- `audiences` (*Read-Only*) (Set Of String). List of trusted values for aud claim.
- `created_at` (*Read-Only*) (String). Creation timestamp.
- `description` (*Read-Only*) (String). Description of the OIDC workload identity federation.
- `enabled` (*Read-Only*) (Bool). Enabled flag.
- `federation_id` (String). Id of the OIDC workload identity federation.
- `folder_id` (*Read-Only*) (String). Id of the folder that the OIDC workload identity federation belongs to.
- `id` (String). 
- `issuer` (*Read-Only*) (String). Issuer identifier of the external IdP server to be used for authentication.
- `jwks_url` (*Read-Only*) (String). URL reference to trusted keys in format of JSON Web Key Set.
- `labels` (*Read-Only*) (Map Of String). Resource labels as key-value pairs.
- `name` (String). Name of the OIDC workload identity federation. The name is unique within the folder.


