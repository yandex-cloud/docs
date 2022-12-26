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
  token     = "<OAuth or static key of service account>"
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
  token     = "<static key of the service account>"
  cloud_id  = "{{ tf-cloud-id }}"
  folder_id = "{{ tf-folder-id }}"
}
```

{% endif %}

{% if audience != "internal" %}

To get {% if product == "yandex-cloud" %}an [OAuth token](../../iam/concepts/authorization/oauth-token.md) or {% endif %}a [static access key](../../iam/operations/sa/create-access-key.md), see the {{ iam-full-name }} instructions.

{% endif %}
