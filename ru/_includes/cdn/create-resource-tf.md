```hcl
resource "yandex_cdn_resource" "my_resource" {
    cname               = "<имя_домена>"
    active              = true
    origin_protocol     = "https"
    origin_group_id     = <идентификатор_группы_источников>
    secondary_hostnames = ["<дополнительное_доменное_имя_1>", "дополнительное_доменное_имя_2"]
    ssl_certificate {
      type = "certificate_manager"
      certificate_manager_id = "<идентификатор_сертификата>"
    }
    options {
      redirect_http_to_https = true
      secure_key = "<секретный_ключ>"
      enable_ip_url_signing = true
      ip_address_acl {
        excepted_values = ["<IP-адрес_1>", "<IP-адрес_2>", ..., "<IP-адрес_n>"]
        policy_type = "<тип_политики>"
      }
    }
}
```

Где:
* `cname` — основное доменное имя для раздачи контента. Обязательный параметр.
* `active` — (опционально) флаг, указывающий на доступ к контенту для конечных пользователей: `true` — контент из CDN доступен клиентам, `false` — доступ к контенту отключен. Значение по умолчанию: `true`.
* `origin_protocol` — (опционально) протокол для источников. Значение по умолчанию: `http`.
* `origin_group_id` — идентификатор [группы источников](../../cdn/concepts/origins.md). Обязательный параметр. Используйте идентификатор из описания группы источников в ресурсе `yandex_cdn_origin_group`.
* `secondary_hostnames` — (опционально) дополнительные доменные имена.
* `ssl_certificate` — (опционально) параметры SSL-сертификата:

    * `type` — тип сертификата, возможные значения:

        * `not_used` — без сертификата. Значение по умолчанию.
        * `certificate_manager` — пользовательский сертификат. Укажите идентификатор сертификата в параметре `certificate_manager_id`.

          {% include [certificate-usage](certificate-usage.md) %}

    * `certificate_manager_id` — идентификатор пользовательского сертификата в {{ certificate-manager-name }}.

* `options` — (опционально) дополнительные параметры CDN-ресурса:

    * `redirect_http_to_https` — параметр для переадресации клиентов с HTTP на HTTPS, возможные значения: `true` или `false`. Доступно при использовании SSL-сертификата.
    * `secure_key` — секретный ключ. Произвольная строка длиной от 6 до 32 символов. Необходим, чтобы ограничить доступ к ресурсу с помощью [защищенных токенов](../../cdn/concepts/secure-tokens.md).
    * `enable_ip_url_signing` — опциональный параметр, который включает ограничение доступа к CDN-ресурсу по IP-адресу с помощью [защищенных токенов](../../cdn/concepts/secure-tokens.md). Сам доверенный IP-адрес задается вне CDN-ресурса и указывается в качестве параметра при формировании [MD5](https://ru.wikipedia.org/wiki/MD5)-хэша для [подписанной ссылки](../../cdn/concepts/secure-tokens.md#protected-link). Если параметр не задан, доступ к файлам будет разрешен с любых IP-адресов.

    * `ip_address_acl` — параметры [политики доступа по IP-адресам](../../cdn/concepts/ip-address-acl.md):

        * `excepted_values` — [список IP-адресов](../../cdn/concepts/ip-address-acl.md#ip-list), для которых будет разрешен или запрещен доступ к контенту ресурса. IP-адреса указываются через запятую. Для каждого адреса укажите префикс подсети в [нотации CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), например: `192.168.3.2/32` или `2a03:d000:2980:7::8/128`.
        * `policy_type` — [тип политики](../../cdn/concepts/ip-address-acl.md#policy-type). Возможные значения:

            * `allow` — разрешающая политика. Доступ к контенту ресурса будет разрешен для любых IP-адресов, кроме адресов, заданных в параметре `ip_address_acl.excepted_values`.
            * `deny` — блокирующая политика. Доступ к контенту ресурса будет запрещен для любых IP-адресов, кроме адресов, заданных в параметре `ip_address_acl.excepted_values`.

    {% note info %}

    Если в конфигурационном файле удалить параметры `secure_key` и `ip_address_acl`, эти опции не отключатся автоматически. Чтобы отключить опции `secure_key` и `ip_address_acl`, используйте [CLI](../../cli/quickstart.md) или [API](../../api-design-guide/concepts/general.md).

    {% endnote %}

Более подробную информацию о параметрах `yandex_cdn_resource` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/cdn_resource).