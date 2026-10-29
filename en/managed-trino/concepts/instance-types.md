---
title: '{{ mtr-name }} host classes'
description: The host class determines the computing power allocated for each host in a {{ mtr-name }} cluster.
---

# {{ mtr-name }} host classes

The _host class_ determines the computing power allocated for each host in a cluster.

For more information on limits, see [Quotas and limits](limits.md).

## Available host classes {#available-flavors}

The following types of host classes are available:

* `standard`
* `memory-optimized`
* `legacy`

The `standard` and `memory-optimized` classes are located on the AMD Zen 4 platform. Their names have the `v4a-` prefix. The `legacy` type covers the previous generation classes on Intel Ice Lake. For more information, see [Platforms](../../compute/concepts/vm-platforms.md#standard-platforms).

### Standard and memory-optimized classes on AMD Zen 4 {#amd-zen4}

For the `standard` and `memory-optimized` classes, the number of vCPUs and amount of RAM in the class name match the VM resources. A part of these resources is allocated to {{ mtr-name }}'s service components. When calculating a cluster's required resources, use values from the **Available to {{ TR }} component** columns.

It has to do with the platform's architectural features and does not affect billing: you are charged based on the values from the **Available to {{ TR }} component** columns. For example, for the `v4a-c8-m32` host class, the {{ TR }} has 6 vCPUs and 26 GB RAM available; the same values are used for billing.

To select a host class, map the workload requirements to the resources available to the {{ TR }} component. Use these values when configuring workloads and resource groups.

#### standard {#amd-standard}

| Host class name | VM, vCPU | VM, RAM, GB | Available to {{ TR }} component, vCPU | Available to {{ TR }} component, RAM, GB |
| --- | ---: | ---: | ---: | ---: |
| `v4a-c8-m32` | 8 | 32 | 6 | 26 |
| `v4a-c16-m64` | 16 | 64 | 13 | 54 |
| `v4a-c32-m128` | 32 | 128 | 28 | 112 |
| `v4a-c64-m256` | 64 | 256 | 60 | 236 |

#### memory-optimized {#amd-memory-optimized}

| Host class name | VM, vCPU | VM, RAM, GB | Available to {{ TR }} component, vCPU | Available to {{ TR }} component, RAM, GB |
| --- | ---: | ---: | ---: | ---: |
| `v4a-c8-m64` | 8 | 64 | 6 | 52 |
| `v4a-c16-m128` | 16 | 128 | 13 | 108 |
| `v4a-c32-m256` | 32 | 256 | 28 | 224 |
| `v4a-c64-m512` | 64 | 512 | 60 | 472 |

### Legacy classes on Intel Ice Lake {#legacy}

For the `legacy` classes, the numbers in the class name match the resources available to the {{ TR }} component. For example, in the `c16-m64` class, the component has 16 vCPUs and 64 GB RAM available.

| Host class name | Available to {{ TR }} component, vCPU | Available to {{ TR }} component, RAM, GB |
| --- | ---: | ---: |
| `c4-m16` | 4 | 16 |
| `c8-m32` | 8 | 32 |
| `c16-m64` | 16 | 64 |
| `c32-m128` | 32 | 128 |
| `c4-m32` | 4 | 32 |
| `c8-m64` | 8 | 64 |
| `c16-m128` | 16 | 128 |
| `c32-m256` | 32 | 256 |