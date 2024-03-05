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
* `active`: (Optional) Flag for content availability to end users (`true`: CDN content is available to clients; `false`: content not available). The default value is `true`.
* `origin_protocol`: (Optional) Origin protocol. The default value is `HTTP`.
* `origin_group_id`: ID of the [origin group](../../cdn/concepts/origins.md). This is a required parameter. Use the ID from the description of the origin group in the `yandex_cdn_origin_group` resource.
* `secondary_hostnames`: (Optional) Additional domain names.
* `ssl_certificate`: (Optional) SSL certificate parameters:

   * `type`: Certificate type. The possible values are:

      * `not_used`: No certificate is used. Default value.
      * `certificate_manager`: Custom [{{ certificate-manager-full-name }}](../../certificate-manager/concepts/imported-certificate.md) certificate. Specify the certificate ID in the `certificate_manager_id` parameter.

   * `certificate_manager_id`: User certificate ID in {{ certificate-manager-name }}.

* `options`: (Optional) Additional parameters of the CDN resource:

   * `redirect_http_to_https`: Parameter to redirect clients from HTTP to HTTPS, `true` or `false`. Available if an SSL certificate is used.
   * `secure_key`: Secret key that is a string of 6 to 32 characters. It is required to restrict access to a resource using [secure tokens](../../cdn/concepts/secure-tokens.md).
   * `enable_ip_url_signing`: Optional parameter that enables restricting access to a CDN resource by IP address using [secure tokens](../../cdn/concepts/secure-tokens.md). A trusted IP address is specified as a parameter outside a CDN resource when generating an [MD5](https://en.wikipedia.org/wiki/MD5) hash for a [signed link](../../cdn/concepts/secure-tokens.md#protected-link). If the parameter is not set, file access will be allowed from any IP.

   * `ip_address_acl`: [Access policy parameters by IP addresses](../../cdn/concepts/ip-address-acl.md):

      * `excepted_values`: [List of IP addresses](../../cdn/concepts/ip-address-acl.md#ip-list) for which access to the resource content will be allowed or denied. Separate IP addresses by commas. For each address, specify the subnet prefix in [CIDR notation](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing#CIDR_notation), e.g., `192.168.3.2/32` or `2a03:d000:2980:7::8/128`.
      * `policy_type`: [Policy type](../../cdn/concepts/ip-address-acl.md#policy-type). The possible values include:

         * `allow`: Allowing policy. Access to the resource content will be allowed for any IP addresses other than those specified in the `ip_address_acl.excepted_values` parameter.
         * `deny`: Blocking policy. Access to the resource content will be denied for any IP addresses other than those specified in the `ip_address_acl.excepted_values` parameter.

   {% note info %}

   If you delete the `secure_key` and `ip_address_acl` parameters in the configuration file, these options will not be automatically disabled. To disable the `secure_key` and `ip_address_acl` options, use the [CLI](../../cli/quickstart.md) or [API](../../api-design-guide/concepts/general.md).

   {% endnote %}

For more information about `yandex_cdn_resource` parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/cdn_resource).