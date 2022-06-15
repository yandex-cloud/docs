`provider.tf`

{% if product == "yandex-cloud" %}

```hcl
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = "<OAuth или статический ключ сервисного аккаунта>"
  cloud_id  = "{{ tf-cloud-id }}"
  folder_id = "{{ tf-folder-id }}"
}
```

{% endif %}

{% if product == "cloud-il" %}

```hcl
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  endpoint  = "{{ api-host }}:443"
  token     = "<статический ключ сервисного аккаунта>"
  cloud_id  = "{{ tf-cloud-id }}"
  folder_id = "{{ tf-folder-id }}"
}
```

{% endif %}

{% if audience != "internal" %}

Для получения {% if product == "yandex-cloud" %}[токена OAuth](../../iam/concepts/authorization/oauth-token.md) или {% endif %}[статического ключа доступа](../../iam/operations/sa/create-access-key.md) см. инструкции {{ iam-full-name }}.

{% endif %}
