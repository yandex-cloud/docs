---
title: Points of presence in {{ cdn-full-name }}
description: A {{ cdn-name }} point of presence is the physical location of CDN servers.
---

# Points of presence

_Points of presence_, or PoPs, are geographically distributed physical CDN servers that cache and deliver content to end users. They reside in strategic geographic locations with efficient access to communication links, enabling content delivery via the shortest route with minimal latency.

{{ cdn-full-name }} provides access to 38 points of presence with a total throughput exceeding 3 Tbps.

{% note info %}

We are continuously developing and expanding the {{ cdn-full-name }} network with new points of presence. For the current list of subnets, see [{{ cdn-name }} public IP address ranges](../../overview/concepts/public-ips.md#cloud-cdn).

{% endnote %}

Apart from the number of PoPs, their proper placement and technical equipment are also critical.

The physical distance between geographic points on the map may vary greatly from the real path of an internet request. For example, two devices located in the same building but connected to different providers will exchange traffic via peering links between the providers. These peering links may be located in a different city or region.

{{ cdn-full-name }} PoPs are deployed based on the network infrastructure specifics and traffic exchange patterns. Optimal placement depends on how close the PoP is to communication links and peering points.

The closest PoP is not necessarily the optimal one for content delivery. Communication links can be congested, resulting in increased latency. Load balancing algorithms in {{ cdn-full-name }} help avoid PoP overload and automatically reroute requests to least loaded servers.
PoP server performance also shapes the overall content delivery speed. Stable delivery requires servers that stay within healthy load levels and run on modern hardware, including processors and cache storage disks.

{{ cdn-full-name }} uses state-of-the-art hardware to provide reliable and highly efficient performance for each PoP.

## List of cities with PoPs {#yc-pop-list}

Cities with at least one PoP:

| **Russia** | **Kazakhstan** | **Uzbekistan** |
|------------|---------------|----------------|
| Alexandrov | Aktobe | Tashkent |
| Vladivostok | Karaganda | |
| Voronezh | | |
| Yekaterinburg | | |
| Krasnodar | | |
| Moscow | | |
| Nizhny Novgorod | | |
| Novosibirsk | | |
| Petrozavodsk | | |
| Rostov-on-Don | | |
| Samara | | |
| Saint Petersburg | | |
| Simferopol | | |
| Tambov | | |
| Tyumen | | |
| Khabarovsk | | |
| Chelyabinsk | | |
| Chita | | |

## FAQ {#qa}

{% cut "What if my city does not host a PoP?" %}

If your city does not host a {{ cdn-full-name }} PoP, traffic will be automatically routed to the nearest available one. Load balancing algorithms factor in not only geographic proximity but also the current server load and communication link quality, ensuring an optimal content delivery speed.

{% endcut %}

{% cut "Are these resources available outside Russia, Kazakhstan, and Uzbekistan?" %}

Yes, {{ cdn-full-name }} resources are available worldwide, even though its PoPs can only be found in Russia, Kazakhstan, and Uzbekistan. Users in other countries will be receiving content from PoPs in Russia, Kazakhstan, and Uzbekistan. With high throughput and modern hardware, content delivery stays efficient even for users in other countries.

{% endcut %}

{% cut "How go I get a list of PoP IP addresses to configure my firewall?" %}

For the current list of {{ cdn-full-name }} PoP IP addresses, see [{{ cdn-name }}](../../security/ip-list.md#cloud-cdn).

To reduce the number of networks sending requests to the origin, [enable](../operations/resources/enable-shielding.md) origin shielding. With this option enabled, the origin will only get requests from intermediate caching servers. To get the list of the shielding servers' networks, contact [support]({{ link-console-support }}).

{% endcut %}

{% cut "Where are your shielding servers located?" %}

[{{ cdn-full-name }} shielding servers](origins-shielding.md) are located in Moscow. They provide an additional caching layer between PoPs and content origins, reducing load on the origins and increasing the content delivery speed for users.

{% endcut %}

#### See also {#see-also}

* [{#T}](./resource.md)
* [{#T}](./origins.md)