# What is the maximum number of network interfaces that can be connected to a VM


## Scenario description {#case-description}

How many network interfaces can be connected to a VM?

## Solution {#case-resolution}

Maximum number of network interfaces depends on the platform and vCPU on your VM. Here are the values for the platforms:

1. Broadwell (`standard-v1`):
   * 2 to 16 vCPUs: 8 interfaces
   * 20 to 32 vCPUs: 16 interfaces

2. Cascade Lake (`standard-v2`):
   * 2 to 16 vCPUs: 8 interfaces
   * 20 to 80 vCPUs: 16 interfaces

3. Ice Lake (`standard-v3`):
   * 2 to 32 vCPUs: 8 interfaces 
   * 36 to 96 vCPUs: 16 interfaces

{% note info %}

When a VM starts, a maximum of 14 devices, including the boot disk and a NIC, can be connected to it. A VM will not start if it has more than 14 connected devices. Keep this in mind when creating the VM.
For more information, see the [documentation](../../../compute/concepts/limits#compute-limits-vm).

{% endnote %}

