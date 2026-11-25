---
title: Installing NVIDIA drivers
description: Follow this guide to install NVIDIA drivers.
---


# Installing NVIDIA drivers


Applications deployed on VMs utilize CUDA for GPU acceleration, with GPU access provided by the NVIDIA driver.  You can either use an [image with pre-installed drivers](../../concepts/gpus.md#os) or install the drivers manually either when [creating an image](../image-create/custom-image.md) or from within an existing VM.

{% note info %}
   
{% include [gpu-driver-versions](../../../_includes/compute/gpu-driver-versions.md) %}

{% endnote %}

## Select a driver on the NVIDIA website {#select-driver}

On the official NVIDIA website, select a driver compatible with your VM's GPU and OS.

{% list tabs %}

- Tesla® V100 {#install-v100-drivers}

  1. Go to the [search page](https://www.nvidia.com/download/index.aspx).
  1. Under **Product Category**, select `Data Center / Tesla`.
  1. In the **Product Series** field, select `V-Series`.
  1. Under **Product** field, select `Tesla V100`.
  1. In the **Operating System** field, select the OS installed on your VM.
  1. Specify the remaining settings to match your OS and driver requirements.
  1. Click **Find**.
  1. Navigate to the driver page. The **CUDA Toolkit** field displays the maximum CUDA version supported by this driver.

- Ampere® A100 {#install-a100-drivers}

  1. Go to the [search page](https://www.nvidia.com/download/index.aspx).
  1. Under **Product Category**, select `Data Center / Tesla`.
  1. In the **Product Series** field, select `A-Series`.
  1. Under **Product** field, select `NVIDIA A100`.
  1. In the **Operating System** field, select the OS installed on your VM.
  1. Specify the remaining settings to match your OS and driver requirements.
  1. Click **Find**.
  1. Navigate to the driver page. The **CUDA Toolkit** field displays the maximum CUDA version supported by this driver.

{% endlist %}

## Install the driver {#install-driver}

For NVIDIA® Ampere® A100, you can install the driver directly from the official repository. [Connect to the VM over SSH](../vm-connect/ssh.md) and run:

```bash
sudo apt update
sudo apt install -y nvidia-driver-<driver_version>-server
```

Where `<driver_version>` is the major driver version from the NVIDIA website. For example, version `580.178.04` maps to the `nvidia-driver-580-server` package name.

NVIDIA® Tesla® V100 utilizes an older architecture that is incompatible with some driver versions. If a compatible package is missing from your connected repositories or if errors occur, install the driver from the NVIDIA website.

To install the driver manually:

1. [Connect to the VM over SSH](../vm-connect/ssh.md).
1. Copy the direct link to the installer file from the driver page.
1. Download the installer using `wget`, then follow the [NVIDIA Ubuntu installation guide](https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/ubuntu.html).

If you fail to download the installer from the VM, save it to your local computer and [copy it to the VM via SCP](../vm-connect/scp-sftp.md#scp).

## Test the driver and CUDA version {#check-cuda}

After completing the driver installation, run the following command on the VM:

```bash
nvidia-smi
```

If the driver works correctly and the GPU is available, the command will output a table with GPU info. The `Driver Version` field indicates the driver version, and the `CUDA Version` field shows the maximum CUDA release it supports.

On a multi-GPU VM, check the status of NVLink connections:

```bash
nvidia-smi nvlink -s
```

To find out the installed CUDA Toolkit version, run this command:

```bash
nvcc --version
```

The version is specified in the `Cuda compilation tools, release ...` output string and must be compatible with the installed driver. For more information on installing and configuring CUDA Toolkit, refer to [this NVIDIA guide](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/).

#### Useful links {#see-also}

* [{#T}](../enable-mig.md)
