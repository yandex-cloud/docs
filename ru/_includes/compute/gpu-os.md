Для виртуальных машин с GPU доступны специальные образы операционных систем с драйверами NVIDIA:

{{ v100-broadwell }} и {{ v100-cascade-lake }}

: * [Ubuntu 18.04 LTS GPU](/marketplace/products/yc/ubuntu-18-04-lts-gpu) (`ubuntu-1804-lts-gpu`)
  * [Ubuntu 20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)

{{ t4-ice-lake }}

: * [Ubuntu 20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)

{{ t4i-ice-lake }}

: * [Ubuntu 22.04 LTS GPU CUDA 12.2](/marketplace/products/yc/ubuntu-2204-lts-cuda-12-2) (`ubuntu-2204-lts-cuda-12-2`)

{{ a100-epyc }}

: * [Ubuntu 22.04 LTS GPU CUDA 12.2](/marketplace/products/yc/ubuntu-2204-lts-cuda-12-2) (`ubuntu-2204-lts-cuda-12-2`)

  Для поддержки кластерного режима:
: * [Ubuntu 20.04 LTS GPU Cluster](/marketplace/products/yc/ubuntu-2004-lts-gpu-cluster)(`ubuntu-2004-lts-gpu-cluster`)

AMD EPYC™ 9474F with Gen2

: * [Ubuntu 20.04 LTS Secure Boot CUDA 12.2](/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2) (`ubuntu-2004-lts-secureboot-cuda-12-2`)

Мы рекомендуем использовать стандартный образ от {{ yandex-cloud }}. Вы также можете [установить драйверы](../../compute/operations/vm-operate/install-nvidia-drivers.md) на другой стандартный образ самостоятельно или [создать собственный образ](../../compute/operations/image-create/custom-image.md) с предустановленными драйверами.