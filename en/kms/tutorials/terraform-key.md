# Managing {{ kms-short-name }} keys with Hashicorp {{ TF-full }}

[The {{ TF }} provider for {{ yandex-cloud }}]({{ tf-provider-link }}) supports the use of {{ kms-short-name }} keys.

## Adding keys {#add}

You can add a {{ kms-short-name }} key using the [yandex_kms_symmetric_key]({{ tf-provider-link }}/kms_secret_ciphertext) block:

```
resource "yandex_kms_symmetric_key" "kms-key" {
  lifecycle {
    prevent_destroy = true
  }

  name              = "example-symetric-key"
  description       = "description for key"
  default_algorithm = "AES_256"
  rotation_period   = "8760h" // equal to 1 year
}
```

{% note warning %}

Deleting a {{ kms-short-name }} key destroys all data encrypted with that key: the data becomes unrecoverable after the key is deleted. The `lifecycle` block is necessary to prevent users from destroying keys (with the `terraform destroy` command, for example).

{% endnote %}

## Managing key access {#security}

To manage access to keys in {{ TF }}, assign the necessary roles for the folder that contains the key.

For example, assign a role for the service account, which grants the permission to encrypt and decrypt data with keys from a specific folder:

```
resource "yandex_resourcemanager_folder_iam_member" "admin" {
  folder_id = "<folder ID>"

  role   = "kms.keys.encrypterDecrypter"
  member = "serviceAccount:<service account ID>"
}
```

## See also {#see-also}

* [Getting started with {{ TF }} in {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [{#T}](../security/index.md).
* [{{ yandex-cloud }} provider documentation]({{ tf-provider-link }}).

