```hcl
resource "yandex_cdn_origin_group" "my_group" {
  name          = "<origin_group_name>"
  use_next      = true
  provider_type = "<CDN_provider>"
  origin {
  source = "<origin_1_IP_address_or_domain_name>"
  }
  origin {
  source = "<origin_2_IP_address_or_domain_name>"
  }
  origin {
  source = "<origin_3_IP_address_or_domain_name>"
  backup = false
  }
}
```

Where:
* `name`: Origin group name.
* `use_next`: Indicates whether to use the next [origin](../../cdn/concepts/resource.md) on the list.
* `provider_type`: [CDN provider](../../cdn/concepts/providers.md), must match the origin group CDN provider. This is an optional setting. The possible values are:
    * `ourcdn` (default): {{ cdn-full-name }} provider.
    * `gcore`: EdgeCDN provider.

        {% include [provider-binding](provider-binding.md) %}

* `origin`: Origin specification:
  * `source`: Origin [IP address](../../vpc/concepts/address.md) or domain name.
  * `enabled`: Flag showing whether the origin is enabled.
  * `backup`: Flag showing whether the origin as a backup one. For more information about priorities, see [{#T}](../../cdn/concepts/origins.md#groups).

For more information about the resources you can create with {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/cdn_origin_group).