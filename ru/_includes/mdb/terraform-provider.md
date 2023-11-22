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
  token     = "<OAuth_или_статический_ключ_сервисного_аккаунта>"
  cloud_id  = "{{ tf-cloud-id }}"
  folder_id = "{{ tf-folder-id }}"
}
```




Для получения [токена OAuth](../../iam/concepts/authorization/oauth-token.md) или [статического ключа доступа](../../iam/operations/sa/create-access-key.md) см. инструкции {{ iam-full-name }}.

