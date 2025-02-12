The following special OS images with NVIDIA drivers pre-installed are available for VMs with GPUs:

{{ v100-broadwell }} and {{ v100-cascade-lake }}

: * [Ubuntu 18.04 LTS GPU](/marketplace/products/yc/ubuntu-18-04-lts-gpu) (`ubuntu-1804-lts-gpu`)
  * [Ubuntu 20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)

{{ t4-ice-lake }}

: * [Ubuntu 20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)

{{ t4i-ice-lake }}

: * [Ubuntu 24.04 LTS GPU](/marketplace/products/yc/ubuntu-2404-lts-oslogin) (`ubuntu-2404-lts-oslogin`)

{{ a100-epyc }}

: * [Ubuntu 20.04 LTS GPU A100](/marketplace/products/yc/ubuntu-20-04-lts-gpu-a100) (`ubuntu-2004-lts-a100`)
  * [Ubuntu 18.04 LTS GPU A100](/marketplace/products/yc/ubuntu-18-04-lts-gpu-a100) (`ubuntu-1804-lts-a100`)

We recommend using a standard {{ yandex-cloud }} image. You can also manually [install the drivers](../../compute/operations/vm-operate/install-nvidia-drivers.md) on another standard image or [create a custom image](../../compute/operations/image-create/custom-image.md) with pre-installed drivers.