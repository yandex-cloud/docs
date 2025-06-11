## Cloud subnet announcements and communication with {{ vpc-short-name }} {#prc-announce}

To announce virtual network IP prefixes in a `Routing Instance`, you need to know the following:
* The ID (`vpc_net_id`) of the virtual network containing the prefixes that need to be announced.
* List of announced IPv4 prefixes of virtual network [subnets](../../vpc/concepts/network.md#subnet) and their allocation across [availability zones](../../overview/concepts/geo-scope.md). Typically, prefixes refer to the subnets configured in your cloud. In which case the announced prefixes and the actual subnet address ranges will match.

{% note info %}

Please keep in mind that the first IP address (default gateway) and the second IP address (default DNS server) in each subnet will not be available outside the cloud, regardless of the subnet announcement. Network traffic to these IP addresses can only be delivered from within a {{ yandex-cloud }} VM.

{% endnote %}

New subnets that will be created in the virtual network later will not be automatically announced to the RI.

To add a new subnet to an existing RI, use one of the [available methods](../operations/cr-cic-ops.md#ri). 

{% note warning %}

When using {{ yandex-cloud }} load balancers:
* [{{ network-load-balancer-short-name }}](../../network-load-balancer/) (NLB)
* [{{ alb-name }}](../../application-load-balancer/) (ALB)

Their listener addresses are announced as `/32` IPv4 prefixes.

This enables you to use load balancers to distribute traffic coming from your infrastructure via {{ interconnect-name }} across cloud resources in different {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).

{% endnote %}

{% note info %}

The IP prefix will only be announced in the client's direction if at least one VM with an IP address matching the announced prefix is created in the VPC. If no such VM is created, no route announcement will go in the client's direction, and IP connectivity with the client will not be established.

{% endnote %}

Your equipment announces IPv4 prefixes from your infrastructure over BGP towards the {{ yandex-cloud }} equipment. You can use the following types of prefixes in the announcements:
* Private IP subnets from [RFC-1918](https://www.ietf.org/rfc/rfc1918.txt).
* Default route: `0.0.0.0/0`.
* Public IP subnets.

{{ yandex-cloud }} equipment uses route redistribution to send these prefixes to {{ vpc-short-name }} subnets.

As soon as the {{ yandex-cloud }} equipment gets the client prefixes, they become available to all VMs and internal load balancers within the {{ vpc-short-name }} subnets.

No changes to the VM route tables are required to ensure IP connectivity between cloud resources and your infrastructure resources.

