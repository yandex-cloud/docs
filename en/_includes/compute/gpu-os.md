The following special OS images with NVIDIA drivers pre-installed are available for VMs with GPUs:

{{ v100-broadwell }} and {{ v100-cascade-lake }}

: * [Ubuntu 18.04 LTS GPU](/marketplace/products/yc/ubuntu-18-04-lts-gpu) (`ubuntu-1804-lts-gpu`)
  * [Ubuntu 20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)

{{ t4-ice-lake }}

: * [Ubuntu 20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)

{{ t4i-ice-lake }}

: * [Ubuntu 22.04 LTS GPU CUDA 12.2](/marketplace/products/yc/ubuntu-2204-lts-cuda-12-2) (`ubuntu-2204-lts-cuda-12-2`)

{{ a100-epyc }}

: * [Ubuntu 22.04 LTS GPU CUDA 12.2](/marketplace/products/yc/ubuntu-2204-lts-cuda-12-2) (`ubuntu-2204-lts-cuda-12-2`)

  For cluster mode support:
: * [Ubuntu 20.04 LTS GPU Cluster](/marketplace/products/yc/ubuntu-2004-lts-gpu-cluster)(`ubuntu-2004-lts-gpu-cluster`)

We recommend using a standard {{ yandex-cloud }} image. You can also manually [install the drivers](../../compute/operations/vm-operate/install-nvidia-drivers.md) on another standard image or [create a custom image](../../compute/operations/image-create/custom-image.md) with pre-installed drivers.