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
  token     = "<OAuth or static key of service account>"
  cloud_id  = "{{ tf-cloud-id }}"
  folder_id = "{{ tf-folder-id }}"
}
```




To get an [OAuth token](../../iam/concepts/authorization/oauth-token.md) or a [static access key](../../iam/operations/sa/create-access-key.md), see the {{ iam-full-name }} instructions.

