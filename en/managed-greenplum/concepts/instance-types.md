---
title: '{{ GP }} host classes'
description: In this article, you will learn about {{ GP }} host classes.
---

# {{ GP }} host classes


The host class determines the computing power allocated for each host in a cluster. In a {{ mgp-name }} cluster, the classes of master hosts and segment hosts may differ. For information on how to select host classes, see [Calculating the cluster configuration](../concepts/calculate-specs.md).


For master hosts, the host class determines which [disk types](./storage.md) are available:

* **s2**, **i2**: `local-ssd`, `network-ssd-nonreplicated`.
* **s3**, **i3**: `network-ssd`, `network-hdd`, `local-ssd`, `network-ssd-nonreplicated`, `network-ssd-io-m3`.

For segment hosts, the following disk types are available:

* `local-ssd`
* `network-ssd-nonreplicated`
* `network-ssd-io-m3`

The available storage size does not depend on the host class. For storage limitations, see [Quotas and limits](limits.md).

## Available host classes {#available-flavors}


{{ mgp-name }} cluster hosts are deployed on {{ compute-full-name }} virtual machines on Intel Cascade Lake and Intel Ice Lake [platforms](../../compute/concepts/vm-platforms.md) with a guaranteed vCPU share of 100%. The full list of possible host configurations is provided below.

{% include [zone-d-disk-restrictions](../../_includes/mdb/ru-central1-d-local-ssd.md) %}

Configuration types:

{% include [instance-types-code](../../_includes/mdb/mgp-instance-types-code.md) %}

| Host class name | Number of vCPUs | vCPU performance | RAM, GB | Disk <br>size, GB |
|-------------------|----------------:|:-----------------------:|--------:|----------------------|
| **Intel Cascade Lake**                                                                         |
| s2.medium         |               8 | 100%                    |      32 | 93 - 8184            |
| s2.large          |              12 | 100%                    |      48 | 93 - 8184            |
| i2.2xlarge        |              16 | 100%                    |     128 | 93 - 8184            |
| i2.4xlarge        |              32 | 100%                    |     256 | 93 - 8184            |
| i2.5xlarge        |              40 | 100%                    |     320 | 93 - 8184            |
| **Intel Ice Lake**                                                                             |
| s3-c8-m32         |               8 | 100%                    |      32 | 10 - 8192            |
| s3-c12-m48        |              12 | 100%                    |      48 | 10 - 8192            |
| i3-c16-m128       |              16 | 100%                    |     128 | 10 - 8192            |
| i3-c32-m256       |              32 | 100%                    |     256 | 10 - 8192            |
| i3-c40-m320       |              40 | 100%                    |     320 | 10 - 8192            |



## Using dedicated hosts {#dedicated-hosts}

You can use [dedicated hosts](../../compute/concepts/dedicated-host.md) for your master hosts, segment hosts, or all your cluster's hosts at the same time. In which case the cluster's hosts will reside on dedicated hosts from the group you select.

A cluster on dedicated hosts will have the following available to it:

* Configurations of the [platform](../../compute/concepts/vm-platforms.md) the group's dedicated hosts were created on.
* The whole [local disk](../../compute/concepts/dedicated-host.md#host-types-list) (`local-ssd`) volume of the dedicated host. The maximum storage size per host is greater than if standard VMs are used. 

Network drives are also available on dedicated hosts.


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
