
For virtual machines running on {{ v100-broadwell }} and {{ v100-cascade-lake }}, you can use special images of Ubuntu, such as [16.04 LTS GPU](/marketplace/products/yc/ubuntu-16-04-lts-gpu) (`ubuntu-1604-lts-gpu`) and [20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`). These images have the NVIDIA drivers installed.

For virtual machines running on {{ t4-ice-lake }}, you can use the [20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`) Ubuntu image.


For virtual machines running on {{ a100-epyc }}, the following special images of Linux are available:

* [Ubuntu 20.04 LTS GPU A100](/marketplace/products/yc/ubuntu-20-04-lts-gpu-a100) (`ubuntu-2004-lts-gpu-a100`).


We recommend using a standard image from {{ yandex-cloud }}. You can also [install the drivers](../../compute/operations/vm-operate/install-nvidia-drivers.md) on another standard image yourself or [create a custom image](../../compute/operations/image-create/custom-image.md) with pre-installed drivers.
