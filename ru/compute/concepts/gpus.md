---
title: "GPU – графические ускорители"
description: "GPU (Graphics Processing Unit) – это графический процессор, который обрабатывает некоторые типы данных намного эффективнее, чем vCPU. Может использоваться для сложных вычислений. {{ compute-name }} предоставляет графические ускорители (GPU) в составе графических карт."
---

# Графические ускорители GPU

{{ compute-name }} предоставляет графические ускорители ([GPU](../../glossary/gpu.md)) в различных [конфигурациях](#config) виртуальных машин. GPU обрабатывают некоторые типы данных эффективнее, чем CPU, и могут использоваться для сложных вычислений. Сделать решение задач еще эффективнее и удобнее поможет автоматическое выделение ресурсов в [{{ ml-platform-full-name }}](../../datasphere/concepts/index.md).

В {{ compute-name }} доступны следующие графические карты:
* [NVIDIA® Tesla® V100](https://www.nvidia.com/ru-ru/data-center/tesla-v100/) с 32 ГБ памяти HBM2 (High Bandwidth Memory). 
* [NVIDIA® Ampere® A100](https://www.nvidia.com/ru-ru/data-center/a100/) с 80 ГБ памяти HBM2.
* [NVIDIA® Tesla® T4](https://www.nvidia.com/ru-ru/data-center/tesla-t4/) с 16 ГБ памяти GDDR6.

{% note warning %}

GPU работает в режиме [TCC](https://docs.nvidia.com/nsight-visual-studio-edition/reference/index.html#tesla-compute-cluster), который не использует графические драйверы операционной системы.

{% endnote %}

{% include [gpu-zero-quota](../../_includes/compute/gpu-zero-quota.md) %}


ВМ с GPU нельзя создавать в зоне доступности `{{ region-id }}-c`. Подробнее см. в разделе [{#T}](../../overview/concepts/ru-central1-c-deprecation.md).


## Графические ускорители (GPU) {#gpu}

Графические ускорители подходят для задач машинного обучения (Machine Learning, ML), искусственного интеллекта (Artificial Intelligence, AI) и обработки трехмерной графики (3D Rendering).

Контролировать GPU и RAM можно непосредственно с ВМ.


### NVIDIA® Tesla® V100 {#tesla-v100}

Графическая карта NVIDIA® Tesla® V100 содержит 5120 ядер CUDA®, позволяющих выполнять [высокопроизводительные вычисления](https://www.nvidia.com/ru-ru/high-performance-computing/) (High Performance Computing, HPC), а также 640 ядер Tensor, позволяющих решать задачи глубокого обучения (Deep Learning, DL).


### NVIDIA® Ampere® A100 {#a100}

NVIDIA® A100, построенная на базе микроархитектуры [Ampere®](https://www.nvidia.com/ru-ru/data-center/ampere-architecture/), использует тензорные ядра третьего поколения и предоставляет 80 ГБ памяти HBM2 с пропускной способностью до 2 ТБ/с.


### NVIDIA® Tesla® T4 {#tesla-t4}

NVIDIA® Tesla® T4, построенная на базе архитектуры [Turing™](https://images.nvidia.com/aem-dam/en-zz/Solutions/design-visualization/technologies/turing-architecture/NVIDIA-Turing-Architecture-Whitepaper.pdf), использует тензорные ядра Turing и ядра RT, предоставляет 16 ГБ памяти GDDR6 с [пропускной способностью 300 ГБ/с](https://www.nvidia.com/content/dam/en-zz/Solutions/Data-Center/tesla-t4/t4-tensor-core-datasheet-951643.pdf).





### Конфигурации виртуальных машин {#config}

Доступные конфигурации вычислительных ресурсов:


* Платформа {{ v100-broadwell }} (`gpu-standard-v1`):

  Количество GPU | Объем VRAM, ГБ | Количество vCPU | Объем RAM, ГБ
  --- | --- | --- | ---
  1 | 32 | 8 | 96
  2 | 64 | 16 | 192
  4 | 128 | 32 | 384

* Платформа {{ v100-cascade-lake }} (`gpu-standard-v2`):

  Количество GPU | Объем VRAM, ГБ | Количество vCPU | Объем RAM, ГБ
  --- | --- | --- | ---
  1 | 32 | 8 | 48
  2 | 64 | 16 | 96
  4 | 128 | 32 | 192
  8 | 256 | 64 | 384


* Платформа {{ a100-epyc }} (`gpu-standard-v3`):

  Количество GPU | Объем VRAM, ГБ | Количество vCPU | Объем RAM, ГБ
  --- | --- | --- | ---
  1 | 80 | 28 | 119
  2 | 160 | 56 | 238
  4 | 320 | 112 | 476
  8 | 640 | 224 | 952

* Платформа {{ t4-ice-lake }} (`standard-v3-t4`):

  
  Количество GPU | Объем VRAM, ГБ | Количество vCPU | Объем RAM, ГБ
  --- | --- | --- | ---
  1 | 16 | 4 | 16
  1 | 16 | 8 | 32
  1 | 16 | 16 | 64
  1 | 16 | 32 | 128




GPU в виртуальных машинах предоставляется целиком. Например, если в конфигурации указано 4 GPU, то у вашей ВМ будет 4 полноценных GPU-устройства.


{% include [gpu-zones](../../_includes/compute/gpu-zones.md) %}


Ознакомиться с организационными и техническими ограничениями ВМ можно в разделе [Квоты и лимиты](../concepts/limits.md).

Стоимость виртуальных машин с GPU см. в разделе [{#T}](../pricing.md#prices-instance-resources).

### Образы операционных систем {#os}

{% include [gpu-os](../../_includes/compute/gpu-os.md) %}


## Кластеры GPU {#gpu-clusters}

{% note info %}

Кластеры GPU переходят в [общий доступ](../../overview/concepts/launch-stages.md) и начнут тарифицироваться 1 сентября 2023 года.

{% endnote %}

Вы можете объединить в кластер несколько виртуальных машин с 8 GPU NVIDIA A100. Объединение позволяет ускорить выполнение задач распределенного обучения, требующих больших вычислительных мощностей, чем предоставляют отдельные ВМ. Кластер должен создаваться в той же зоне доступности, что и ВМ, которые будут в него входить. ВМ внутри кластера объединены высокоскоростной и защищенной сетью Infiniband. 

В кластер можно добавить машины из разных каталогов и из разных сетей и подсетей. Для корректного взаимодействия виртуальных машин, включенных в кластер, рекомендуется использовать [группу безопасности](../../vpc/concepts/security-groups.md), разрешающую неограниченный трафик внутри группы. Группа безопасности по умолчанию удовлетворяет этому требованию. Если группа безопасности по умолчанию была отредактирована, добавьте группу, обеспечивающую неограниченный обмен трафиком внутри себя, вручную.


## Смотрите также {#see-also}

* [{#T}](../operations/vm-create/create-vm-with-gpu.md).
* Узнайте, как [добавить GPU к существующей ВМ](../operations/vm-control/vm-update-resources.md#add-gpu).
* Узнайте, как [изменить количество GPU](../operations/vm-control/vm-update-resources.md#update-gpu).