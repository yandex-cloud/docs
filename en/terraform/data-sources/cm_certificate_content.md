---
subcategory: Certificate Manager
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/cm_certificate_content.md
---

# yandex_cm_certificate_content (DataSource)

Get content (certificate, private key) from a Yandex Certificate Manager Certificate. For more information, see [the official documentation](https://yandex.cloud/docs/certificate-manager/concepts/).

{% note warning %}

One of `certificate_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
// 
// Get CM Certificate payload. Can be used for Certificate Validation.
//
data "yandex_cm_certificate_content" "example_by_id" {
  certificate_id = "certificate-id"
}

data "yandex_cm_certificate_content" "example_by_name" {
  folder_id = "folder-id"
  name      = "example"
}
```

## Arguments & Attributes Reference

- `certificate_id` (String). Certificate Id.
- `certificates` (*Read-Only*) (List Of String). List of certificates in chain.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `name` (String). Certificate name.
- `private_key` (*Read-Only*) (String). Private key in specified format.
- `private_key_format` (String). Format in which you want to export the private_key: `"PKCS1"` or `"PKCS8"`.
- `wait_validation` (Bool). If `true`, the operation won't be completed while the certificate is in `VALIDATING`. Default is `false`.


