---
title: Dedicated IP addressing of CDN resources
description: This section describes dedicated IP addressing of CDN resources, which allows you to get a unique IP address exclusively for your resources.
---

# Dedicated IP addressing of CDN resources

By default, multiple customers may share a single public IP address.

On request, you can [get](../operations/resources/dedicated-ip-addressing.md) a dedicated public IP address that will be used exclusively for your [CDN resources](resource.md) in {{ cdn-full-name }}. Content delivery will continue through all [points of presence](points-of-presence.md).

The dedicated IP address is associated with a folder. This means, within a single folder, dedicated IP addressing will apply to all CDN resources by default, and they will all have the same IP address.

For balancing CDN resources with dedicated IP addressing, there are [BGP Anycast](https://{{ lang }}.wikipedia.org/wiki/Anycast) and GSLB DNS-based methods. These approaches differ from standard balancing used for resources without dedicated IP addresses. With BGP Anycast, the same IP address is announced from all CDN points of presence. This enables the system to seamlessly serve the entire network of PoPs even with a single IP address.

You may need to use dedicated IP addressing of CDN resources to:

* Have your resources [whitelisted by the Russian Ministry of Digital Development](../../overview/concepts/info-for-federal-ip-whitelist.md).
* Enhance security.
* Isolate your resources from those of other CDN users, including when you need to access resources via [security group](../../vpc/concepts/security-groups.md) settings.


#### See also {#see-also}

* [{#T}](points-of-presence.md)
* [{#T}](../operations/resources/dedicated-ip-addressing.md)