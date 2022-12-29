{% if product == "yandex-cloud" %}

For virtual machines running on {{ v100-broadwell }} and {{ v100-cascade-lake }}, special images of {% if product == "cloud-il" %}Windows from {{ marketplace-name }}, such as [2016 Datacenter GPU](/marketplace/products/yc/windows-server-2016-datacenter-gpu) (`windows-2016-gvlk-gpu`) and {% endif %}Ubuntu ([16.04 LTS GPU](/marketplace/products/yc/ubuntu-16-04-lts-gpu) (`ubuntu-1604-lts-gpu`) and [20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`), are available with NVIDIA drivers installed.

For virtual machines running on {{ t4-ice-lake }}, an Ubuntu image is available ([20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu), `ubuntu-2004-lts-gpu`).

{% endif %}

For virtual machines running on {{ a100-epyc }}, the following special images of Linux{% if product == "cloud-il" %} and Windows{% endif %} are available:

* [Ubuntu 20.04 LTS GPU A100](/marketplace/products/yc/ubuntu-20-04-lts-gpu-a100) (`ubuntu-2004-lts-gpu-a100`).

{% if product == "cloud-il" %}

* [Windows Server 2022 Datacenter GPU A100](/marketplace/products/yc/windows-server-2022-datacenter-gpu-a100) (`windows-server-2022-datacenter-gpu-a100`).

{% endif %}

We recommend using a standard image from {{ yandex-cloud }}. You can also [install the drivers](../../compute/operations/vm-operate/install-nvidia-drivers.md) on another standard image yourself or [create a custom image](../../compute/operations/image-create/custom-image.md) with preinstalled drivers.
