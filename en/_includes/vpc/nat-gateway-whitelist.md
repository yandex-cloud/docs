{% note info %}

If the external resource restrict access by IP addresses, keep in mind that public IP addresses of a [NAT gateway](../../vpc/concepts/gateways.md#nat-gateway) may change and that you cannot reserve them. For access from a fixed IP address, use a [NAT instance](../../vpc/tutorials/nat-instance/index.md) with a [static public IP address](../../vpc/operations/set-static-ip.md). Add this address to the list of addresses allowed on the external resource.

[Ranges of public IPv4 addresses of {{ yandex-cloud }} resources](../../vpc/concepts/ips.md) use different cloud clients. Adding all these ranges to the list of allowed ones will ensure network access from IP addresses of other clients as well.

{% endnote %}
