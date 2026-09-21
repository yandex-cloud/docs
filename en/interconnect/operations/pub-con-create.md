---
title: How to create a public connection in a {{ interconnect-name }} trunk
description: Follow this guide to create a public connection in a {{ interconnect-name }} trunk.
---

# Creating a public connection

Currently, you can only create a public connection by contacting support.

Before you create a connection, [get information](trunk-get-info.md) about the trunk, save its ID, and make sure the physical port is operational.

Create a [support ticket]({{ link-console-support }}) with the following content:

```text
Subject: [CIC] Creating a public connection.

Please create a public connection in our trunk.

trunk_id: euus5dfgchu2********
folder_id: b1g28j9359gi********
vlan_id: 101
ipv4_peering:
  peer_bgp_asn: 65001
allowed-public-services:
  - {{ s3-storage-host }}
  - transcribe.{{ api-host }}
is_nat_extra_ip_required: false
```

Where:

* `trunk_id`: Trunk ID.
* `vlan_id`: VLAN ID for the public connection, unique within the trunk.
* `peer_bgp_asn`: BGP ASN on your network equipment in ASPlain format.
* `allowed-public-services`: List of [service endpoints](../concepts/pub-con.md#svc-list) you need access to.
* `is_nat_extra_ip_required`: Specify whether you need an additional `/32` prefix for [NAT](../concepts/pub-con.md#pub-nat).
* `folder_id`: ID of the folder to write metrics to. This is an optional parameter. If not specified, the trunk folder will be used.

After the connection is created, support will give you its ID and BGP peering settings. Configure BGP on your network equipment, [check the BGP session status](../concepts/monitoring.md#private-mon), and check the selected services for availability.
