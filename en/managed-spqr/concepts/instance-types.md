---
title: '{{ mspqr-full-name }} host classes'
description: The host class determines the computing power allocated for each host in a {{ mspqr-name }} cluster. If a cluster uses standard sharding, changing the host class updates the properties of all previously created hosts. If a cluster uses advanced sharding, the host class is changed separately for hosts with the ROUTER and COORDINATOR roles. Changing the configuration updates the properties of all previously created hosts.
---

# {{ mspqr-full-name }} host classes

The host class determines the computing power allocated for each host in a {{ mspqr-name }} cluster.

If a cluster uses standard sharding, changing the host class updates the properties of all previously created hosts.

If a cluster uses advanced sharding, the host class is changed separately for hosts with the `ROUTER` and `COORDINATOR` roles. Changing the configuration updates the properties of all previously created hosts.

## Available host classes {#available-flavors}

Hosts in {{ mspqr-name }} clusters are deployed on {{ compute-full-name }} VMs. You can create these VMs on any platforms {{ compute-name }} supports. To learn more about the platforms, see [this article](../../compute/concepts/vm-platforms.md).

The full list of possible host configurations on each platform is provided below. All configurations support two disk types: `network-ssd` and `network-hdd`.

The storage size does not depend on the host class.

{% note info %}

AMD Zen 3 is available to a limited number of users for private testing at the [Preview](../../overview/concepts/launch-stages.md) stage and is not free of charge. To request access to the platform, contact your account manager.

Intel Broadwell is not available for clusters with hosts residing in the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).

{% endnote %}

Configuration types:

* **s1**, **s2**, **s3**, and **s4a**: Standard configurations with a 4:1 RAM GB to vCPU ratio.
* **m2**, **m3**, and **m4a**: Configurations with an increased RAM GB to vCPU ratio (8:1). These configurations may be useful for clusters with higher cache requirements.
* **c3** and **c4a**: Configurations with a reduced RAM GB to vCPU ratio (2:1). These configurations may be useful for clusters with higher processor performance requirements.
* **b1**, **b2**, **b3**: Configurations with a guaranteed vCPU share under 100%. This host class is intended for test load, while the minimum recommended host configuration for production solutions is two vCPUs with a guaranteed share of 50%.

  {% note info %}

  Hosts with a guaranteed vCPU share under 50% cannot be used in multi-host clusters.

  {% endnote %}

