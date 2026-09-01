---
title: Points of presence in {{ cdn-full-name }}
description: A {{ cdn-name }} point of presence is the physical location of CDN servers.
---

# Points of presence

_Points of presence_, or PoPs, are geographically distributed physical CDN servers that cache and deliver content to end users. They reside in strategic geographic locations with efficient access to communication links, enabling content delivery via the shortest route with minimal latency.


#|
|| **Total number of points of presence** | **Total throughput** ||
|| {{ cdn-pop-count }} {align="center"} | Exceeding {{ cdn-throughput }} Tbps {align="center"} ||
|#



{% note info %}

We are continuously developing and expanding the {{ cdn-full-name }} network with new points of presence. For the current list of subnets, see [{{ cdn-name }} public IP address ranges](../../overview/concepts/public-ips.md#cloud-cdn).

{% endnote %}

Apart from the number of PoPs, their proper placement and technical equipment are also critical.

The physical distance between geographic points on the map may vary greatly from the real path of an internet request. For example, two devices located in the same building but connected to different providers will exchange traffic via peering links between the providers. These peering links may be located in a different city or region.

{{ cdn-full-name }} PoPs are deployed based on the network infrastructure specifics and traffic exchange patterns. Optimal placement depends on how close the PoP is to communication links and peering points.

The closest PoP is not necessarily the optimal one for content delivery. Communication links can be congested, resulting in increased latency. Load balancing algorithms in {{ cdn-full-name }} help avoid PoP overload and automatically reroute requests to least loaded servers.

Learn more about traffic balancing algorithms:

* [Cloud load balancers: Enhancing availability and fault tolerance](https://yandex.cloud/ru/blog/posts/2025/04/load-balancers-guide)
* [Under the hood of {{ cdn-full-name }}](https://runtime.strm.yandex.ru/player/video/vplvchkrwxqmrw76lajj)

PoP server performance also shapes the overall content delivery speed. Stable delivery requires servers that stay within healthy load levels and run on modern hardware, including processors and cache storage disks.

{{ cdn-full-name }} uses state-of-the-art hardware to provide reliable and highly efficient performance for each PoP.


## Cities with PoPs {#yc-pop-list}

The following cities have at least one PoP:

<iframe frameborder="0" src="https://datalens.yandex/f73o6nej25s4y?_embedded=1&_no_controls=1" width="100%" height="400px"></iframe>

#|
|| **Country** {align="center"} | **Cities** {align="center"} ||
|| **{{ cdn-pops.0.country }}** | &bull;&nbsp;{{ cdn-pops.0.cities.0 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.1 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.2 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.3 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.4 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.5 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.6 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.7 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.8 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.9 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.10 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.11 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.12 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.13 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.14 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.15 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.16 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.17 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.18 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.19 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.20 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.21 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.22 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.23 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.24 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.25 }}&ensp;&bull;&nbsp;{{ cdn-pops.0.cities.26 }}&ensp; ||
|| **{{ cdn-pops.1.country }}** | &bull;&nbsp;{{ cdn-pops.1.cities.0 }}&ensp; ||
|| **{{ cdn-pops.2.country }}** | &bull;&nbsp;{{ cdn-pops.2.cities.0 }}&ensp; ||
|| **{{ cdn-pops.3.country }}** | &bull;&nbsp;{{ cdn-pops.3.cities.0 }}&ensp;&bull;&nbsp;{{ cdn-pops.3.cities.1 }}&ensp; ||
|| **{{ cdn-pops.4.country }}** | &bull;&nbsp;{{ cdn-pops.4.cities.0 }}&ensp; ||
|| **{{ cdn-pops.5.country }}** | &bull;&nbsp;{{ cdn-pops.5.cities.0 }}&ensp; ||
|| **{{ cdn-pops.6.country }}** | &bull;&nbsp;{{ cdn-pops.6.cities.0 }}&ensp; ||
|| **{{ cdn-pops.7.country }}** | &bull;&nbsp;{{ cdn-pops.7.cities.0 }}&ensp; ||
|#


## FAQ {#qa}

{% cut "What if my city does not host a PoP?" %}

If your city does not host a {{ cdn-full-name }} PoP, traffic will be automatically routed to the nearest available one. Load balancing algorithms factor in not only geographic proximity but also the current server load and communication link quality, ensuring an optimal content delivery speed.

{% endcut %}


{% cut "Are resources available in the countries without PoPs?" %}



Yes, the {{ cdn-full-name }} resources are available worldwide. If there is no PoP in the user's country, the traffic is automatically routed to an optimal available point based on the server load and communication link quality. Thanks to high throughput and modern hardware, content delivery stays efficient.

{% endcut %}

{% cut "How go I get a list of PoP IP addresses to configure my firewall?" %}

For the current list of {{ cdn-full-name }} PoP IP addresses, see [{{ cdn-name }}](../../security/ip-list.md#cloud-cdn).

To reduce the number of networks sending requests to the origin, [enable](../operations/resources/enable-shielding.md) origin shielding. With this option on, the origin will be getting requests only from intermediate caching servers. To get the list of the shielding servers' networks, contact [support]({{ link-console-support }}).


{% endcut %}

{% cut "Where are your shielding servers located?" %}

[{{ cdn-full-name }} shielding servers](origins-shielding.md) are located in Moscow. They provide an additional caching layer between PoPs and content origins, reducing load on the origins and increasing the content delivery speed for users.


{% endcut %}

#### Useful links {#see-also}

* [{#T}](./resource.md)
* [{#T}](./origins.md)
