# Графические ускорители GPU


Compute Cloud предоставляет графические ускорители ([GPU](../../glossary/gpu.md)) в различных [конфигурациях](#config) виртуальных машин. GPU обрабатывают некоторые типы данных эффективнее, чем CPU, и могут использоваться для сложных вычислений. Сделать решение задач еще эффективнее и удобнее поможет автоматическое выделение ресурсов в [Yandex DataSphere](../../datasphere/concepts/index.md).

В Compute Cloud доступны следующие графические карты:
* [NVIDIA® Tesla® V100](https://www.nvidia.com/en-gb/data-center/tesla-v100/) с 32 ГБ памяти HBM2 (High Bandwidth Memory).
* [NVIDIA® Ampere® A100](https://www.nvidia.com/ru-ru/data-center/a100/) с 80 ГБ памяти HBM2.
* [NVIDIA® Tesla® T4](https://www.nvidia.com/ru-ru/data-center/tesla-t4/) с 16 ГБ памяти GDDR6.

{% note warning %}

GPU работает в режиме [TCC](https://docs.nvidia.com/nsight-visual-studio-edition/reference/index.html#tesla-compute-cluster), который не использует графические драйверы операционной системы.

{% endnote %}

По умолчанию в облаке установлена нулевая [квота](limits.md#compute-quotas) на создание виртуальных машин с GPU. Вы можете запросить увеличение квоты в [консоли управления](https://console.yandex.cloud/cloud?section=quotas). Для этого нужна [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше.


## Графические ускорители (GPU) {#gpu}

Графические ускорители подходят для задач машинного обучения (Machine Learning, ML), искусственного интеллекта (Artificial Intelligence, AI) и обработки трехмерной графики (3D Rendering).

Контролировать GPU и RAM можно непосредственно с ВМ.


### NVIDIA® Tesla® V100 {#tesla-v100}

Графическая карта NVIDIA® Tesla® V100 содержит 5120 ядер CUDA®, позволяющих выполнять [высокопроизводительные вычисления](https://www.nvidia.com/ru-ru/high-performance-computing/) (High Performance Computing, HPC), а также 640 ядер Tensor, позволяющих решать задачи глубокого обучения (Deep Learning, DL).


### NVIDIA® Ampere® A100 {#a100}

NVIDIA® A100, построенная на базе микроархитектуры [Ampere®](https://www.nvidia.com/ru-ru/data-center/ampere-architecture/), использует тензорные ядра третьего поколения и предоставляет 80 ГБ памяти HBM2 с пропускной способностью до 2 ТБ/с.


### NVIDIA® Tesla® T4 {#tesla-t4}

NVIDIA® Tesla® T4, построенная на базе архитектуры [Turing™](https://images.nvidia.com/aem-dam/en-zz/Solutions/design-visualization/technologies/turing-architecture/NVIDIA-Turing-Architecture-Whitepaper.pdf), использует тензорные ядра Turing и ядра RT, предоставляет 16 ГБ памяти GDDR6 с [пропускной способностью 300 ГБ/с](https://www.nvidia.com/content/dam/en-zz/Solutions/Data-Center/tesla-t4/t4-tensor-core-datasheet-951643.pdf).


### T4i {#t4i}

T4i использует тензорные ядра и предоставляет 24 ГБ памяти GDDR6 с пропускной способностью 300 ГБ/с.


### Конфигурации виртуальных машин {#config}

Доступные конфигурации вычислительных ресурсов:

* Платформа Intel Broadwell with NVIDIA® Tesla® V100 (`gpu-standard-v1`):

  Количество GPU | Объем VRAM, ГБ | Количество vCPU | Объем RAM, ГБ
  --- | --- | --- | ---
  1 | 32 | 8 | 96
  2 | 64 | 16 | 192
  4 | 128 | 32 | 384

* Платформа Intel Cascade Lake with NVIDIA® Tesla® V100 (`gpu-standard-v2`):

  Количество GPU | Объем VRAM, ГБ | Количество vCPU | Объем RAM, ГБ
  --- | --- | --- | ---
  1 | 32 | 8 | 48
  2 | 64 | 16 | 96
  4 | 128 | 32 | 192
  8 | 256 | 64 | 384

* Платформа AMD EPYC™ with NVIDIA® Ampere® A100 (`gpu-standard-v3`):

  Количество GPU | Объем VRAM, ГБ | Количество vCPU | Объем RAM, ГБ
  --- | --- | --- | ---
  1 | 80 | 28 | 119
  2 | 160 | 56 | 238
  4 | 320 | 112 | 476
  8 | 640 | 224 | 952

* Платформа Gen2 (`gpu-standard-v3i`):

  Количество GPU | Объем VRAM, ГБ | Количество vCPU | Объем RAM, ГБ
  --- | --- | --- | ---
  1 | 80 | 18 | 144
  2 | 160 | 36 | 288
  4 | 320 | 72 | 576
  8 | 640 | 180 | 1440
  
* Платформа Intel Ice Lake with NVIDIA® Tesla® T4 (`standard-v3-t4`):

  Количество GPU | Объем VRAM, ГБ | Количество vCPU | Объем RAM, ГБ
  --- | --- | --- | ---
  1 | 16 | 4 | 16
  1 | 16 | 8 | 32
  1 | 16 | 16 | 64
  1 | 16 | 32 | 128

* Платформа Intel Ice Lake with T4i (`standard-v3-t4i`):

  Количество GPU | Объем VRAM, ГБ | Количество vCPU | Объем RAM, ГБ
  --- | --- | --- | ---
  1 | 24 | 4 | 16
  1 | 24 | 8 | 32
  1 | 24 | 16 | 64
  1 | 24 | 32 | 128

* Платформа GPU PLATFORM V4 (`gpu-standard-v4`):

  Количество GPU | Объем VRAM, ГБ | Количество vCPU | Объем RAM, ГБ
  --- | --- | --- | ---
  1 | 141 | 22 | 220
  2 | 242 | 44 | 440
  4 | 484 | 88 | 880
  8 | 968 | 180 | 1800

GPU в виртуальных машинах предоставляется целиком. Например, если в конфигурации указано 4 GPU, то у вашей ВМ будет 4 полноценных GPU-устройства.

Виртуальные машины на платформах Intel Broadwell with NVIDIA® Tesla® V100, Intel Cascade Lake with NVIDIA® Tesla® V100 и AMD EPYC™ with NVIDIA® Ampere® A100 можно создать в зонах доступности `ru-central1-a` и `ru-central1-b`.

Ознакомиться с организационными и техническими ограничениями ВМ можно в разделе [Квоты и лимиты](limits.md).

Стоимость виртуальных машин с GPU приведена в разделе [Цены для региона Россия](../pricing.md#prices).


### Образы операционных систем {#os}

Для виртуальных машин с GPU доступны специальные образы операционных систем с драйверами NVIDIA:

Intel Broadwell with NVIDIA® Tesla® V100 и Intel Cascade Lake with NVIDIA® Tesla® V100

: * [Ubuntu 18.04 LTS GPU](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-18-04-lts-gpu) (`ubuntu-1804-lts-gpu`)
  * [Ubuntu 20.04 LTS GPU](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)

Intel Ice Lake with NVIDIA® Tesla® T4

: * [Ubuntu 20.04 LTS GPU](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts-gpu) (`ubuntu-2004-lts-gpu`)

Intel Ice Lake with T4i

: * [Ubuntu 22.04 LTS GPU CUDA 12.2](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2204-lts-cuda-12-2) (`ubuntu-2204-lts-cuda-12-2`)

AMD EPYC™ with NVIDIA® Ampere® A100

: * [Ubuntu 22.04 LTS GPU CUDA 12.2](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2204-lts-cuda-12-2) (`ubuntu-2204-lts-cuda-12-2`)

  Для поддержки кластерного режима:
: * [Ubuntu 20.04 LTS GPU Cluster](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2004-lts-gpu-cluster)(`ubuntu-2004-lts-gpu-cluster`)

Gen2

: * [Ubuntu 20.04 LTS Secure Boot CUDA 12.2](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2004-lts-secureboot-cuda-12-2) (`ubuntu-2004-lts-secureboot-cuda-12-2`)

Мы рекомендуем использовать стандартный образ от Yandex Cloud. Вы также можете [установить драйверы](../operations/vm-operate/install-nvidia-drivers.md) на другой стандартный образ самостоятельно или [создать собственный образ](../operations/image-create/custom-image.md) с предустановленными драйверами.

{% note info %}

Compute Cloud проверяет работоспособность и рекомендует устанавливать только [LTS версии драйверов](https://docs.nvidia.com/datacenter/tesla/drivers/releases.json).

При установке драйверов для платформы `gpu-standard-v3` (AMD EPYC™ with NVIDIA® Ampere® A100) указывайте совместимую версию драйвера — `535`.

Мы рекомендуем использовать именно эту версию драйвера — обновление до других версий не поддерживается и может привести к нестабильной работе GPU.

{% endnote %}


## Кластеры GPU {#gpu-clusters}

Вы можете объединить в [кластер](../../glossary/cluster.md) несколько виртуальных машин. Объединение позволяет ускорить выполнение задач распределенного обучения, требующих больших вычислительных мощностей, чем предоставляют отдельные ВМ. Кластер должен создаваться в той же зоне доступности, что и ВМ, которые будут в него входить. ВМ внутри кластера объединены высокоскоростной и защищенной сетью Infiniband. 

В кластер можно добавить машины из разных каталогов и из разных сетей и подсетей. Для корректного взаимодействия виртуальных машин, включенных в кластер, рекомендуется использовать [группу безопасности](../../vpc/concepts/security-groups.md), разрешающую неограниченный трафик внутри группы. Группа безопасности по умолчанию удовлетворяет этому требованию. Если группа безопасности по умолчанию была отредактирована, добавьте группу, обеспечивающую неограниченный обмен трафиком внутри себя, вручную.

Максимальный возможный размер кластера на платформе Gen2 — 20 ВМ с конфигурацией 8 GPU, 80 ГБ VRAM, 180 vCPU, 1440 ГБ RAM. Фактический максимальный размер кластера ограничен технической доступностью ресурсов.

## Смотрите также {#see-also}

* [Создание виртуальной машины с GPU](../operations/vm-create/create-vm-with-gpu.md).
* Узнайте, как [добавить GPU к существующей ВМ](../operations/vm-control/vm-update-resources.md#add-gpu).
* Узнайте, как [изменить количество GPU](../operations/vm-control/vm-update-resources.md#update-gpu).
* [Вопросы про GPU](../qa/gpu.md).