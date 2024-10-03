Для виртуальных машин с GPU доступны специальные образы операционных систем с драйверами NVIDIA:

{{ v100-broadwell }} и {{ v100-cascade-lake }}

: * [Ubuntu 16.04 LTS GPU](/marketplace/products/yc/ubuntu-16-04-lts-gpu) (`ubuntu-1604-lts-gpu`)
  * [Ubuntu 20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)

{{ t4-ice-lake }}

: * [Ubuntu 20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)

{{ a100-epyc }}

: * [Ubuntu 20.04 LTS GPU A100](/marketplace/products/yc/ubuntu-20-04-lts-gpu-a100) (`ubuntu-2004-lts-a100`)
  * [Ubuntu 18.04 LTS GPU A100](/marketplace/products/yc/ubuntu-18-04-lts-gpu-a100) (`ubuntu-1804-lts-a100`)

Мы рекомендуем использовать стандартный образ от {{ yandex-cloud }}. Вы также можете [установить драйверы](../../compute/operations/vm-operate/install-nvidia-drivers.md) на другой стандартный образ самостоятельно или [создать собственный образ](../../compute/operations/image-create/custom-image.md) с предустановленными драйверами.