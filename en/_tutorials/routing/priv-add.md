## Setting up a private connection {#priv-create}

To add a private connection to an existing trunk, create a [new support ticket]({{ link-console-support }}).

### Contacting support for a new private connection {#priv-ticket}

Follow this request format:




Where:

* `trunk_id`: Trunk ID you got from support in the previous step.
* `vlan_id`: Private trunk connection 802.1Q `VLAN-ID`. This value is selected by the customer. It must be different from `VLAN-ID` values of other private connections in this trunk.
* `peering_subnet`: [Point-to-point subnet](../../interconnect/concepts/priv-con.md#priv-address) for BGP peering. This value is selected by the customer.
* `peer_ip`: Customer endpoint IP address on the point to point BGP peering subnet. This value is selected by the customer.
* `cloud_ip`: {{ yandex-cloud }} endpoint IP address on the point-to-point BGP peering subnet. This value is selected by the customer.
* `peer_bgp_asn`: Customer endpoint [BGP ASN](../../interconnect/concepts/priv-con.md#bgp-asn) in ASPlain format. This value is selected by the customer.
* `vpc_net_id`: ID of the {{ vpc-full-name }} network for a private connection.
* `vpc_subnets`: List of IPv4 subnet prefixes grouped by {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md). The resources in these subnets will only be accessible through your private connection. These prefixes will be announced over BGP from {{ yandex-cloud }} to the customer endpoint.
* Optionally, `folder_id`: By default, private connection monitoring metrics will be saved to the folder specified when creating the trunk. If required, you can explicitly specify the folder to save private connection monitoring metrics to.

### Support team's response to your ticket {#priv-ticket-resp}

Once the new private connection has been added, the support team will message you its ID

Here is an example of the support response to the request for a new private connection (for reference only):
```s
A new private connection has been successfully added to the trunk.
Connection ID: cf3qdug4fsf7********
```

### Private connection status monitoring {#priv-check}

* Use the [monitoring service](../../interconnect/concepts/monitoring.md#private-mon) to see when your private connection BGP session starts on the {{ yandex-cloud }} endpoint.
* The support team will notify you once they finish configuring BGP announcements for the subnet prefixes you requested. It may take up to two business days to configure BGP announcements.
* Check whether the cloud resources are accessible from your endpoint through the new private connection and inform the support team about the results.
* If there are any IP connectivity issues, contact support for diagnostics and troubleshooting.

