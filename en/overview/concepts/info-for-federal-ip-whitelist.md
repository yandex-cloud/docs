
# Obtaining the information you need to have a resource whitelisted by the Russian Ministry of Digital Development

During the periods of mobile internet restrictions in the Russian Federation, telecom providers continue to make a number of socially important resources permanently available to end users. These socially important resources constitute the so-called _whitelist_, maintained and regularly updated by the [Ministry of Digital Development, Communications and Mass Media of the Russian Federation (Ministry of Digital Development)](https://digital.gov.ru/).

If you want your resources whitelisted by the Ministry of Digital Development, and your resources rely on the {{ yandex-cloud }} infrastructure and [services](./services.md), you will need the public IP addresses allocated by {{ yandex-cloud }} for end user access to your resources.

## How to find out the IP address of your resource in the {{ yandex-cloud }} infrastructure {#identify-your-ip}

All public IP addresses of the resources you want whitelisted must be [reserved](#reserve-ip) for you and no one else. You may attach a relevant screenshot from the [management console]({{ link-console-main }}) as a proof of your right to use these IP addresses.

{% note warning %}

We do not recommend submitting ranges of IP address to the Ministry of Digital Development. Submit individual IP addresses nistead, i.e., addresses with the `/32` prefix in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation.

{% endnote %}

### How to find out the public IP address of your resource in {{ yandex-cloud }} {#get-known-ip}

In the [{{ yandex-cloud }} ecosystem](./services.md), some services assign individual public IP addresses to certain user resources. These resources include:

* [VM instances](../../compute/concepts/vm.md) in [{{ compute-full-name }}](../../compute/index.yaml). To learn the public IP address of a VM instance, follow [this guide](../../compute/operations/vm-info/get-info.md).
* [Physical servers](../../baremetal/concepts/servers.md) in [{{ baremetal-full-name }}](../../baremetal/index.yaml). To learn the public IP address of a {{ baremetal-name }} server, follow [this guide](../../baremetal/operations/servers/get-info.md).
* [{{ k8s }} clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and [cluster nodes](../../managed-kubernetes/concepts/index.md#node-group) in [{{ managed-k8s-full-name }}](../../managed-kubernetes/index.yaml). To learn the public IP address of a {{ k8s }} cluster and nodes, follow these guides: [{#T}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md) and [{#T}](../../managed-kubernetes/operations/node-connect-ssh.md#node-public-ip).
* [L7 load balancers](../../application-load-balancer/concepts/application-load-balancer.md) in [{{ alb-full-name }}](../../application-load-balancer/index.yaml). To learn the public IP address of an L7 load balancer, follow [this guide](../../application-load-balancer/operations/application-load-balancer-get.md).
* [External network load balancers](../../network-load-balancer/concepts/nlb-types.md) in [{{ network-load-balancer-full-name }}](../../network-load-balancer/index.yaml). To learn the public IP address of an external network load balancer, follow [this guide](../../network-load-balancer/operations/load-balancer-list.md#get).
* [Proxy servers](../../smartwebsecurity/concepts/domain-protect.md#proxy) in [{{ sws-full-name }}](../../smartwebsecurity/index.yaml). To learn the public IP address of a proxy server, use your [management console]({{ link-console-main }}).
* With [{{ cdn-full-name }}](../../cdn/index.yaml), you can get dedicated IP addressing for your [CDN resources](../../cdn/concepts/resource.md) distributed through all [points of presence](../../cdn/concepts/points-of-presence.md). To get a dedicated IP address assigned to your CDN resource alone, [contact]({{ link-console-support }}) {{ yandex-cloud }} support.

{% note tip %}

You can always learn the public IP addresses assigned to your resources in the {{ yandex-cloud }} infrastructure from the AI assistant. For more information, see [this guide](../../console/operations/ai-assistant.md).

{% endnote %}

Other {{ yandex-cloud }} services [do not assign](#work-around) individual public IP addresses to user resources; instead, the user's traffic is routed to a single IP address and processed in parallel with other users' traffic.

### How to reserve a public IP address to avoid losing it {#reserve-ip}

Public IP addresses can be dynamic or static. A dynamic IP address may change when the resource it is assigned to (e.g., a {{ compute-name }} VM instance) is stopped and then restarted. A static IP address is reserved and available to the user's resources on a permanent basis. For more information, see [{#T}](../../vpc/concepts/address.md#public-addresses).

Only static (reserved) public IP addresses can be whitelisted by the Ministry of Digital Development. You can reserve a static public IP address either before or after creating the resource. For more information, see these guides:
* [{#T}](../../vpc/operations/get-static-ip.md)
* [{#T}](../../vpc/operations/set-static-ip.md)

To prevent accidental deletion, get your reserved public IP address protected. For more information, see [{#T}](../../vpc/operations/deletion-protection.md).

Follow these recommendations to proactively list the IP addresses used by your resources, make them deletion-protected, and use them as needed.

### What to do if your {{ yandex-cloud }} resource does not have a dedicated public IP address {#work-around}

You may also face a situation where there is a {{ yandex-cloud }} infrastructure resource which is not on the [list](#get-known-ip) mentioned above and cannot get a public IP address of its own (e.g., an {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md)), but you still need to have it whitelisted by the Ministry of Digital Development.

In which case you can introduce an additional intermediate component in between the traffic and your application: an [L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md). In this setup, user requests first go to the load balancer, which has a dedicated IP address you can have whitelisted by the Ministry of Digital Development; and from there, the requests go to the target resource in the {{ yandex-cloud }} infrastructure.

This access arrangement offers some additional benefits: give your L7 load balancer a {{ sws-name }} [security profile](../../smartwebsecurity/concepts/profiles.md) for your resources to get extra application-layer (L7) protection against DDoS attacks and bots.

Below are examples of how you can use a load balancer for access to applications:

* [{#T}](../../tutorials/security/distributed-secured-infrastructure.md)
* [{#T}](../../tutorials/web/cdn-storage-integration.md)
* [{#T}](../../tutorials/security/alb-with-ddos-protection/index.md)
* [{#T}](../../tutorials/security/balancer-with-sws-profile/index.md)
* [{#T}](../../tutorials/security/alb-ingress-with-sws-profile.md)
* [{#T}](../../tutorials/security/sws-protection-ongoing-ddos.md)
* [{#T}](../../tutorials/web/application-load-balancer-website/index.md)
* [{#T}](../../tutorials/web/virtual-hosting.md)
* [Protecting a service with {{ sws-name }}](../../smartwebsecurity/tutorials/sws-basic-protection.md)