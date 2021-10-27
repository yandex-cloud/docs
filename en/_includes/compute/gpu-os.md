For VMs on {{ v100-broadwell }} and {{ v100-cascade-lake }}, special images of Windows ([2016 Datacenter GPU](https://cloud.yandex.com/en-ru/marketplace/products/f2eob03q1b62vg3fhe0t), `windows-2016-gvlk-gpu`) and Ubuntu ([16.04 lts GPU](https://cloud.yandex.com/en-ru/marketplace/products/f2e9r8mdna9u5kvs59sl), `ubuntu-1604-lts-gpu`) are available with NVIDIA drivers installed.

Existing images are not fit for {{ a100-epyc }}. [Install the drivers](../../compute/operations/vm-operate/install-nvidia-drivers.md) on another standard image yourself or [create a custom image](../../compute/operations/image-create/custom-image.md) with preinstalled drivers. We recommend switching to using a standard image from {{ yandex-cloud }} as soon as it's available in the Marketplace.

