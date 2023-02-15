## Setting up a private connection {#prc-create}

To set up a new private connection in an existing trunk, create a [new support request]({{ link-console-support }}/create-ticket).

### Contacting support to set up a new private connection {#prc-ticket}

{% note warning %}

All private connection attribute values in the support request text below are given for indicative purposes only. Each customer should have their own attribute values.

{% endnote %}

Write a support request as follows:
```s
Subject: [CIC] Add a new private connection to an existing trunk.

Request text:
Please add a new private connection to an existing trunk. Connection parameters:
trunk_id: euus5dfgchu23b81d472
vlan_id: 101
ipv4_peering:
  peering_subnet: 192.168.10.0/30
  peer_ip: 192.168.10.1
  yandex_cloud_ip: 192.168.10.2
  peer_bgp_asn: 65001
  #yandex_cloud_bgp_asn: 200350
vpc:
  cloud_id: b1g8dn6s3v2eiid9dbci
  folder_id: b1g28j9359gic3p2gca2
  vpc_net_id: enpdffqsg8r221d7vjq5
  vpc_subnets:
    ru-central1-a: [10.60.192.0/21]
    ru-central1-b: [10.60.200.0/21]
    ru-central1-c: [10.60.208.0/20]
```

Where:

* `trunk_id` is the trunk ID received from the support team at the previous step.
* `vlan_id` is the `VLAN-ID` for the private connection in trunk 802.1Q. This value is selected by the customer and must be different from the `VLAN-ID` values of the private connections previously set up in this trunk.
* `peering_subnet` is a [point-to-point subnet](../../interconnect/concepts/priv-con.md#priv-address) for BGP peering. This value is selected by the customer.
* `peer_ip` is the IP address of the point-to-point (peering) subnet on the customer's equipment. This value is selected by the customer.
* `yandex_cloud_ip` is the IP address of the point-to-point (peering) subnet on the Yandex Cloud equipment. This value is selected by the customer.
* `peer_bgp_asn` is the [BGP ASN](../../interconnect/concepts/priv-con.md#bgp-asn) on the customer's equipment. This value is selected by the customer.
* `cloud_id`, `folder_id`, and `vpc_net_id` indicate the location of the VPC with the resources to connect to within this private connection.
* `vpc_subnets` is a list of IPv4 subnet prefixes grouped by {{ yandex-cloud }} [availability zone](../../overview/concepts/geo-scope.md). The resources in these subnets will only be accessible via this private connection. These prefixes will be announced over BGP by the {{ yandex-cloud }} equipment in the direction towards the customer's equipment.


### Support team's response to the customer's request {#prc-ticket-resp}

Once you complete the required actions for setting up a private connection, the support team will provide the customer with the ID of the created private connection.

Here is how the support team may respond to the request for creating a private connection (this sample is provided for informational purposes only):
```s
id: cf3qdug4fsf737g2gpdu
```

Where `id` is the ID of the created private connection.

### Monitoring the status of a private connection {#prc-check}

* Use the [monitoring](../../interconnect/concepts/monitoring.md#private-mon) service to, on your own, monitor when the private connection's BGP session on the {{ yandex-cloud }} equipment switches to the running status.
* The support team will notify you when they finish configuring BGP announcements for the subnet prefixes you requested. It may take up to two business days to configure BGP announcements.
* You should check the IP connectivity between your equipment and the cloud resources to be accessible through the configured private connection yourself and notify the support team of the check results.
* If there are any IP connectivity issues, contact support so that they may run diagnostics and troubleshooting.
