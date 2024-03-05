# IP-based access policy

_IP-based access policy_ allows you to restrict access to the content distributed over a CDN by blacklisting and whitelisting IP addresses for [CDN resources](./resource.md).

You can configure the access policy when [creating](../operations/resources/create-resource.md) or [updating](../operations/resources/configure-basics.md) a CDN resource using the [CLI](../../cli/quickstart.md), [{{ TF }}]({{ tf-provider-resources-link }}/cdn_resource), and [API](../../api-design-guide/concepts/general.md).

The IP-based access policy is defined by the [policy type](#policy-type) and the [list of IP addresses](#ip-list) to exclude from the policy.

For more information about IP-based access policies, see the EdgeCenter [CDN provider documentation](https://support.edgecenter.ru/knowledge_base/item/257918?sid=57227).

## Policy type {#policy-type}

You can set up an _allow_ or a _block_ access policy for a resource.

The allow policy allows access to the CDN resource content for any IP addresses other than those excluded by the user. The `allow` value defines the policy. The addresses excluded from the allow policy make up the IP blacklist.

The block policy denies access to the CDN resource content for any IP addresses other than those excluded by the user. The `deny` value defines the policy. The addresses excluded from the block policy make up the IP whitelist.

## List of excluded IP addresses {#ip-list}

IP addresses excluded from the access policy must have a subnet prefix in the [CIDR notation](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing#CIDR_notation), e.g., `192.168.3.2/32` or `2a03:d000:2980:7::8/128`. For each user-specified address, the service determines the IP range of the network covering the address in question and puts all addresses from this range on the exclusion list.

For example, if a user specifies the `1.2.3.4/24` address, the service will put the entire range of IP addresses from `1.2.3.1` to `1.2.3.254` on the exclusion list as all of them belong to the `1.2.3.0/24` network containing the user-specified address.

All excluded ranges make up an IP blacklist or whitelist depending on the specified [policy type](#policy-type).

#### See also {#see-also}

* [{#T}](../operations/resources/create-resource.md)
* [{#T}](../operations/resources/configure-basics.md)