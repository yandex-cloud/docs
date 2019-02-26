# Host classes

A host class must be selected when creating each cluster. The class determines the computing power to be allocated for each DB host in the cluster.

> [!NOTE]
>
> The amount of memory allocated to a host is also determined by the `maxmemory` configuration parameter for Redis hosts: the max amount of data is 75% of the available memory. For example, for a host class with 8 GB RAM, the `maxmemory` value will be 6 GB.

The available storage does not depend on the host class.  For storage limitations, see the section [[!TITLE]](limits.md).

## Available host classes {#available-flavors}

If you change the host class, the characteristics of all hosts in the cluster change, too.

| Host class name | Number of vCPUs | RAM, GB |
| ----- | ----- | ----- |
| m1.nano | 1 | 8 |
| m1.micro | 2 | 16 |
| m1.small | 4 | 32 |
| m1.medium | 8 | 64 |
| m1.large | 16 | 128 |
| m1.xlarge | 32 | 256 |

