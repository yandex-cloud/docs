## Setting up a public connection {#pub-create}

To add a public connection to an existing trunk, create a [new support ticket]({{ link-console-support }}).

### Contacting support for a public connection {#pub-ticket}

Follow this request format:
```s
Subject: [CIC] Add a public connection to an existing trunk.

Request text:
Please add a public connection to an existing trunk.
Connection settings:

trunk_id: euus5dfgchu2********
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
* `vlan_id`: Public trunk connection 802.1Q `VLAN-ID`. This value is selected by the customer. It must be different from the `VLAN-ID` values of other private connections in this trunk.
* `peer_bgp_asn`: Customer endpoint [BGP ASN](../../interconnect/concepts/priv-con.md#bgp-asn) in ASPlain format. This value is selected by the customer.
* `allowed-public-services`: `FQDN API Endpoints` of [services](../../interconnect/concepts/pub-con.md#svc-list) you want to access through this public connection.
* `is_nat_extra_ip_required`: Indicates whether the customer needs a `/32` subnet prefix (in addition to the point-to-point `/31` subnet prefix) to implement [NAT](../../interconnect/concepts/pub-con.md#svc-nat). By default, this value is `false`, which means no additional subnet prefix is allocated.
* `folder_id` (optional): Folder to store public connection monitoring metrics. If left empty, monitoring metrics will be stored in the folder you specified when creating the trunk.

### Support team's response to your ticket {#pub-ticket-resp}

Once the new public connection has been added, the support team will message you its ID.

Here is an example of the support response to a request for a new public connection (for reference only):
```s
id: cf3qdug4fsf7********
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

* `id`: Public connection ID.
* `peering_subnet`: [Point-to-point](../../interconnect/concepts/pub-con.md#pub-address) BGP peering subnet prefix from the {{ yandex-cloud }} [address pool](../../vpc/concepts/ips.md).
* `peer_ip`: Customer endpoint IP address on the point to point BGP peering subnet assigned by {{ yandex-cloud }}.
* `cloud_ip`: {{ yandex-cloud }} endpoint on the point to point BGP peering subnet assigned by {{ yandex-cloud }}.
* `nat_subnet`: Additional {{ yandex-cloud }} pool subnet prefix to implement [NAT](../../interconnect/concepts/pub-con.md#pub-nat).
* `allowed-public-services`: `FQDN API Endpoints` of services accessible through the new public connection.

### Public connection status monitoring {#pub-check}

* Use the [monitoring](../../interconnect/concepts/monitoring.md#private-mon) service to see when your public connection BGP session starts on the {{ yandex-cloud }} endpoint.
* The support team will notify you once they provide access to the requested {{ yandex-cloud }} services. The configuration process usually takes up to one business day.
* Check whether the {{ yandex-cloud }} services are accessible from your endpoint through the new public connection and inform the support team about the results.
* If there are any IP connectivity issues, contact support for diagnostics and troubleshooting.

