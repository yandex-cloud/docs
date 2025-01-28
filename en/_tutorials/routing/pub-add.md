## Setting up a public connection {#pub-create}

To establish a new public connection in an existing trunk, create a [new support request]({{ link-console-support }}).

### Contacting support for a public connection {#pub-ticket}

Follow this request format:
```s
Subject: [CIC] Add a public connection to an existing trunk.

Request text:
Please add a public connection to an existing trunk.
Connection parameters:

trunk_id: euus5dfgchu23b******
vlan_id: 101
ipv4_peering:
  peer_bgp_asn: 65001
  #cloud_bgp_asn: {{ cic-bgp-asn }}
allowed-public-services:
  - {{ s3-storage-host }}
  - transcribe.{{ api-host }}
is_nat_extra_ip_required: false
```

Where:

* `trunk_id`: Trunk ID you got from support in the previous step.
* `vlan_id`: `VLAN-ID` for this public connection in trunk 802.1Q. This value is selected by the customer. It must be different from the `VLAN-ID` values of the private connections previously set up in this trunk.
* `peer_bgp_asn`: [BGP ASN](../../interconnect/concepts/priv-con.md#bgp-asn) on the customer's equipment in ASPlain format. This value is selected by the customer.
* `allowed-public-services`: List of `FQDN API Endpoint` for the services [from the table](../../interconnect/concepts/pub-con.md#svc-list) to provide access to via this public connection.
* `is_nat_extra_ip_required`: Indicates whether the customer needs an additional `/32` service address (prefix) apart from the point-to-point `/31` subnet to implement [NAT functions](../../interconnect/concepts/pub-con.md#svc-nat). By default, no additional service prefix is allocated (the value is `false`).
* `folder_id` (optional): By default, public connection monitoring metrics will be saved to the folder specified when creating a trunk. If required, you can explicitly specify the folder to save the public connection monitoring metrics to.

### Support team's response to the customer's request {#pub-ticket-resp}

Once all the actions required to set to set up a public connection are completed, the support team provides the customer with the ID of the connection created.

Here is an example of support's response when requested to create a public connection (for information):
```s
id: cf3qdug4fsf737******
ipv4_peering:
  peering_subnet: {{ cic-pbc-subnet }}
  peer_ip: {{ cic-pbc-subnet-client }}
  cloud_ip: {{ cic-pbc-subnet-cloud }}
  peer_bgp_asn: 65001
  #cloud_bgp_asn: {{ cic-bgp-asn }}
allowed-public-services:
  - {{ s3-storage-host }}
  - transcribe.{{ api-host }}
```
Where:

* `id`: ID of the new public connection.
* `peering_subnet`: [Point-to-point subnet](../../interconnect/concepts/pub-con.md#pub-address) for BGP peering. which is allocated from the {{ yandex-cloud }} [address pool](../../vpc/concepts/ips.md).
* `peer_ip`: IP address of the point-to-point (peer) subnet on the customer's equipment. It is assigned by {{ yandex-cloud }}.
* `cloud_ip`: IP address of the point-to-point (peer) subnet on the {{ yandex-cloud }} equipment. It is assigned by {{ yandex-cloud }}.
* `nat_subnet`: Additional subnet allocated from the {{ yandex-cloud }} address pool to implement [NAT functions](../../interconnect/concepts/pub-con.md#pub-nat).
* `allowed-public-services`: List of `FQDN API Endpoints` from the customer request for the services access was provided to via the created public connection.

### Monitoring the status of a public connection {#pub-check}

* Use the [monitoring](../../interconnect/concepts/monitoring.md#private-mon) service to monitor, on your own, when the public connection BGP session on the {{ yandex-cloud }} equipment switches to the running status.
* The support team will notify you once they finish configuring access to the requested {{ yandex-cloud }} services. The configuration process usually takes up to one business day.
* Make sure to check the IP connectivity between your equipment and the {{ yandex-cloud }} services to be accessed over the configured public connection, and notify the support team of the check results.
* If there are any IP connectivity issues, contact support for diagnostics and troubleshooting.

