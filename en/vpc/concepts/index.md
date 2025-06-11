---
title: '{{ vpc-full-name }} concept'
description: '{{ vpc-full-name }} ({{ vpc-short-name }}) is a service for creating cloud networks that are used for transmitting information within your cloud and connecting cloud resources to the internet. With {{ vpc-short-name }}, you can create subnets and connect cloud resources to them, provide information transfer between cloud resources, connect cloud resources to the internet, build static routes, and manage traffic using security groups.'
---

# {{ vpc-short-name }} concepts

{{ vpc-full-name }} ({{ vpc-short-name }}) is a service for creating cloud networks that are used for transmitting information within your cloud and connecting cloud resources to the internet.

![image](../../_assets/vpc/vpc-overview.png)

With {{ vpc-short-name }}, you can:

- Create subnets and connect cloud resources to them.
- Enable information transfer between the cloud resources.
- Connect the cloud resources to the internet.
- Create static routes and manage traffic using security groups.
- Route traffic to the internet via a NAT gateway.

Above you can see a general diagram showing the relationships between networks, subnets, and {{ yandex-cloud }} resources. In the management console, you can open a [cloud network map](network.md#map) that, similar to the diagram above, visualizes the connections between your resources located within a selected folder.

For more information about cloud networks, see:
- [Cloud networks and subnets](network.md)
- [Cloud resource addresses](address.md)
- [Static routing](routing.md)
- [Security groups](security-groups.md)