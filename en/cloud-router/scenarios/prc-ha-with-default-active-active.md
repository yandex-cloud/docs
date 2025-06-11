# Even traffic distribution for route 0.0.0.0/0

In some cases, e.g., to connect cloud resources to the internet via the customer infrastructure, you need to set up `0.0.0.0/0` route announcement over BGP towards {{ yandex-cloud }}.

![cic-routing-5](../../_assets/interconnect/cic-routing-5.svg)

The flowchart above shows how the traffic from cloud subnets connected to {{ interconnect-name }} is unconditionally routed to customer edge routers via both points of presence.

[Security groups](../../vpc/concepts/security-groups.md) cannot be assigned to resources outside {{ yandex-cloud }}; therefore, the correct way to filter traffic is to use IPv4 prefixes rather than links to other security groups.

In this case, the customer can configure traffic filtering rules on customer edge routers before sending it to the internet through their own NAT gateway without using the {{ yandex-cloud }} infrastructure.

