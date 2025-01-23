# Managing {{ kms-full-name }} keys with {{ TF-full }}

The [{{ TF }} provider]({{ tf-provider-link }}/) for {{ yandex-cloud }} supports the use of {{ kms-full-name }} keys.

## Adding keys {#add}

{% include [terraform-key-create](../../_includes/kms/terraform-key-create.md) %}

## Managing key access {#security}

To manage access to keys in {{ TF }}, assign the necessary roles for the folder that contains the key. 

For example, [assign](../../iam/operations/sa/assign-role-for-sa.md) the `kms.keys.encrypterDecrypter` role to the service account permitting it to encrypt and decrypt data with keys from a specific folder:

```hcl
resource "yandex_resourcemanager_folder_iam_member" "admin" {
  folder_id = "<folder_ID>"
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:<service_account_ID>"
}
```

## See also {#see-also}

* [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [{#T}](../../kms/security/index.md).
* [{{ yandex-cloud }} provider documentation]({{ tf-provider-link }}/).
* [Encrypting data using the {{ yandex-cloud }}](../../kms/operations/key.md) CLI and API.
