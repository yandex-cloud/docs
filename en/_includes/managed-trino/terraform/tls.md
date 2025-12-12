```hcl
resource "yandex_trino_cluster" "<cluster_name>" {
  ...
  tls = {
    trusted_certificates = [<list_of_certificates>]
  }
  ...
}
```

Where:

* `tls`: TLS parameters.
  
    {% include notitle [tls](../cluster-settings.md#tls) %}

    * `trusted_certificates`: Comma-separated list of certificates.

      {% include notitle [tls](../cluster-settings.md#cert-list) %}

    {% include notitle [tls-pg-ch](../cluster-settings.md#tls-pg-ch) %}