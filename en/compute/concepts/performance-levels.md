# vCPU performance levels

Choose the vCPU performance level when creating a VM. It sets the guaranteed vCPU share to be allocated to the VM. Available configurations of computing resources may change for different levels, depending on the selected [platform](vm-platforms.md).

* VMs with a guaranteed vCPU share below 100% are designed for running apps that do not require high performance. These VMs are also cheaper.
* VMs with a 100% guaranteed vCPU share are designed for running apps that require high performance.

The available disk space does not depend on the VM performance level. For limitations, see [{#T}](limits.md).

Minimum and maximum configurations:

{% note info %}

Minimum configurations are specified for the 5% performance level, and maximum configurations for 100%.

{% endnote %}

* Intel Broadwell platform (`standard-v1`):

    | Configuration | vCPU | RAM, GB |
    | --- | --- | --- |
    | Min | 2 | 1 |
    | Max | 32 | 256 |

* Intel Cascade Lake platform (`standard-v2`):

    | Configuration | vCPU | RAM, GB |
    | --- | --- | --- |
    | Min | 2 | 0.5 |
    | Max | 80 | 1280 |

* Intel Ice Lake (`standard-v3`):

    | Configuration | vCPU | RAM, GB |
    | --- | --- | --- |
    | Min | 2 | 1 |
    | Max | 96 | 640 |

    {% note info %}

    The configuration with the maximum number of vCPUs (96) and the maximum amount of RAM (640 GB) at the same time is not available for Intel Ice Lake. If a VM has 96 vCPUs, the maximum amount of RAM is 576 GB. If a VM's RAM is 640 GB, it may have a maximum of 80 vCPUs.

    {% endnote %}

Available configurations of computing resources:

* Intel Broadwell platform (`standard-v1`):

    | Performance</br> level | vCPU | RAM per core, GB |
    | --- | --- | --- |
    | 5% | 2, 4 | 0.5, 1, 1.5, 2 |
    | 20% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4 |
    | 100% | 2, 4, 6, 8, 10, 12, 14,<br> 16, 20, 24, 28, 32 | 1, 2, 3, 4, 5, 6, 7, 8 |

* Intel Cascade Lake platform (`standard-v2`):

    | Performance<br> level | vCPU | RAM per core, GB |
    | --- | --- | --- |
    | 5% | 2, 4 | 0.25, 0.5, 1, 1.5, 2 |
    | 20% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4 |
    | 50% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4 |
    | 100% | 2, 4, 6, 8, 10, 12, 14,<br> 16, 20, 24, 28, 32, 36,<br> 40, 44, 48, 52, 56, 60,<br> 64, 68, 72, 76, 80 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,<br> 11, 12, 13, 14, 15, 16 |

* Intel Ice Lake (`standard-v3`):

    | Performance<br> level | vCPU | RAM per core, GB |
    | --- | --- | --- |
    | 20% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4 |
    | 50% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4 |
    | 100% | 2, 4, 6, 8, 10, 12, 14,<br> 16, 20, 24, 28, 32, 36,<br> 40 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,<br> 11, 12, 13, 14, 15, 16 |
    | 100% | 44 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,<br> 11, 12, 13, 14 |
    | 100% | 48 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,<br> 11, 12, 13 |
    | 100% | 52 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,<br> 11, 12 |
    | 100% | 56 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,<br> 11 |
    | 100% | 60, 64 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 |
    | 100% | 68 | 1, 2, 3, 4, 5, 6, 7, 8, 9 |
    | 100% | 72, 76, 80 | 1, 2, 3, 4, 5, 6, 7, 8 |
    | 100% | 84, 88 | 1, 2, 3, 4, 5, 6, 7 |
    | 100% | 92, 96 | 1, 2, 3, 4, 5, 6 |