`provider.tf`

```hcl
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = "<OAuth_or_static_key_of_service_account>"
  cloud_id  = "{{ tf-cloud-id }}"
  folder_id = "{{ tf-folder-id }}"
}
```


To get an [OAuth token](../../iam/concepts/authorization/oauth-token.md) or a [static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key), see the {{ iam-full-name }} instructions.

