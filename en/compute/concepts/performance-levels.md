# vCPU performance levels

When creating a virtual machine, you need to select a vCPU performance level. This level defines the physical core computing time that a vCPU guarantees.

* Virtual machines with performance under 100% have access to the computing power of physical cores for at least the specified percentage of a unit of time.

   > At 20% performance, a VM will have access to the physical cores at least 20% of the time: 200 milliseconds out of every second. During that time, the processor clock speed is not limited and is equal to that of the selected platform, such as 2 GHz for Intel Ice Lake (`standard-v3`).

   VMs with a performance level under 100% are designed to run applications that do not require high performance and are immune to delays. These machines will cost less.

* Virtual machines with 100% performance have continuous access (100% of the time) to the physical cores' computing power. These VMs are designed to run applications that require high performance all the time.

Actual performance may exceed the guaranteed level. Available configurations of computing resources may change for different levels, depending on the selected [platform](vm-platforms.md).

The available disk space does not depend on the VM performance level. For limitations, see [{#T}](limits.md).

Minimum and maximum configurations:

{% note info %}

Minimum configurations are specified for the {% if product == "yandex-cloud" %}5%{% endif %}{% if product == "cloud-il" %}20%{% endif %} performance level, and maximum configurations for 100%.

{% endnote %}

{% if product == "yandex-cloud" %}

* Intel Broadwell platform (`standard-v1`):

   | Configuration | vCPU | RAM, GB |
   --- | --- | --- 
   | Min | 2 | 1 |
   | Max | 32 | 256 |

* Intel Cascade Lake platform (`standard-v2`):

   | Configuration | vCPU | RAM, GB |
   --- | --- | --- 
   | Min | 2 | 0.5 |
   | Max | 80 | 1280 |

{% endif %}

* Intel Ice Lake (`standard-v3`):

   | Configuration | vCPU | RAM, GB |
   --- | --- | --- 
   | Min | 2 | 1 |
   | Max | 96 | 640 |

   {% note info %}

   The configuration with the maximum number of vCPUs (96) and the maximum amount of RAM (640 GB) at the same time is not available for Intel Ice Lake. If a VM has 96 vCPUs, the maximum amount of RAM is 576 GB. If a VM's RAM is 640 GB, it may have a maximum of 80 vCPUs.

   {% endnote %}

Available configurations of computing resources:


{% if product == "yandex-cloud" %}

* Intel Broadwell platform (`standard-v1`):

   | Performance</br> level | vCPU | RAM per core, GB |
   --- | --- | ---
   | 5% | 2, 4 | 0.5, 1, 1.5, 2 |
   | 20% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4 |
   | 100% | 2, 4, 6, 8, 10, 12, 14,<br> 16, 20, 24, 28, 32 | 1, 2, 3, 4, 5, 6, 7, 8 |

* Intel Cascade Lake platform (`standard-v2`):

   | Performance<br> level | vCPU | RAM per core, GB |
   --- | --- | ---
   | 5% | 2, 4 | 0.25, 0.5, 1, 1.5, 2 |
   | 20% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4 |
   | 50% | 2, 4 | 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4 |
   | 100% | 2, 4, 6, 8, 10, 12, 14,<br> 16, 20, 24, 28, 32, 36,<br> 40, 44, 48, 52, 56, 60,<br> 64, 68, 72, 76, 80 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,<br> 11, 12, 13, 14, 15, 16 |

{% endif %}

* Intel Ice Lake (`standard-v3`):

   | Performance<br> level | vCPU | RAM per core, GB |
   --- | --- | ---
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