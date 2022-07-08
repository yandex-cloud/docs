
Для виртуальных машин на платформах {{ v100-broadwell }} и {{ v100-cascade-lake }} доступны специальные образы операционных систем Windows из {{ marketplace-name }} — [2016 Datacenter GPU](/marketplace/products/yc/windows-server-2016-datacenter-gpu) (`windows-2016-gvlk-gpu`) и Ubuntu — [16.04 LTS GPU](/marketplace/products/yc/ubuntu-16-04-lts-gpu) (`ubuntu-1604-lts-gpu`) и [20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`), на которых установлены драйверы NVIDIA. 

Для виртуальных машин на платформе {{ t4-ice-lake }} доступен образ операционной системы Ubuntu — [20.04 LTS GPU](/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`).


Для виртуальных машин на платформе {{ a100-epyc }} доступен специальный образ операционной системы Ubuntu — [20.04 LTS GPU A100](/marketplace/products/yc/ubuntu-20-04-lts-gpu-a100) (`ubuntu-2004-lts-gpu-a100`). Мы рекомендуем использовать стандартный образ от {{ yandex-cloud }}. Вы также можете  [установить драйверы](../../compute/operations/vm-operate/install-nvidia-drivers.md) на другой стандартный образ самостоятельно или [создать собственный образ](../../compute/operations/image-create/custom-image.md) с предустановленными драйверами. 
