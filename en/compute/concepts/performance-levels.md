# Levels of core performance

Choose the level of core performance when creating each VM. The level determines the computing power that should be allocated to the virtual machine. Available configurations of computing resources may change for different levels, depending on the selected [platform](vm-platforms.md).

- VMs with part core usage operate with partial use of the core. They are designed to run applications that do not require high performance. In addition, these machines cost less than standard virtual machines.
- VMs with 100% core usage operate with full use of the core. They are designed to run applications that require high performance.

The available disk space does not depend on the type of virtual machine.  For limitations, see [{#T}](limits.md).

Minimum and maximum configurations for:

- Platform Intel Broadwell (`standard-v1`):

    | Configuration | vCPU | RAM, GB |
    | --- | --- | --- | --- |
    | Min | 1 | 1 |
    | Max | 32 | 256 |

- Platform Intel Cascade Lake (`standard-v2`):

    | Configuration | vCPU | RAM, GB |
    | --- | --- | --- | --- |
    | Min | 2 | 0.5 |
    | Max | 64 | 384 |

Available configurations of computing resources:

- Platform Intel Broadwell (`standard-v1`):

    | Performance</br> level | vCPU | RAM per core, GB |
    | --- | --- | --- | --- |
    | 5% | 1, 2, 4 | 0.5, 1, 1.5, 2 |
    | 20% | 1, 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4 |
    | 100% | 1, 2, 4, 6, 8, 10, 12,</br> 14, 16, 18, 20, 22, 24,</br> 26, 28, 30, 32 | 1, 2, 3, 4, 5, 6, 7, 8 |

- Platform Intel Cascade Lake (`standard-v2`):

    | Performance</br> level | vCPU | RAM per core, GB |
    | --- | --- | --- | --- |
    | 5% | 2, 4 | 0.25, 0.5, 1, 1.5, 2 |
    | 20% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4 |
    | 50% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4 |
    | 100% | 2, 4, 6, 8, 10, 12, 14,</br> 16, 20, 24, 28, 32, 36,</br> 40, 44, 48, 52, 56, 60, 64 | 1, 2, 3, 4, 5, 6, 7, 8 |






