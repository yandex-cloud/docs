# CDN providers

_CDN provider_ is a content delivery service provider.

{{ cdn-full-name }} supports the following content delivery network providers:
* {{ cdn-full-name }} based on Yandex own technology. It is used by default.
* [EdgeCDN](https://edgecenter.ru/cdn) based on the external infrastructure of our partner, EdgeCenter.

Both providers offer the same capabilities and support the same interfaces for resource and CDN origin management: the [management console]({{ link-console-main }}), [CLI](../cli-ref/index.md), [{{ TF }}](../tf-ref.md), and [API](../api-ref/authentication.md).

However, the metrics providers send to [{{ monitoring-full-name }}](../../monitoring/) are different:
* [{{ cdn-full-name }} provider metrics](../metrics-yc.md)
* [EdgeCDN provider metrics](../metrics.md)

This means the dashboards in {{ monitoring-name }} will also differ accordingly. For more information, see [{#T}](../operations/resources/get-stats.md).

You do not need to activate a provider in your folder.

{% include [provider-binding](../../_includes/cdn/provider-binding.md) %}

#### See also {#see-also}

* [{#T}](../quickstart.md)
* [{#T}](./index.md)