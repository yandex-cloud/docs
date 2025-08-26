```hcl
resource "yandex_cdn_resource" "my_resource" {
    cname               = "<domain_name>"
    active              = true
    origin_protocol     = "https"
    origin_group_id     = <origin_group_ID>
    secondary_hostnames = ["<additional_domain_name_1>", "additional_domain_name_2"]
    ssl_certificate {
      type = "certificate_manager"
      certificate_manager_id = "<certificate_ID>"
    }
    options {
      redirect_http_to_https = true
      secure_key = "<secret_key>"
      enable_ip_url_signing = true
      ip_address_acl {
        excepted_values = ["<IP_address_1>", "<IP_address_2>", ..., "<IP_address_n>"]
        policy_type = "<policy_type>"
      }
    }
}
```

Where:
* `cname`: Primary domain name used for content distribution. This is a required parameter.
* `active`: Optional flag for content availability to end users, where`true` means the CDN content is available to clients, and `false` means that the content not available. The default value is `true`.
* `origin_protocol`: Optional origin protocol. The default value is `http`.
* `origin_group_id`: [Origin group](../../cdn/concepts/origins.md) ID. This is a required parameter. Use the ID from the description of the origin group in the `yandex_cdn_origin_group` resource.
* `secondary_hostnames`: Optional additional domain names.
* `ssl_certificate`: Optional SSL certificate parameters:

    * `type`: Certificate type. The possible values are:

        * `not_used`: Certificate is not used. This is a default value.
        * `certificate_manager`: Custom certificate. Specify the certificate ID in the `certificate_manager_id` parameter.

          {% include [certificate-usage](certificate-usage.md) %}

    * `certificate_manager_id`: Custom certificate ID in {{ certificate-manager-name }}.

* `options`: Optional additional parameters of the CDN resource:

    * `redirect_http_to_https`: Parameter to redirect clients from HTTP to HTTPS, `true` or `false`. This parameter is available if an SSL certificate is used.
    * `secure_key`: Secret key, that is a string of 6 to 32 characters, which is required to restrict access to a resource using [secure tokens](../../cdn/concepts/secure-tokens.md).
    * `enable_ip_url_signing`: Optional parameter that enables restricting access to a CDN resource by IP address using [secure tokens](../../cdn/concepts/secure-tokens.md). The trusted IP address itself is provided outside the CDN resource and specified as a parameter when generating an [MD5](https://en.wikipedia.org/wiki/MD5) hash for a [pre-signed URL](../../cdn/concepts/secure-tokens.md#protected-link). If the parameter is not set, file access will be allowed from any IP address.

    * `ip_address_acl`: [IP-based access policy](../../cdn/concepts/ip-address-acl.md) parameters:

        * `ip_address_acl`: [List of IP addresses](../../cdn/concepts/ip-address-acl.md#ip-list) for which access to the resource content will be allowed or denied. Separate IP addresses by commas. For each address, specify the subnet prefix in [CIDR notation](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing#CIDR_notation), e.g., `192.168.3.2/32` or `2a03:d000:2980:7::8/128`.
        * `policy_type`: [Policy type](../../cdn/concepts/ip-address-acl.md#policy-type). The possible values are as follows:

            * `allow`: ALLOW policy. Access to the resource content will be allowed for any IP addresses other than those specified in the `ip_address_acl.excepted_values` parameter.
            * `deny`: DENY policy. Access to the resource content will be denied for any IP addresses other than those specified in the `ip_address_acl.excepted_values` parameter.

    {% note info %}

    Deleting the `secure_key` and `ip_address_acl` parameters in the configuration file will not automatically disable them. You can delete `secure_key` and `ip_address_acl` using the [CLI](../../cli/quickstart.md) or [API](../../api-design-guide/concepts/general.md).

    {% endnote %}

For more information about the `yandex_cdn_resource` properties in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/cdn_resource).