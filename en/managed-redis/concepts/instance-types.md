# Host classes

Host class needs to be defined to create each cluster. The class defines computing power, that should be allocated for each DB host. When a cluster's host class is changed, it is changed for all hosts of the cluster.

For  [!KEYREF mrd-name] host classes are defined by the type of CPU usage and RAM volume:

* For small datasets and loads you can create clusters with low performance guarantee (`burstable`), like [light virtual machines](../../compute/concepts/vm-types.md#light-vms).
* For big loads, or high performance requirements use standard hosts (`high-memory`).

> [!NOTE]
>
> Memory set for a host also defines the `maxmemory` configuration parameter: maximum data volume equals 75% of available RAM. For example, host with 8 GB of RAM would have `maxmemroy` set to 6 GB.

Disk volume available to a host must be at least twice as large as available RAM volume. Technical and organizational restrictions of [!KEYREF mrd-name] are described in the [[!TITLE]](limits.md) section.

## Available host classes {#available-flavors}

Host class | Cluster type | RAM, GB
----- | ----- | -----
b1.nano | `burstable` | 2
b1.small | `burstable` | 4
hm1.nano | `high-memory` | 8
hm1.micro | `high-memory` | 12
hm1.small | `high-memory` | 16
hm1.medium | `high-memory` | 24
hm1.large | `high-memory` | 32
hm1.xlarge | `high-memory` | 48
hm1.2xlarge | `high-memory` | 64
hm1.3xlarge | `high-memory` | 80
hm1.4xlarge | `high-memory` | 96
hm1.5xlarge | `high-memory` | 128
hm1.6xlarge | `high-memory` | 160
hm1.7xlarge | `high-memory` | 192
hm1.8xlarge | `high-memory` | 224
hm1.9xlarge | `high-memory` | 256
