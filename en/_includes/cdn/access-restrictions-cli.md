If you want to restrict access to resource content with [secure tokens](../../cdn/concepts/secure-tokens.md), use the following parameters:

* `--secure-key`: Secret key, a string of 6 to 32 characters.
* `--enable-ip-url-signing`: Optional parameter that restricts access to the CDN resource by IP address. The trusted IP address itself is provided outside the CDN resource and specified as a parameter when generating an [MD5](https://en.wikipedia.org/wiki/MD5) hash for a [pre-signed URL](../../cdn/concepts/secure-tokens.md#protected-link). If the parameter is not set, file access will be allowed from any IP address.

See also [{#T}](../../cdn/operations/resources/enable-secure-token.md).

If you want to restrict access to resource content using an [IP address access policy](../../cdn/concepts/ip-address-acl.md), use the following parameters:

* `--acl-excepted-values`: IP address for which access to the content will be allowed or denied. For the address, specify the subnet prefix in [CIDR notation](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing#CIDR_notation), e.g., `192.168.3.2/32` or `2a03:d000:2980:7::8/128`.

    You can only provide one IP address in the `--acl-excepted-values` parameter. To provide multiple addresses, set the `--acl-excepted-values` parameter for each address.

* `--policy-type`: [Policy type](../../cdn/concepts/ip-address-acl.md#policy-type). The possible values are as follows:

    * `allow`: ALLOW policy. Access to the resource content will be allowed for any IP addresses other than those specified in the `--acl-excepted-values` parameter.
    * `deny`: DENY policy. Access to the resource content will be denied for any IP addresses other than those specified in the `--acl-excepted-values` parameter.