## Establishing a private connection {#priv-create}

To establish a new private connection in an existing trunk, create a [new support request]({{ link-console-support }}).

### Contacting support for a new private connection {#priv-ticket}

Follow this request format:
```s
Subject: [CIC] Add a new private connection to an existing trunk.

Request text:
Please add a new private connection to an existing trunk.
Connection parameters:

trunk_id: euus5dfgchu2********
vlan_id: 101
ipv4_peering:
  peering_subnet: 192.168.10.0/30
  peer_ip: 192.168.10.1
  cloud_ip: 192.168.10.2
  peer_bgp_asn: 65001
  #cloud_bgp_asn: {{ cic-bgp-asn }}
vpc:
  vpc_net_id: enpdffqsg8r2********
    vpc_subnets:
      {{ region-id }}-a: [10.60.192.0/21]
      {{ region-id }}-b: [10.60.200.0/21, 10.60.220.0/24]
      {{ region-id }}-d: [10.60.208.0/20]
```

Where:

* `trunk_id`: Trunk ID you got from support in the previous step.
* `vlan_id`: `VLAN-ID` for this private connection in trunk 802.1Q. This value is selected by the customer. It must be different from the `VLAN-ID` values of the private connections previously set up in this trunk.
* `peering_subnet`: [Point-to-point subnet](../../interconnect/concepts/priv-con.md#priv-address) for BGP peering. This value is selected by the customer.
* `peer_ip`: IP address of the point-to-point (peered) subnet on the customer's equipment. This value is selected by the customer.
* `cloud_ip`: IP address of the point-to-point (peered) subnet on the {{ yandex-cloud }} equipment. This value is selected by the customer.
* `peer_bgp_asn`: [BGP ASN](../../interconnect/concepts/priv-con.md#bgp-asn) on the customer's equipment in ASPlain format. This value is selected by the customer.
* `vpc_net_id`: ID of the {{ vpc-full-name }} network for a private connection.
* `vpc_subnets`: List of IPv4 subnet prefixes grouped by {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md). The resources in these subnets will only be accessible via this private connection. These prefixes will be announced over BGP by the {{ yandex-cloud }} equipment in the direction towards the customer's equipment.
* `folder_id` (optional): By default, private connection monitoring metrics will be saved to the folder specified when creating the trunk. If required, you can explicitly specify the folder to save private connection monitoring metrics to.

### Support team's response to the customer's request {#priv-ticket-resp}

Once you complete all required actions for setting up a private connection, the support team will provide the customer with the ID of the created private connection.

Here is an example of support's response when requested to create a private connection (for information):
```s
Adding a private connection to the trunk completed successfully.
Connection ID: cf3qdug4fsf7********
```

### Monitoring the status of a private connection {#priv-check}

* Use the [monitoring service](../../interconnect/concepts/monitoring.md#private-mon) to monitor, on your own, when the private connection BGP session on the {{ yandex-cloud }} equipment switches to the running status.
* The support team will notify you once they finish configuring BGP announcements for the subnet prefixes you requested. It may take up to two business days to configure BGP announcements.
* You should check the IP connectivity between your equipment and the cloud resources to be accessible through the configured private connection yourself and notify the support team of the check results.
* If there are any IP connectivity issues, contact support for diagnostics and troubleshooting.

