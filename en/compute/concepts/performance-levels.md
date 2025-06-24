---
title: vCPU performance levels
description: In this article, you will learn about vCPU performance levels and available configurations on different platforms.
---

# vCPU performance levels


When creating a virtual machine, you need to select a vCPU performance level. This level defines the physical core computing time a vCPU can guarantee.

* Virtual machines with performance under 100% have access to the computing power of physical cores for at least the specified percentage of a unit of time.

    > At 20% performance, a VM will have access to the physical cores at least 20% of the time, i.e., 200 milliseconds out of every second. During that time, the processor clock speed is not limited and depends on the selected platform, e.g., 2 GHz for Intel Ice Lake (`standard-v3`).

    VMs with a performance level under 100% are designed to run applications that do not require high performance and are not sensitive to delays. These VMs cost less.

* Virtual machines with 100% performance have continuous access (100% of the time) to the physical core computing power. Such VMs are designed to run applications that require high performance all the time.

Actual performance may exceed the guaranteed level. Available configurations of computing resources may change for different levels, depending on the selected [platform](vm-platforms.md).

The available disk space does not depend on the VM performance level. For limitations, see [{#T}](limits.md).

## Minimum and maximum configurations {#minmax-configurations}

This subsection presents the minimum and maximum computing resource configurations depending on the platform. You can achieve these values in [different combinations](#available-configurations).

{% note info %}

The option with simultaneous maximum configuration of all computing resources is not available for all platforms. For more information, see [Available configurations](#available-configurations).

{% endnote %}


* Intel Broadwell (`standard-v1`):

    Limit | Performance<br>level | vCPU | RAM, GB<br>total | RAM, GB<br>per core
    ------------ | ----------------------------- | ---- | ---------------- | -----------------
    Min         | 5%                            | 2    | 1                | 0.5
    Max        | 100%                          | 32   | 256              | 8

* Intel Cascade Lake (`standard-v2`):

    Limit | Performance<br>level | vCPU | RAM, GB<br>total | RAM, GB<br>per core
    ------------ | ----------------------------- | ---- | ---------------- | -----------------
    Min         | 5%                            | 2    | 0.5              | 0.25
    Max        | 100%                          | 80   | 1280             | 16

* Intel Ice Lake (`standard-v3`):

    Limit | Performance<br>level | vCPU | RAM, GB<br>total | RAM, GB<br>per core
    ------------ | ----------------------------- | ---- | ---------------- | -----------------
    Min         | 20%                           | 2    | 1                | 0.5
    Max        | 100%                          | 96   | 640              | 16

* {{ highfreq-ice-lake }} (`highfreq-v3`):

    Limit | Performance<br>level | vCPU | RAM, GB<br>total | RAM, GB<br>per core
    ------------ | ----------------------------- | ---- | ---------------- | -----------------
    Min         | 100%                          | 2    | 2                | 1
    Max        | 100%                          | 56   | 448              | 16

* AMD Zen 3 platform (`amd-v1`)^1^:

    Limit | Performance<br>level | vCPU | RAM, GB<br>total | RAM, GB<br>per core
    ----- | ----------------------------- | ---- | ---------------- | -----------------
    Min  | 20%                           | 2    | 1                | 0.5
    Max | 100%                          | 128  | 768              | 6

{% include [amd-platform-preview](../../_includes/compute/amd-platform-preview.md) %}

## Available configurations {#available-configurations}

* Intel Broadwell (`standard-v1`):

    Performance<br>level | vCPU | RAM, GB<br>per core
    --- | --- | ---
    5% | 2, 4 | 0.5, 1, 1.5, 2
    20% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4
    100% | 2, 4, 6, 8, 10, 12, 14,<br> 16, 20, 24, 28, 32 | 1, 2, 3, 4, 5, 6, 7, 8

* Intel Cascade Lake (`standard-v2`):

    Performance<br>level | vCPU | RAM, GB<br>per core
    --- | --- | ---
    5% | 2, 4 | 0.25, 0.5, 1, 1.5, 2
    20% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4
    50% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4
    100% | 2, 4, 6, 8, 10, 12, 14,<br> 16, 20, 24, 28, 32, 36,<br> 40, 44, 48, 52, 56, 60,<br> 64, 68, 72, 76, 80 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,<br> 11, 12, 13, 14, 15, 16

* Intel Ice Lake (`standard-v3`):

    Performance<br> level | vCPU | RAM per core, GB
    --- | --- | ---
    20% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4
    50% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4
    100% | 2, 4, 6, 8, 10, 12, 14, 16, 20 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,<br> 11, 12, 13, 14, 15, 16
    100% | 24 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
    100% | 28 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
    100% | 32 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    100% | 36, 40 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,<br> 11, 12, 13, 14, 15, 16 
    100% | 44 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,<br> 11, 12, 13, 14
    100% | 48 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,<br> 11, 12, 13
    100% | 52 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,<br> 11, 12
    100% | 56 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,<br> 11
    100% | 60, 64 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    100% | 68 | 1, 2, 3, 4, 5, 6, 7, 8, 9
    100% | 72, 76, 80 | 1, 2, 3, 4, 5, 6, 7, 8
    100% | 84, 88 | 1, 2, 3, 4, 5, 6, 7
    100% | 92, 96 | 1, 2, 3, 4, 5, 6

* {{ highfreq-ice-lake }} (`highfreq-v3`):

    vCPU | RAM, GB per core
    --- | --- 
    2, 4, 6, 8, 10, 12, 14,<br> 16, 20, 24, 28, 32, 36,<br> 40, 44, 48, 52, 56 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,<br> 11, 12, 13, 14, 15, 16

* AMD Zen 3 platform (`amd-v1`)^1^:

    Performance<br>level | vCPU | RAM, GB<br>per core
    --- | --- | ---
    20% | 2, 4 | 0.5, 1, 1.5
    50% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4
    100% | 2, 4, 8, 16, 32, 48, 64, 96, 128 | 1, 2, 3, 4, 5, 6

{% include [amd-platform-preview](../../_includes/compute/amd-platform-preview.md) %}
