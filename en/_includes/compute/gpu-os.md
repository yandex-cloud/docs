For VMs with GPUs, you can use the following special images of operating systems with NVIDIA drivers:


{{ v100-broadwell }} and {{ v100-cascade-lake }}

: * [Ubuntu 16.04 LTS GPU](/marketplace/products/yc/ubuntu-16-04-lts-gpu) (`ubuntu-1604-lts-gpu`)
  * [Ubuntu 20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)

{{ t4-ice-lake }}

: * [Ubuntu 20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)

{{ a100-epyc }}

: * [Ubuntu 20.04 LTS GPU A100](/marketplace/products/yc/ubuntu-20-04-lts-gpu-a100) (`ubuntu-2004-lts-a100`)
  * [Ubuntu 18.04 LTS GPU A100](/marketplace/products/yc/ubuntu-18-04-lts-gpu-a100) (`ubuntu-1804-lts-a100`)



We recommend using a standard image from {{ yandex-cloud }}. You can also [install the drivers](../../compute/operations/vm-operate/install-nvidia-drivers.md) on another standard image yourself or [create a custom image](../../compute/operations/image-create/custom-image.md) with pre-installed drivers.
