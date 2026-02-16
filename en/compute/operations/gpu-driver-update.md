---
title: How to update NVIDIA drivers
description: Follow this guide to update NVIDIA and CUDA drivers.
---

# NVIDIA driver update guide


{% note warning %}

This guide covers the `gpu-standard-v3` ({{ a100-epyc }}) and `gpu-standard-v3i` platforms.

For `gpu-standard-v3i`, you can only use an image with the [NVIDIA 535 driver and secure-boot support](/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2). The video driver cannot be updated on this platform; you can only update the CUDA library.

{% endnote %}

## Supported drivers and recommendations {#supported-drivers}

In {{ yandex-cloud }}, the `gpu-standard-v3` ({{ a100-epyc }}) and `gpu-standard-v3i` VMs are preconfigured with the NVIDIA 535 driver.
We recommend using this specific driver version; driver updates to other versions are not supported and may lead to unstable GPU performance.

## Shared NVSwitch virtualization model {#shared-nvswitch}

We use the `Shared NVSwitch` virtualization model described in [NVIDIA Fabric Manager User Guide](https://docs.nvidia.com/datacenter/tesla/pdf/fabric-manager-user-guide.pdf).

NVSwitch devices are taken to a separate auxiliary VM and controlled by the NVIDIA 535 driver. When you start a guest VM, GPUs are preconfigured for NVLink; to keep this preconfiguration, you are not allowed to software reset GPUs from user VMs in {{ yandex-cloud }}.

If you update the user VM driver to another version, e.g., 570, the driver may fail to recognize the current GPU state. This is a NVIDIA driver limitation. This is why we do not recommend changing the user VM driver version.

## Why use driver version 535? {#why-version-535}

NVIDIA publishes multiple driver branches ([NVIDIA Data Center Drivers Overview](https://docs.nvidia.com/datacenter/tesla/pdf/NVIDIA_Datacenter_Drivers.pdf)):

* **LTSB (Long-Term Support Branch)**: Long-term support, security updates and fixes for 3 years.
* **PB (Production Branch)**: Main branch for data centers.
* **NFB (New Feature Branch)**: Drivers with new features.

Version 535 belongs to **LTSB**; it is validated and supported in the {{ yandex-cloud }} infrastructure. Drivers from other branches fail the compatibility check and may work incorrectly.

## CUDA update {#cuda-update}

Oftentimes, it is not a new driver that you need but **CUDA Toolkit** update. In most cases, you do not need to update the driver, it is enough to install the required CUDA version and the `cuda-compat` package for compatibility with the 535 driver ([*CUDA Forward Compatibility*](https://docs.nvidia.com/deploy/cuda-compatibility/forward-compatibility.html)).

### Ubuntu installation example {#cuda-example-ubuntu}

1. Connect the NVIDIA CUDA repository:

   ```bash
   sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu$(lsb_release -rs | sed -e 's/\.//')/x86_64/3bf863cc.pub
   sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /"
   sudo apt update
   ```

1. Install `cuda-compat` (example for CUDA 12.5):

   ```bash
   sudo apt install -y cuda-compat-12-5
   echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.5/compat:$LD_LIBRARY_PATH' >> ~/.bashrc && source ~/.bashrc
   ```

1. Check the current configuration:

   ```bash
   nvidia-smi
   ```

## Issue with `sudo reboot` after updating the driver to a version higher than 535 and the recommended workaround {#reboot-workaround}

When you reinstall the driver followed by `sudo reboot`, the driver does not have enough time to upload correctly. And as {{ yandex-cloud }} prohibits GPU software reset, the card remains invalid. While this does not cause any hardware issues, the VM will operate incorrectly. Use the `yc compute instance restart` command instead of `sudo reboot`.

This is why we **do not recommend** updating the driver to a version higher than 535. If you need to install a driver version higher than 535 and reboot the user VM, use the following workaround scenario:

1. [Install](https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/index.html#ubuntu-installation-network) the driver.

   {% cut "Script for Ubuntu" %}
   
   ```bash
   #!/bin/bash
   set -e
   
   # Fixing the architecture
   arch="x86_64"
   
   # Figuring out the Ubuntu version (20.04 -> ubuntu2004, 22.04 -> ubuntu2204, etc.)
   . /etc/os-release
   if [[ "$ID" != "ubuntu" ]]; then
     echo "This script is for Ubuntu only!"
     exit 1
   fi
   distro="ubuntu${VERSION_ID//./}"
   
   echo "Using the repository: $distro/$arch"
   
   # 1. Downloading the package with keys
   wget https://developer.download.nvidia.com/compute/cuda/repos/${distro}/${arch}/cuda-keyring_1.1-1_all.deb
   
   # 2. Installing the keys
   sudo dpkg -i cuda-keyring_1.1-1_all.deb || {
     echo "Failed to install cuda-keyring, performing alternative steps..."
     
     # 2a. Uploading the GPG key manually
     wget https://developer.download.nvidia.com/compute/cuda/repos/${distro}/${arch}/cuda-archive-keyring.gpg
     
     # 2b. Putting the key in the correct location
     sudo mv cuda-archive-keyring.gpg /usr/share/keyrings/cuda-archive-keyring.gpg
     
     # 2c. Connecting the CUDA repository manually
     echo "deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] \
     https://developer.download.nvidia.com/compute/cuda/repos/${distro}/${arch}/ /" \
     | sudo tee /etc/apt/sources.list.d/cuda-${distro}-${arch}.list
   }
   
   # 3. Updating the list of packages
   sudo apt update
   
   # 4. Installing NVIDIA drivers
   sudo apt install -y nvidia-open
   
   # 5. Installing the CUDA driver metapackage
   sudo apt install -y cuda-drivers
   ```

   {% endcut %}

1. You need to go through the next steps before you reboot the system via `sudo reboot`.
   Create a script named `/usr/libexec/manage-nvidia`:

   ```bash
   #!/bin/bash
   set -eu
   usage() {
            echo "usage: manage-nvidia (load|unload)"
            exit 1
   }
   [ $# -eq 1 ] || usage
   case "$1" in
            load)   modprobe nvidia ;;
            unload) modprobe -r nvidia_uvm nvidia_drm nvidia_modeset nvidia ;;
            *)      usage ;;
   esac
   ```

1. Make the script executable:

   ```bash
   sudo chmod +x /usr/libexec/manage-nvidia
   ```

1. Create a systemd unit named `/etc/systemd/system/manage-nvidia.service`:

   ```ini
   [Unit]
   Description=Manage NVIDIA driver
   Before=nvidia-persistenced.service
   
   [Service]
   Type=oneshot
   ExecStart=/usr/libexec/manage-nvidia load
   RemainAfterExit=true
   ExecStop=/usr/libexec/manage-nvidia unload
   StandardOutput=journal
   
   [Install]
   WantedBy=multi-user.target
   RequiredBy=nvidia-persistenced.service
   ```

1. Reload the `systemd` configuration, configure `manage-nvidia` to autorun on boot, and start the service itself:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable --now manage-nvidia
   ```

   Expected output if the execution is successful:

   ```
   Created symlink /etc/systemd/system/multi-user.target.wants/manage-nvidia.service → /etc/systemd/system/manage-nvidia.service.
   Created symlink /etc/systemd/system/nvidia-persistenced.service.requires/manage-nvidia.service → /etc/systemd/system/manage-nvidia.service.
   ```

   Check `nvidia-persistenced.service` for dependency on `manage-nvidia.service`:

   ```bash
   sudo systemctl list-dependencies nvidia-persistenced | grep manage-nvidia   
   ```

   Result:
   ```bash
   ● ├─manage-nvidia.service
   ```

   Check the service status:

   ```
   sudo systemctl status manage-nvidia
   ```

With that done, during `sudo reboot`, systemd will call `ExecStop` for `manage-nvidia`, the driver will be uploaded correctly, and rebooting will not invalidate the GPU.