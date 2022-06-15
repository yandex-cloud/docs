{% if product == "yandex-cloud" %}

For VM instances running on the {{ v100-broadwell }} и {{ v100-cascade-lake }} platforms, a special Ubuntu images is available: Windows — [2016 Datacenter GPU](/marketplace/products/f2eob03q1b62vg3fhe0t) (`windows-2016-gvlk-gpu`), Ubuntu — [16.04 LTS GPU](/marketplace/products/f2e9r8mdna9u5kvs59sl) (`ubuntu-1604-lts-gpu`) and [20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`). The images have NVIDIA drivers pre-installed.

For VM instances running on the {{  t4-ice-lake }} platform, an Ubuntu image is available: [20.04 LTS GPU A100](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`).

{% endif %}

For VM instances running on the {{ a100-epyc }} platform, a special Ubuntu image is available: [20.04 LTS GPU A100](/marketplace/products/yc/ubuntu-20-04-lts-gpu-a100) (`ubuntu-2004-lts-gpu-a100`). We recommend using a standard image from {{ yandex-cloud }}. You can also [install the drivers](../../compute/operations/vm-operate/install-nvidia-drivers.md) on another standard image yourself or [create a custom image](../../compute/operations/image-create/custom-image.md) with preinstalled drivers.