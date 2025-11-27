```hcl
resource "yandex_trino_cluster" "<имя_кластера>" {
  ...
  tls = {
    trusted_certificates = [<список_сертификатов>]
  }
  ...
}
```

Где:

* `tls` — параметры TLS.
  
    {% include notitle [tls](../cluster-settings.md#tls) %}

    * `trusted_certificates` — список сертификатов, разделенных запятой.

      {% include notitle [tls](../cluster-settings.md#cert-list) %}

    {% include notitle [tls-pg-ch](../cluster-settings.md#tls-pg-ch) %}