---
title: Enabling MIG mode on a VM with a GPU
description: Follow this guide to split your GPU into a number of isolated instances using the MIG technology.
---

# Enabling MIG mode on a VM with a GPU in {{ compute-name }}


{% note info %}

This guide was tested on Ubuntu 20.04, Ubuntu 22.04, and Ubuntu 24.04 images with NVIDIA driver version 535.

{% endnote %}

_MIG (Multi-Instance GPU)_ is an NVIDIA technology that allows splitting a single graphics accelerator into several independent GPU instances. Each GPU instance gets its dedicated computing blocks, L2 cache, and HBM2 memory. Instances are isolated from each other at the hardware level, so a load on one instance does not affect the performance of the others.

For a detailed description of this technology and its splitting schema, see the [NVIDIA MIG User Guide](https://docs.nvidia.com/datacenter/tesla/mig-user-guide/) page.

With MIG, you can:
* Run multiple independent ML or inference jobs on a single VM without them affecting each other in terms of performance and memory.
* Use your GPU in a more efficient way because no individual job can load the entire GPU.
* Guarantee the allocation of GPU resources among several users or processes.

MIG is supported for the following [platforms](../concepts/vm-platforms.md):
* {{ a100-epyc }} (`gpu-standard-v3`).
* Gen2 (`gpu-standard-v3i`).
* GPU PLATFORM V4 (`gpu-standard-v4`).

{% note warning %}

In MIG mode, you cannot transfer data between GPUs over [NVLink](https://en.wikipedia.org/wiki/NVLink).

{% endnote %}

To enable MIG mode on a VM with a GPU:
1. Create a VM:
    1. [Create](vm-create/create-vm-with-gpu.md) a VM with a GPU based on one of the following platforms:
        * {{ a100-epyc }} (`gpu-standard-v3`).
        * Gen2 (`gpu-standard-v3i`).
        * GPU PLATFORM V4 (`gpu-standard-v4`).

        {% note tip %}

        Make sure the cloud has enough [quotas](../concepts/limits.md#compute-quotas) for the total number of GPUs of the correct platform, RAM, number of vCPUs, and SSD size to create a VM. Use [{{ quota-manager-full-name }}](../../quota-manager/) to run this check.

        {% endnote %}

    1. [Connect](vm-connect/ssh.md) to the VM over SSH.
    1. [Install](vm-operate/install-nvidia-drivers.md) NVIDIA drivers version 535.
1. Disable NVLink on the GPUs. {#disable-nvlink}
    1. Create a file named `/etc/modprobe.d/nonvlink.conf` with the following contents:

        ```text
        options nvidia NVreg_NvLinkDisable=1
        ```

    1. Restart the NVIDIA driver:

        {% note warning %}

        From now on, run all commands as the `root` user or use `sudo`.

        {% endnote %}

        ```bash
        sudo systemctl stop nvidia-persistenced
        sudo modprobe -r nvidia_uvm nvidia_drm nvidia_modeset nvidia
        sudo modprobe nvidia
        sudo systemctl start nvidia-persistenced
        nvidia-smi
        ```

    1. Make sure NVLink is off:

        ```bash
        grep NvLink /proc/driver/nvidia/params
        ```

        Expected result:

        ```text
        NvLinkDisable: 1
        ```

1. Reset the status of the GPUs:

    ```bash
    sudo nvidia-smi -r
    ```

    Result:

    ```text
    GPU 00000000:8B:00.0 was successfully reset.
    GPU 00000000:8C:00.0 was successfully reset.
    All done.
    ```

    For more on possible errors, see [{#T}](#troubleshooting).

1. Enable MIG mode for all the VM GPUs:

    ```bash
    sudo nvidia-smi -mig 1
    ```

    Result:

    ```text
    Enabled MIG Mode for GPU 00000000:8B:00.0
    Enabled MIG Mode for GPU 00000000:8C:00.0
    All done.
    ```

    {% note info %}

    If the output alerts you with `Warning: persistence mode is disabled on device ...`, start `nvidia-persistenced`:

    ```bash
    sudo systemctl start nvidia-persistenced
    ```

    {% endnote %}

1. Split the GPUs into GPU instances. The example below creates two GPU instances with the `1g.10gb` profile on each GPU:

    ```bash
    sudo nvidia-smi mig -cgi 19,1g.10gb -C
    ```

    Result:

    ```text
    Successfully created GPU instance ID 13 on GPU  0 using profile MIG 1g.10gb (ID 19)
    Successfully created compute instance ID  0 on GPU  0 GPU instance ID 13 using profile MIG 1g.10gb (ID  0)
    Successfully created GPU instance ID 11 on GPU  0 using profile MIG 1g.10gb (ID 19)
    Successfully created compute instance ID  0 on GPU  0 GPU instance ID 11 using profile MIG 1g.10gb (ID  0)
    ...
    ```

    For a list of available splitting profiles for NVIDIA® A100, see [NVIDIA MIG User Guide](https://docs.nvidia.com/datacenter/tesla/mig-user-guide/#supported-mig-profiles).  Alternatively, you can use the `nvidia-smi mig -lgip` command.

1. Check your new GPU instances:

    ```bash
    nvidia-smi -L
    ```

    Result:

    ```text
    GPU 0: NVIDIA A100-SXM4-80GB (UUID: GPU-9c73eb7b-8d6d-6c0e-dc13-97873e2ede40)
      MIG 1g.10gb     Device  0: (UUID: MIG-a686709d-6dc2-542a-8851-0d2508448c10)
      MIG 1g.10gb     Device  1: (UUID: MIG-53864714-0a66-5df2-9007-9268e30d9a72)
    GPU 1: NVIDIA A100-SXM4-80GB (UUID: GPU-c92e2d5d-4a69-f1cd-4df0-305f8606705a)
      MIG 1g.10gb     Device  0: (UUID: MIG-d5a46a2e-1d77-575d-99e3-1f96c8555a2e)
      MIG 1g.10gb     Device  1: (UUID: MIG-b8479d6e-d08f-5a92-9a24-0946db72b2a0)
    ```

Your GPU instances are ready to use. To run computations on a specific instance, provide its UUID into the `CUDA_VISIBLE_DEVICES` environment variable.

## Troubleshooting {#troubleshooting}

{% include [gpu-mig-troubleshooting](../../_includes/compute/gpu-mig-troubleshooting.md) %}

#### Useful links {#see-also}

* [{#T}](../concepts/gpus.md)
* [{#T}](vm-create/create-vm-with-gpu.md)
* [{#T}](vm-operate/install-nvidia-drivers.md)
* [{#T}](gpu-driver-update.md)
