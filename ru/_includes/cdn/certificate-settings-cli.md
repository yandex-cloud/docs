Чтобы настроить [TLS-сертификат](../../cdn/concepts/clients-to-servers-tls.md) для CDN-ресурса, используйте параметры:

* `--dont-use-ssl-cert` — не использовать сертификат. Ресурс будет доступен только по протоколу HTTP.
* `--cert-manager-ssl-cert-id` — идентификатор сертификата. Ресурс будет доступен по протоколам HTTP и HTTPS.

  {% include [certificate-usage](certificate-usage.md) %}