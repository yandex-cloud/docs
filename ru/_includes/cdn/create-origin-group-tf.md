```hcl
resource "yandex_cdn_origin_group" "my_group" {
  name          = "<имя_группы_источников>"
  use_next      = true
  provider_type = "<CDN-провайдер>"
  origin {
  source = "<IP-адрес_или_доменное_имя_источника_1>"
  }
  origin {
  source = "<IP-адрес_или_доменное_имя_источника_2>"
  }
  origin {
  source = "<IP-адрес_или_доменное_имя_источника_3>"
  backup = false
  }
}
```

Где:
* `name` — имя группы источников.
* `use_next` — указывает, использовать ли следующий [источник](../../cdn/concepts/resource.md) из списка.
* `provider_type` — провайдер CDN. Необязательный параметр. Единственное возможное значение: `ourcdn` — провайдер {{ cdn-full-name }}.
* `origin` — спецификация источника:
    * `source` — [IP-адрес](../../vpc/concepts/address.md) или доменное имя источника.
    * `enabled` — флаг, указывающий, включен ли источник.
    * `backup` — флаг, указывающий, является ли источник резервным. Подробнее о приоритетах см. в разделе [{#T}](../../cdn/concepts/origins.md#groups).

Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/cdn_origin_group).