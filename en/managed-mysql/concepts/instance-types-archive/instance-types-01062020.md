# {{ MY }} host classes before June 1, 2020

The host class determines the computing power allocated for each host in the cluster. When you change the host class for a cluster, all existing hosts change to match it.


The available storage doesn't depend on the host class. For storage limitations, see [{#T}](../limits.md).


## Available host classes {#available-flavors}


Hosts in {{ mmy-name }} clusters are deployed on {{ compute-full-name }} VMs. You can create these VMs on any of the platforms that {{ compute-name }} supports. For a detailed description of the platforms, see [{#T}](../../../compute/concepts/vm-platforms.md).
The full list of possible host configurations on each platform is provided below.

{% include [instance-types-code](../../../_includes/mdb/instance-types-code-deprecated-m1.md) %}

| Host class name | Number of vCPUs | CPU performance | RAM, GB |
| ----- | ----- | ----- | ----- |
| **Intel Broadwell** |  |
| b1.nano | 2 | 5% | 2 |
| b1.micro | 2 | 20% | 2 |
| b1.medium | 2 | 50% | 4 |
| m1.micro | 2 | 100% | 16 |
| m1.small | 4 | 100% | 32 |
| m1.medium | 6 | 100% | 48 |
| m1.large | 8 | 100% | 64 |
| m1.xlarge | 12 | 100% | 96 |
| m1.2xlarge | 16 | 100% | 128 |
| m1.3xlarge | 24 | 100% | 192 |
| m1.4xlarge | 32 | 100% | 256 |
| s1.nano | 1 | 100% | 4 |
| s1.micro | 2 | 100% | 8 |
| s1.small | 4 | 100% | 16 |
| s1.medium | 8 | 100% | 32 |
| s1.large | 16 | 100% | 64 |
| s1.xlarge | 32 | 100% | 128 |
| **Intel Cascade Lake** |  |  |
| b2.nano | 2 | 5% | 2 |
| b2.micro | 2 | 20% | 2 |
| b2.medium | 2 | 50% | 4 |
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
