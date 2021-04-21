# Host classes

The host class determines the computing power allocated for each host with the specific role in the cluster. When you change the host class for a role in the cluster, the characteristics change for all of the hosts with this role that were created earlier in the cluster. To learn more about roles, see [{#T}](index.md).


The available storage doesn't depend on the host class. For storage limitations, see [{#T}](limits.md).

## Available host classes {#available-flavors}

Hosts in {{ mes-name }} clusters are deployed on {{ compute-full-name }} VMs. You can create these VMs on any standard platform that {{ compute-name }} supports. For a detailed description of the platforms, see [{#T}](../../compute/concepts/vm-platforms.md).

The full list of possible host configurations on each platform is provided below.

Configuration types:

* **s2**: Standard configurations, with 4:1 GB RAM to vCPU ratio.
* **m2**: Configurations with an increased GB RAM to vCPU ratio (8:1). These configurations can be useful for clusters with increased cache requirements.

| Host class name | Number of vCPUs | Guaranteed vCPU performance | RAM, GB |
| ----- | ----- | ----- | ----- |
| **Intel Cascade Lake** |  |  |
| m2.micro | 2 | 100% | 16 |
| m2.small | 4 | 100% | 32 |
| m2.medium | 6 | 100% | 48 |
| m2.large | 8 | 100% | 64 |
| m2.xlarge | 12 | 100% | 96 |
| m2.2xlarge | 16 | 100% | 128 |
| m2.3xlarge | 24 | 100% | 192 |
| m2.4xlarge | 32 | 100% | 256 |
| m2.5xlarge | 40 | 100% | 320 |
| m2.6xlarge | 48 | 100% | 384 |
| m2.7xlarge | 56 | 100% | 448 |
| m2.8xlarge | 64 | 100% | 512 |
| s2.micro | 2 | 100% | 8 |
| s2.small | 4 | 100% | 16 |
| s2.medium | 8 | 100% | 32 |
| s2.large | 12 | 100% | 48 |
| s2.xlarge | 16 | 100% | 64 |
| s2.2xlarge | 24 | 100% | 96 |
| s2.3xlarge | 32 | 100% | 128 |
| s2.4xlarge | 40 | 100% | 160 |
| s2.5xlarge | 48 | 100% | 192 |
| s2.6xlarge | 64 | 100% | 256 |

