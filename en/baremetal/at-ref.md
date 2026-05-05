---
title: '{{ baremetal-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ baremetal-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) (management) and [data plane](../audit-trails/concepts/format-data-plane.md) (data) events for {{ baremetal-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.baremetal.<event_name>
```

{% include [about-events-ref](../_includes/audit-trails/about-events-ref.md) %}

## Management event reference {#control-plane-events}

{% include [baremetal-events](../_includes/audit-trails/events/baremetal-events.md) %}

## Data event reference {#data-plane-events}

{% include [compute-events-dp](../_includes/audit-trails/events/baremetal-events-dp.md) %}

### flowlogs.ExternalFlow event {#external-flow}

The `flowlogs.ExternalFlow` event contains aggregate information about {{ baremetal-name }} server traffic streams to external networks.

{% note warning %}

`ExternalFlow` events are sampled from every 1,000th packet and aggregated for a five-minute interval.

{% endnote %}

The `details` object of a `flowlogs.ExternalFlow` event contains the following fields:

#|
|| Field | Type | Description ||
|| `vers` | int64 | IP version: `4` for IPv4 or `6` for IPv6 ||
|| `proto` | int64 | Transport protocol [IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml) number, e.g., `6` for TCP or `17` for UDP ||
|| `srcAddr` | string | Source IP address ||
|| `dstAddr` | string | Destination IP address ||
|| `direction` | string | Traffic direction, with `INGRESS` for incoming traffic and `EGRESS` for outgoing traffic ||
|| `srcPort` | int64 | Source port ||
|| `dstPort` | int64 | Destination port ||
|| `aggStart` | timestamp | Aggregation period start time in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format ||
|| `aggEnd` | timestamp | Aggregation period end time in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format ||
|| `packets` | int64 | Number of packets for the aggregation period ||
|| `bytes` | int64 | Number of bytes for the aggregation period ||
|| `tcpFlags` | string | TCP flags in hex format, e.g., `0x02` ||
|| `subnetId` | string | Subnet ID ||
|| `folderId` | string | Folder ID ||
|#