| Host class name   | Number of CPUs | CPU performance        | RAM, GB | Disk <br>size, GB    |
|-------------------|----------------|------------------------|---------|----------------------|
| **Intel Broadwell**                                                                          |
| b1.medium         | 2              | 50%                    | 4       | 10–512               |
| s1.micro          | 2              | 100%                   | 8       | 10–512               |
| s1.small          | 4              | 100%                   | 16      | 10–512               |
| s1.medium         | 8              | 100%                   | 32      | 10–512               |
| s1.large          | 16             | 100%                   | 64      | 10–512               |
| s1.xlarge         | 32             | 100%                   | 128     | 10–512               |
| **Intel Cascade Lake**                                                                       |
| b2.medium         | 2              | 50%                    | 4       | 10–512               |
| m2.micro          | 2              | 100%                   | 16      | 10–512               |
| m2.small          | 4              | 100%                   | 32      | 10–512               |
| m2.medium         | 6              | 100%                   | 48      | 10–512               |
| m2.large          | 8              | 100%                   | 64      | 10–512               |
| m2.xlarge         | 12             | 100%                   | 96      | 10–512               |
| m2.2xlarge        | 16             | 100%                   | 128     | 10–512               |
| m2.3xlarge        | 24             | 100%                   | 192     | 10–512               |
| m2.4xlarge        | 32             | 100%                   | 256     | 10–512               |
| m2.5xlarge        | 40             | 100%                   | 320     | 10–512               |
| m2.6xlarge        | 48             | 100%                   | 384     | 10–512               |
| m2.7xlarge        | 56             | 100%                   | 448     | 10–512               |
| m2.8xlarge        | 64             | 100%                   | 512     | 10–512               |
| s2.micro          | 2              | 100%                   | 8       | 10–512               |
| s2.small          | 4              | 100%                   | 16      | 10–512               |
| s2.medium         | 8              | 100%                   | 32      | 10–512               |
| s2.large          | 12             | 100%                   | 48      | 10–512               |
| s2.xlarge         | 16             | 100%                   | 64      | 10–512               |
| s2.2xlarge        | 24             | 100%                   | 96      | 10–512               |
| s2.3xlarge        | 32             | 100%                   | 128     | 10–512               |
| s2.4xlarge        | 40             | 100%                   | 160     | 10–512               |
| s2.5xlarge        | 48             | 100%                   | 192     | 10–512               |
| s2.6xlarge        | 64             | 100%                   | 256     | 10–512               |
| **Intel Ice Lake**                                                                           |
| b3-c1-m4          | 2              | 50%                    | 4       | 10–512               |
| s3-c2-m8          | 2              | 100%                   | 8       | 10–512               |
| s3-c4-m16         | 4              | 100%                   | 16      | 10–512               |
| s3-c8-m32         | 8              | 100%                   | 32      | 10–512               |
| s3-c12-m48        | 12             | 100%                   | 48      | 10–512               |
| s3-c16-m64        | 16             | 100%                   | 64      | 10–512               |
| s3-c24-m96        | 24             | 100%                   | 96      | 10–512               |
| s3-c32-m128       | 32             | 100%                   | 128     | 10–512               |
| s3-c40-m160       | 40             | 100%                   | 160     | 10–512               |
| s3-c48-m192       | 48             | 100%                   | 192     | 10–512               |
| s3-c64-m256       | 64             | 100%                   | 256     | 10–512               |
| s3-c80-m320       | 80             | 100%                   | 320     | 10–512               |
| m3-c2-m16         | 2              | 100%                   | 16      | 10–512               |
| m3-c4-m32         | 4              | 100%                   | 32      | 10–512               |
| m3-c6-m48         | 6              | 100%                   | 48      | 10–512               |
| m3-c8-m64         | 8              | 100%                   | 64      | 10–512               |
| m3-c12-m96        | 12             | 100%                   | 96      | 10–512               |
| m3-c16-m128       | 16             | 100%                   | 128     | 10–512               |
| m3-c24-m192       | 24             | 100%                   | 192     | 10–512               |
| m3-c32-m256       | 32             | 100%                   | 256     | 10–512               |
| m3-c40-m320       | 40             | 100%                   | 320     | 10–512               |
| c3-c2-m4          | 2              | 100%                   | 4       | 10–512               |
| c3-c4-m8          | 4              | 100%                   | 8       | 10–512               |
| c3-c8-m16         | 8              | 100%                   | 16      | 10–512               |
| c3-c12-m24        | 12             | 100%                   | 24      | 10–512               |
| c3-c16-m32        | 16             | 100%                   | 32      | 10–512               |
| c3-c24-m48        | 24             | 100%                   | 48      | 10–512               |
| c3-c32-m64        | 32             | 100%                   | 64      | 10–512               |
| c3-c40-m80        | 40             | 100%                   | 80      | 10–512               |
| c3-c48-m96        | 48             | 100%                   | 96      | 10–512               |
| c3-c64-m128       | 64             | 100%                   | 128     | 10–512               |
| c3-c80-m160       | 80             | 100%                   | 160     | 10–512               |
| c3-c96-m192       | 96             | 100%                   | 192     | 10–512               |
| **AMD Zen 3**                                                                                |
| s4a-c2-m8         | 2              | 100%                   | 8       | 10–512               |
| s4a-c4-m16        | 4              | 100%                   | 16      | 10–512               |
| s4a-c8-m32        | 8              | 100%                   | 32      | 10–512               |
| s4a-c12-m48       | 12             | 100%                   | 48      | 10–512               |
| s4a-c16-m64       | 16             | 100%                   | 64      | 10–512               |
| s4a-c24-m96       | 24             | 100%                   | 96      | 10–512               |
| s4a-c32-128       | 32             | 100%                   | 128     | 10–512               |
| s4a-c40-m160      | 40             | 100%                   | 160     | 10–512               |
| s4a-c48-192       | 48             | 100%                   | 192     | 10–512               |
| s4a-c64-m256      | 64             | 100%                   | 256     | 10–512               |
| s4a-c80-320       | 80             | 100%                   | 320     | 10–512               |
| s4a-c96-m576      | 96             | 100%                   | 576     | 10–512               |
| m4a-c2-m16        | 2              | 100%                   | 16      | 10–512               |
| m4a-c4-m32        | 4              | 100%                   | 32      | 10–512               |
| m4a-c6-m48        | 6              | 100%                   | 48      | 10–512               |
| m4a-c8-m64        | 8              | 100%                   | 64      | 10–512               |
| m4a-c12-m96       | 12             | 100%                   | 96      | 10–512               |
| m4a-c16-m128      | 16             | 100%                   | 128     | 10–512               |
| m4a-c24-m192      | 24             | 100%                   | 192     | 10–512               |
| m4a-c32-m256      | 32             | 100%                   | 256     | 10–512               |
| m4a-c40-m320      | 40             | 100%                   | 320     | 10–512               |
| m4a-c48-m384      | 48             | 100%                   | 384     | 10–512               |
| m4a-c56-448       | 56             | 100%                   | 448     | 10–512               |
| m4a-c64-m512      | 64             | 100%                   | 512     | 10–512               |
| m4a-c80-m640      | 80             | 100%                   | 640     | 10–512               |
| c4a-c2-m4         | 2              | 100%                   | 4       | 10–512               |
| c4a-c4-m8         | 4              | 100%                   | 8       | 10–512               |
| c4a-c8-m16        | 8              | 100%                   | 16      | 10–512               |
| c4a-c12-m24       | 12             | 100%                   | 24      | 10–512               |
| c4a-c16-m32       | 16             | 100%                   | 32      | 10–512               |
| c4a-c24-m48       | 24             | 100%                   | 48      | 10–512               |
| c4a-c32-m64       | 32             | 100%                   | 64      | 10–512               |
| c4a-c40-m80       | 40             | 100%                   | 80      | 10–512               |
| c4a-c48-m96       | 48             | 100%                   | 96      | 10–512               |
| c4a-c64-m128      | 64             | 100%                   | 128     | 10–512               |
| c4a-c80-m160      | 80             | 100%                   | 160     | 10–512               |
| c4a-c96-m192      | 96             | 100%                   | 192     | 10–512               |