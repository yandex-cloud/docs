A cloud network must have:
* [Subnets]({{ link-docs }}/vpc/concepts/network#subnet) in all [availability zones]({{ link-docs }}/overview/concepts/geo-scope).
* At least one resource with an IP address in the specified cloud network.

{% note info %}

If the network does not meet the conditions above, the service does not guarantee it will function properly.

{% endnote %}