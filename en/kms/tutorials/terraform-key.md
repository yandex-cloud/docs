# Managing {{ kms-short-name }} keys with {{ TF-full }}

The [{{ TF }} provider]({{ tf-provider-link }}/) for {{ yandex-cloud }} supports the use of {{ kms-short-name }} keys.

## Adding keys {#add}

{% include [terraform-key-create](../../_includes/kms/terraform-key-create.md) %}

## Managing key access {#security}

To manage access to keys in {{ TF }}, assign the necessary roles for the folder that contains the key.

For example, [assign](../../iam/operations/sa/assign-role-for-sa.md) the `kms.keys.encrypterDecrypter` role for the service account, which grants the permission to encrypt and decrypt data with keys from a specific folder:

```hcl
resource "yandex_resourcemanager_folder_iam_member" "admin" {
  folder_id = "<ID of the folder>"
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:<service account ID>"
}
```

## See also {#see-also}

* [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [{#T}](../security/index.md).
* [The {{ yandex-cloud }} provider documentation]({{ tf-provider-link }}/).
* [Encrypting data using the {{ yandex-cloud }} CLI and API](../../kms/operations/key.md)
