---
title: Installing NVIDIA drivers
description: Follow this guide to install NVIDIA drivers.
---


# Installing NVIDIA drivers


To enable compatibility with [GPU](../../concepts/gpus.md), make sure NVIDIA drivers are installed on your VM. You can install the drivers either when [preparing the image](../image-create/custom-image.md) or from within the VM after it is created.

{% note info %}
   
{% include [gpu-driver-versions](../../../_includes/compute/gpu-driver-versions.md) %}

{% endnote %}

## Drivers for Tesla® V100 {#install-v100-drivers}

To install the NVIDIA® Tesla® V100 drivers:

1. Go to the [form](https://www.nvidia.com/download/index.aspx) page.
1. In the **Product category** field, select `Data Center / Tesla`.
1. In the **Product series** field, select `V-Series`.
1. In the **Product** field, select `Tesla V100`.
1. In the **Operating system** field, select the OS you need.
1. Specify the remaining settings according to your OS and driver requirements.
1. Click **Search**. You will be directed to a page with the suitable driver.
1. Click **Download now**.
1. Run the downloaded installer and follow the on-screen instructions.

## Drivers for Ampere® A100 {#install-a100-drivers}

{{ compute-short-name }} offers two VM [configurations](../../concepts/gpus.md#config) based on AMD EPYC® with NVIDIA® Ampere® A100: 1 GPU and 8 GPUs.

{% note info %}
   
During installation, specify the compatible driver version, `535`.

We recommend using this specific driver version; updates to other versions are not supported and may lead to unstable GPU performance.

{% endnote %}

To install the NVIDIA® Ampere® A100 drivers via the GUI:

1. Go to the [form](https://www.nvidia.com/download/index.aspx) page.
1. In the **Product category** field, select `Data Center / Tesla`.
1. In the **Product series** field, select `A-Series`.
1. In the **Product** field, select `NVIDIA A100`.
1. In the **Operating system** field, select the OS you need.
1. Specify the remaining settings according to your OS and driver requirements.
1. Click **Search**. You will be directed to a page with the suitable driver.
1. Click **Download now**.
1. Run the downloaded installer and follow the on-screen instructions.

To install the drivers without the GUI:

1. In the terminal, run this installation command:

   ```bash
   sudo apt install -y nvidia-driver-<driver_version>-server
   ```

1. Test Fabric Manager:

   ```bash
   nvidia-smi nvlink -s
   ```
