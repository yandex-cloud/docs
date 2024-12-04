---
title: Installing NVIDIA drivers
description: Follow this guide to install NVIDIA drivers.
---

# Installing NVIDIA drivers


To enable compatibility with [GPU](../../concepts/gpus.md), make sure that NVIDIA drivers are installed on the VM. You can install the drivers either when [preparing the image](../image-create/custom-image.md) or from inside the VM after it is created.

## Drivers for Tesla® V100 {#install-v100-drivers}

To install the drivers for NVIDIA® Tesla® V100:

1. Go to the [form](https://www.nvidia.com/download/index.aspx) page.
1. Select Data Center / Tesla in the **Product type** field.
1. Select V-Series in the **Product series** field.
1. Select Tesla V100 in the **Product family** field.
1. Select the OS in the **Operating system** field.
1. Specify other settings according to your OS and driver requirements.
1. Click **Search**. The appropriate driver page opens.
1. Click **Download now**.
1. Run the downloaded installer and follow the instructions.

## Drivers for Ampere® A100 {#install-a100-drivers}

In {{ compute-short-name }}, there are two available [configurations](../../concepts/gpus.md#config) for VMs based on AMD EPYC® with NVIDIA® Ampere® A100: with 1 GPU and 8 GPUs. For the 8 GPU configuration, you should additionally install [Fabric Manager](https://docs.nvidia.com/datacenter/tesla/fabric-manager-user-guide/index.html).

To install the drivers for NVIDIA® Ampere® A100:

1. Go to the [form](https://www.nvidia.com/download/index.aspx) page.
1. Select Data Center / Tesla in the **Product type** field.
1. Select A-Series in the **Product series** field.
1. Select NVIDIA A100 in the **Product family** field.
1. Select the OS in the **Operating system** field.
1. Specify other settings according to your OS and driver requirements.
1. Click **Search**. The appropriate driver page opens.
1. Click **Download now**.
1. Run the downloaded installer and follow the instructions.

To install and configure Fabric Manager:

1. In the terminal, run:

   ```bash
   sudo apt install -y nvidia-driver-<driver_version>-server nvidia-utils-<driver_version>-server nvidia-fabricmanager-<driver_version>
   sudo systemctl enable nvidia-fabricmanager
   sudo systemctl start nvidia-fabricmanager
   ```

   {% note info %}

   When installing, specify the required driver version (for example, 460).

   {% endnote %}

1. Test Fabric Manager:

   ```bash
   nvidia-smi nvlink -s
   ```
