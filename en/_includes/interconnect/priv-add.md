## Setting up a private connection {#priv-create}

To set up a new private connection in an existing trunk, create a [new support request]({{ link-console-support }}/create-ticket).

### Contacting support to set up a new private connection {#priv-ticket}

{% note warning %}

All private connection attribute values in the support request text below are provided for indicative purposes only. Each customer should have their own attribute values.

{% endnote %}

Write a support request as follows:
```s
Subject: [CIC] Add a new private connection to an existing trunk.

Request text:
Please add a new private connection to an existing trunk.
Connection parameters:

trunk_id: euus5dfgchu23b81d472
vlan_id: 101
ipv4_peering:
  peering_subnet: 192.168.10.0/30
  peer_ip: 192.168.10.1
  cloud_ip: 192.168.10.2
  peer_bgp_asn: 65001
  #cloud_bgp_asn: {{ cic-bgp-asn }}
vpc:
  cloud_id: b1g8dn6s3v2eiid9dbci
  folder_id: b1g28j9359gic3p2gca2
  vpc_net_id: enpdffqsg8r221d7vjq5
  vpc_subnets:
    {{ region-id }}-a: [10.60.192.0/21]
    {{ region-id }}-b: [10.60.200.0/21]
    {{ region-id }}-c: [10.60.208.0/20]
```

Where:

* `trunk_id`: Trunk ID received from the support team at the previous step.
* vlan_id` `: `VLAN-ID` for the private connection in trunk 802.1Q. This value is selected by the customer. It must be different from the `VLAN-ID` values of the private connections previously set up in this trunk.
* `peering_subnet`: [Point-to-point subnet](../../interconnect/concepts/priv-con.md#priv-address) for BGP peering, This value is selected by the customer.
* `peer_ip`: IP address of the point-to-point (peering) subnet on the customer's equipment. This value is selected by the customer.
* `cloud_ip`: IP address of the point-to-point (peering) subnet on the {{ yandex-cloud }} equipment. This value is selected by the customer.
* `peer_bgp_asn`: [BGP ASN](../../interconnect/concepts/priv-con.md#bgp-asn) on the customer's equipment. This value is selected by the customer.
* `cloud_id`, `folder_id`, `vpc_net_id`: IDs for the location of the {{ vpc-full-name }} network with resources this private connection can connect to.
* `vpc_subnets`: List of IPv4 subnet prefixes grouped by {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md). The resources in these subnets will only be accessible via this private connection. These prefixes will be announced over BGP by the {{ yandex-cloud }} equipment in the direction towards the customer's equipment.


### Support team's response to the customer's request {#priv-ticket-resp}

Once you complete all required actions for setting up a private connection, the support team will provide the customer with the ID of the created private connection.

Here is how the support team may respond to the request for creating a private connection (this sample is provided for indicative purposes only):
```s
id: cf3qdug4fsf737g2gpdu
```

where `id` is the ID of the created private connection.

### Monitoring the status of a private connection {#priv-check}

* Use the [monitoring service](../../interconnect/concepts/monitoring.md#private-mon) to monitor, on your own, when the private connection BGP session on the {{ yandex-cloud }} equipment switches to the running status.
* The support team will notify you once they finish configuring BGP announcements for the subnet prefixes you requested. It may take up to two business days to configure BGP announcements.
* You should check the IP connectivity between your equipment and the cloud resources to be accessible through the configured private connection yourself and notify the support team of the check results.
* If there are any IP connectivity issues, contact support so that they may run diagnostics and troubleshooting.
