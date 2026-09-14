---
title: '{{ OS }} host classes'
description: In this article, you will learn about {{ OS }} host classes.
---

# {{ OS }} host classes


The host class determines the computing power allocated for each host group with a specific role in the cluster. When you change the host class for a host group in the cluster, the configuration of all hosts previously created in this group changes accordingly. For more information about host groups, see [Host roles](./host-roles.md).


The available storage size does not depend on the host class. For storage limitations, see [Quotas and limits](limits.md).


## Available host classes {#available-flavors}

Hosts in {{ mos-name }} clusters are deployed on {{ compute-full-name }} VMs. You can create these VMs on any standard platform supported by {{ compute-name }}. To learn more about the platforms, see [{#T}](../../compute/concepts/vm-platforms.md).

The full list of possible host group configurations on each platform is provided below.

{% include [disk-flavor-dependencies](../../_includes/mdb/disk-flavor-dependencies.md) %}

For example, `{{ region-id }}-d` does not support Intel Broadwell and local SSD storage if Intel Cascade Lake is used.

Configuration types:



* **s2**, **s3**, **s4a**, **s4af**: Standard configurations with a 4:1 RAM GB to vCPU ratio.
* **m2**, **m3**, **m4a**, **m4af**: Configurations with an increased RAM GB to vCPU ratio (8:1). These configurations are well suited for clusters with high cache requirements.
* **b3**: Configuration with a guaranteed vCPU share under 100%. This host class is intended for test workloads. The minimum recommended host configuration for production solutions is two vCPUs with a guaranteed share of 50%.
* **c3**, **c4a**, **c4af**: Configurations with a reduced RAM GB to vCPU ratio (2:1). These configurations may be useful for clusters with higher processor performance requirements.

{% include [note-burstable-deprecated](../../_includes/mdb/note-burstable-deprecated.md) %}

| Host class name | Number of vCPUs | Guaranteed<br>vCPU share | RAM, GB | Disk<br>size, GB |
|-------------------|-----------------|---------------------------|---------|----------------------|
| **Intel Cascade Lake**                                                                           |
| m2.micro          | 2               | 100%                      | 16      | 10 - 8,184            |
| m2.small          | 4               | 100%                      | 32      | 10 - 8,184            |
| m2.medium         | 6               | 100%                      | 48      | 10 - 8,184            |
| m2.large          | 8               | 100%                      | 64      | 10 - 8,184            |
| m2.xlarge         | 12              | 100%                      | 96      | 10 - 8,184            |
| m2.2xlarge        | 16              | 100%                      | 128     | 10 - 8,184            |
| m2.3xlarge        | 24              | 100%                      | 192     | 10 - 8,184            |
| m2.4xlarge        | 32              | 100%                      | 256     | 10 - 8,184            |
| m2.5xlarge        | 40              | 100%                      | 320     | 10 - 8,184            |
| m2.6xlarge        | 48              | 100%                      | 384     | 10 - 8,184            |
| m2.7xlarge        | 56              | 100%                      | 448     | 10 - 8,184            |
| m2.8xlarge        | 64              | 100%                      | 512     | 10 - 8,184            |
| s2.micro          | 2               | 100%                      | 8       | 10 - 8,184            |
| s2.small          | 4               | 100%                      | 16      | 10 - 8,184            |
| s2.medium         | 8               | 100%                      | 32      | 10 - 8,184            |
| s2.large          | 12              | 100%                      | 48      | 10 - 8,184            |
| s2.xlarge         | 16              | 100%                      | 64      | 10 - 8,184            |
| s2.2xlarge        | 24              | 100%                      | 96      | 10 - 8,184            |
| s2.3xlarge        | 32              | 100%                      | 128     | 10 - 8,184            |
| s2.4xlarge        | 40              | 100%                      | 160     | 10 - 8,184            |
| s2.5xlarge        | 48              | 100%                      | 192     | 10 - 8,184            |
| s2.6xlarge        | 64              | 100%                      | 256     | 10 - 8,184            |
| **Intel Ice Lake**                                                                               |
| b3-c1-m4          | 2               | 50%                       | 4       | 10 - 4,096            |
| s3-c2-m8          | 2               | 100%                      | 8       | 10 - 8,184            |
| s3-c4-m16         | 4               | 100%                      | 16      | 10 - 8,184            |
| s3-c8-m32         | 8               | 100%                      | 32      | 10 - 8,184            |
| s3-c12-m48        | 12              | 100%                      | 48      | 10 - 8,184            |
| s3-c16-m64        | 16              | 100%                      | 64      | 10 - 8,184            |
| s3-c24-m96        | 24              | 100%                      | 96      | 10 - 8,184            |
| s3-c32-m128       | 32              | 100%                      | 128     | 10 - 8,184            |
| s3-c40-m160       | 40              | 100%                      | 160     | 10 - 8,184            |
| s3-c48-m192       | 48              | 100%                      | 192     | 10 - 8,184            |
| s3-c64-m256       | 64              | 100%                      | 256     | 10 - 8,184            |
| s3-c80-m320       | 80              | 100%                      | 320     | 10 - 8,184            |
| s3-c96-m576       | 96              | 100%                      | 576     | 10 - 8,184            |
| m3-c2-m16         | 2               | 100%                      | 16      | 10 - 8,184            |
| m3-c4-m32         | 4               | 100%                      | 32      | 10 - 8,184            |
| m3-c6-m48         | 6               | 100%                      | 48      | 10 - 8,184            |
| m3-c8-m64         | 8               | 100%                      | 64      | 10 - 8,184            |
| m3-c12-m96        | 12              | 100%                      | 96      | 10 - 8,184            |
| m3-c16-m128       | 16              | 100%                      | 128     | 10 - 8,184            |
| m3-c24-m192       | 24              | 100%                      | 192     | 10 - 8,184            |
| m3-c32-m256       | 32              | 100%                      | 256     | 10 - 8,184            |
| m3-c40-m320       | 40              | 100%                      | 320     | 10 - 8,184            |
| m3-c48-m384       | 48              | 100%                      | 384     | 10 - 8,184            |
| m3-c56-m448       | 56              | 100%                      | 448     | 10 - 8,184            |
| m3-c64-m512       | 64              | 100%                      | 512     | 10 - 8,184            |
| m3-c80-m640       | 80              | 100%                      | 640     | 10 - 8,184            |
| c3-c2-m4	         | 2               | 100%                      | 4       | 10 – 8,184            |
| c3-c4-m8          | 4               | 100%                      | 8       | 10 - 8,184            |
| c3-c8-m16         | 8               | 100%                      | 16      | 10 - 8,184            |
| c3-c12-m24        | 12              | 100%                      | 24      | 10 - 8,184            |
| c3-c16-m32        | 16              | 100%                      | 32      | 10 - 8,184            |
| c3-c24-m48        | 24              | 100%                      | 48      | 10 - 8,184            |
| c3-c32-m64        | 32              | 100%                      | 64      | 10 - 8,184            |
| c3-c40-m80        | 40              | 100%                      | 80      | 10 - 8,184            |
| c3-c48-m96        | 48              | 100%                      | 96      | 10 - 8,184            |
| c3-c64-m128       | 64              | 100%                      | 128     | 10 - 8,184            |
| c3-c80-m160       | 80              | 100%                      | 160     | 10 - 8,184            |
| c3-c96-m192       | 96              | 100%                      | 192     | 10 - 8,184            |
| **AMD Zen 4**                                                                                      |
| s4a-c2-m8         | 2               | 100%                      | 8       | 10 - 8,184            |
| s4a-c4-m16        | 4               | 100%                      | 16      | 10 - 8,184            |
| s4a-c8-m32        | 8               | 100%                      | 32      | 10 - 8,184            |
| s4a-c16-m64       | 16              | 100%                      | 64      | 10 - 8,184            |
| s4a-c32-m128      | 32              | 100%                      | 128     | 10 - 8,184            |
| s4a-c64-m256      | 64              | 100%                      | 256     | 10 - 8,184            |
| s4a-c96-m384      | 96              | 100%                      | 384     | 10 - 8,184            |
| s4a-c128-m512     | 128             | 100%                      | 512     | 10 - 8,184            |
| s4a-c224-m896     | 224             | 100%                      | 896     | 10 - 8,184            |
| s4a-c256-m1024    | 256             | 100%                      | 1,024    | 10 - 8,184           |
| s4a-c288-m1152    | 288             | 100%                      | 1,152    | 10 - 8,184           |
| m4a-c2-m16        | 2               | 100%                      | 16      | 10 - 8,184            |
| m4a-c4-m32        | 4               | 100%                      | 32      | 10 - 8,184            |
| m4a-c8-m64        | 8               | 100%                      | 64      | 10 - 8,184            |
| m4a-c16-m128      | 16              | 100%                      | 128     | 10 - 8,184            |
| m4a-c32-m256      | 32              | 100%                      | 256     | 10 - 8,184            |
| m4a-c64-m512      | 64              | 100%                      | 512     | 10 - 8,184            |
| m4a-c96-m768      | 96              | 100%                      | 768     | 10 - 8,184            |
| m4a-c128-m1024    | 128             | 100%                      | 1,024    | 10 - 8,184           |
| m4a-c224-m1792    | 224             | 100%                      | 1,792    | 10 - 8,184           |
| c4a-c4-m8         | 4               | 100%                      | 8       | 10 — 16,368           |
| c4a-c8-m16        | 8               | 100%                      | 16      | 10 — 16,368           |
| c4a-c16-m32       | 16              | 100%                      | 32      | 10 — 16,368           |
| c4a-c32-m64       | 32              | 100%                      | 64      | 10 — 16,368           |
| c4a-c64-m128      | 64              | 100%                      | 128     | 10 — 16,368           |
| c4a-c96-m192      | 96              | 100%                      | 192     | 10 — 16,368           |
| c4a-c128-m256     | 128             | 100%                      | 256     | 10 — 16,368           |
| c4a-c224-m448     | 224             | 100%                      | 448     | 10 — 16,368           |
| c4a-c256-m512     | 256             | 100%                      | 512     | 10 — 16,368           |
| c4a-c288-m576     | 288             | 100%                      | 576     | 10 — 16,368           |
| **AMD Zen 4 HighFreq**                                                                           |
| s4af-c2-m8        | 2               | 100%                      | 8       | 10 - 8,184            |
| s4af-c4-m16       | 4               | 100%                      | 16      | 10 - 8,184            |
| s4af-c8-m32       | 8               | 100%                      | 32      | 10 - 8,184            |
| s4af-c16-m64      | 16              | 100%                      | 64      | 10 - 8,184            |
| s4af-c32-m128     | 32              | 100%                      | 128     | 10 - 8,184            |
| s4af-c48-m192     | 48              | 100%                      | 192     | 10 - 8,184            |
| s4af-c80-m320     | 80              | 100%                      | 320     | 10 - 8,184            |
| m4af-c2-m16       | 2               | 100%                      | 16      | 10 - 8,184            |
| m4af-c4-m32       | 4               | 100%                      | 32      | 10 - 8,184            |
| m4af-c8-m64       | 8               | 100%                      | 64      | 10 - 8,184            |
| m4af-c16-m128     | 16              | 100%                      | 128     | 10 - 8,184            |
| m4af-c32-m256     | 32              | 100%                      | 256     | 10 - 8,184            |
| m4af-c48-m384     | 48              | 100%                      | 384     | 10 - 8,184            |
| m4af-c80-m640     | 80              | 100%                      | 640     | 10 - 8,184            |
| c4af-c4-m8        | 4               | 100%                      | 8       | 10 — 16,368           |
| c4af-c8-m16       | 8               | 100%                      | 16      | 10 — 16,368           |
| c4af-c16-m32      | 16              | 100%                      | 32      | 10 — 16,368           |
| c4af-c32-m64      | 32              | 100%                      | 64      | 10 — 16,368           |
| c4af-c48-m96      | 48              | 100%                      | 96      | 10 — 16,368           |
| c4af-c80-m160     | 80              | 100%                      | 160     | 10 — 16,368           |



