## Setting up a public connection {#pbc-create}

To set up a new public connection in an existing trunk, create a [new support request]({{ link-console-support }}/create-ticket).

### Contacting support to set up a public connection {#prc-ticket}

{% note warning %}

All public connection attribute values in the support request text below are used for indicative purposes only. Each customer should have their own attribute values.

{% endnote %}

Write a support request as follows:
```s
Subject: [CIC] Add a public connection to an existing trunk.

Request text:
Please add a public connection to an existing trunk. Connection parameters:
trunk_id: euus5dfgchu23b81d472
vlan_id: 101
ipv4_peering:
  peer_bgp_asn: 65001
  #yandex_cloud_bgp_asn: 200350
allowed-public-services:
  - storage.yandexcloud.net
  - transcribe.api.cloud.yandex.net
is_nat_subnet_required: True
```

Where:

* `trunk_id` is the trunk ID received from the support team at the previous step.
* `vlan_id` is the `VLAN-ID` for the public connection in trunk 802.1Q. This value is selected by the customer and must be different from the `VLAN-ID` values of the private connections previously set up in this trunk.
* `peer_bgp_asn` is the [BGP ASN](../../interconnect/concepts/priv-con.md#bgp-asn) on the customer's equipment. This value is selected by the customer.
* `allowed-public-services` is a list of `API Endpoint FQDNs` for the services [from the table](../../interconnect/concepts/pub-con.md#pub-svc-list) to provide access to via this public connection.
* `is_nat_subnet_required` determines whether the customer needs to be allocated an additional `/30` subnet (apart from the point-to-point `/31` subnet) to implement [NAT functions](../../interconnect/concepts/pub-con.md#pub-nat). By default,  the value is set to `False` (no additional subnet is allocated).

### Support team's response to the customer's request {#prc-ticket-resp}

Once you complete all required actions for setting up a public connection, the support team will provide the customer with the ID of the created public connection.

Here is how the support team may respond to the request for creating a public connection (this sample is provided for informational purposes only):
```s
id: cf3qdug4fsf737g2gpdu
ipv4_peering:
  peering_subnet: 178.210.118.46/31
  peer_ip: 178.210.118.47
  yandex_cloud_ip: 178.210.118.46
  peer_bgp_asn: 65001
  #yandex_cloud_bgp_asn: 200350
ipv4_nat:
  nat_subnet: 178.210.118.200/30
allowed-public-services:
  - storage.yandexcloud.net
  - transcribe.api.cloud.yandex.net
```
Where:

* `id` is the ID of the created public connection.
* `peering_subnet` is a [point-to-point subnet](../../interconnect/concepts/pub-con.md#pub-address) for BGP peering, which is allocated from the {{ yandex-cloud }} [address pool](../../vpc/concepts/ips.md).
* `peer_ip` is the IP address of the point-to-point (peering) subnet on the customer's equipment. It is assigned by {{ yandex-cloud }}.
* `yandex_cloud_ip` is the IP address of the point-to-point (peering) subnet on the Yandex Cloud equipment. It is assigned by {{ yandex-cloud }}.
* `nat_subnet` is an additional subnet allocated from the {{ yandex-cloud }} public address space to implement [NAT functions](../../interconnect/concepts/pub-con.md#pub-nat).
* `allowed-public-services` is a list of `API Endpoint FQDNs` from the customer request for the services to provide access to via the created public connection.

### Monitoring the status of a public connection {#pbc-check}

* Use the [monitoring](../../interconnect/concepts/monitoring.md#private-mon) service to, on your own, monitor when the public connection's BGP session on the {{ yandex-cloud }} equipment switches to the running status.
* The support team will notify you when they finish configuring access to the requested {{ yandex-cloud }} public resources. The configuration process usually takes up to one business day.
* You should check the IP connectivity between your equipment and the cloud resources to be accessible through the configured public connection yourself and notify the support team of the check results.
* If there are any IP connectivity issues, contact support so that they may run diagnostics and troubleshooting.

