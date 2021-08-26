---
title: "GPU и vGPU – графические ускорители"
description: "GPU (Graphics Processing Unit) – это графический процессор, который обрабатывает некоторые типы данных намного эффективнее, чем vCPU. Может использоваться для сложных вычислений. Compute Cloud предоставляет графические ускорители (GPU) и виртуальные графические ускорители (vGPU) в составе графических карт."
---

# Графические ускорители GPU и vGPU

{{ compute-short-name }} предоставляет графические ускорители (GPU) и виртуальные графические ускорители (vGPU) в составе графических карт. GPU обрабатывают некоторые типы данных эффективнее, чем vCPU, и могут использоваться для сложных вычислений.

В {{ compute-short-name }} доступны графические карты [NVIDIA® Tesla® V100](https://www.nvidia.com/ru-ru/data-center/tesla-v100/) с 32 ГБ памяти HBM2 (High Bandwidth Memory).

{% note warning %}

В отличие от vGPU, GPU работает в режиме [TCC](https://docs.nvidia.com/nsight-visual-studio-edition/reference/index.html#tesla-compute-cluster), который не использует графические драйверы операционной системы.

{% endnote %}

По умолчанию в облаке установлена нулевая [квота](../concepts/limits.md#quotas) на создание виртуальных машин с GPU и vGPU. Чтобы изменить квоту, обратитесь в [техническую поддержку]({{ link-console-support }}).

## Графические ускорители (GPU) {#gpu}

Графическая карта NVIDIA® Tesla® V100 содержит 5120 ядер CUDA®, позволяющих выполнять [высокопроизводительные вычисления](https://www.nvidia.com/ru-ru/high-performance-computing/) (High Performance Computing, HPC), а также 640 ядер Tensor, позволяющих решать задачи глубокого обучения (Deep Learning, DL).

Кроме того, графические ускорители подходят для задач машинного обучения (Machine Learning, ML), искусственного интеллекта (Artificial Intelligence, AI) и обработки трехмерной графики (3D Rendering).

Контролировать GPU и RAM можно непосредственно с виртуальной машины.

### Конфигурации виртуальных машин {#config}

Доступные конфигурации вычислительных ресурсов:

* Платформа Intel Broadwell with NVIDIA® Tesla® V100 (`gpu-standard-v1`):

  Количество GPU | Количество vCPU | Объем RAM, ГБ
  --- | --- | ---
  1 | 8 | 96
  2 | 16 | 192
  4 | 32 | 384

* Платформа Intel Cascade Lake with NVIDIA® Tesla® V100 (`gpu-standard-v2`):

  Количество GPU | Количество vCPU | Объем RAM, ГБ
  --- | --- | ---
  1 | 8 | 48
  2 | 16 | 96
  4 | 32 | 192
  8 | 64 | 384

Ознакомиться с организационными и техническими ограничениями ВМ можно в разделе [Квоты и лимиты](../concepts/limits.md).

### Образы операционных систем {#os}

{% include [gpu-os](../../_includes/compute/gpu-os.md) %}

## Виртуальные графические ускорители (vGPU) {#vgpu}

{{ compute-short-name }} предоставляет возможность виртуализации графических ускорителей (GPU). Виртуализация машин с GPU основана на технологии [NVIDIA® vGPU](https://www.nvidia.com/ru-ru/data-center/virtualization/).

Технология NVIDIA® vGPU позволяет использовать карты с GPU как для решения графических, так и для вычислительных задач на vGPU. Для этого вам понадобятся соответствующие [лицензии](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/solutions/resources/documents1/Virtual-GPU-Packaging-and-Licensing-Guide.pdf).

Чтобы воспользоваться технологией vGPU, необходимы:
* ВМ на [платформе](vm-platforms.md) `vgpu-standard-v1` с одним из образов:
  * [Ubuntu 18.04 lts vGPU](https://cloud.yandex.ru/marketplace/products/f2e8k6h1vu1rc360rr0h);
  * [Windows Server 2019 Datacenter vGPU](https://cloud.yandex.ru/marketplace/products/f2ent6cnb49sf5n9s1u2).
* Лицензия для использования технологии [NVIDIA® vGPU](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/solutions/resources/documents1/Virtual-GPU-Packaging-and-Licensing-Guide.pdf).
* Сервер лицензий [NVIDIA® vGPU Software License Server](https://docs.nvidia.com/grid/ls/latest/grid-license-server-user-guide/index.html).

Для работы с лицензией вы можете:
* Использовать свой текущий сервер лицензий.
  Текущий сервер лицензий должен быть доступен по сети из ВМ с vGPU.
* Создать ВМ с сервером лицензий NVIDIA® vGPU Software License Server в {{ yandex-cloud }}.
  Как установить и настроить сервер лицензий читайте в [документации NVIDIA](https://docs.nvidia.com/grid/ls/latest/grid-license-server-user-guide/index.html#installing-nvidia-grid-license-server).

### Конфигурации виртуальных машин с vGPU {#config-vgpu}

Для ВМ с vGPU доступна конфигурация на платформе Intel Broadwell with NVIDIA® vGPU Tesla® V100 8G (`vgpu-standard-v1`):

Количество vGPU | Количество vCPU | Объем RAM, ГБ | Объем GPU RAM, ГБ
--- | --- | --- | ---
1 | 4 | 12 | 8

## Сравнение GPU и vGPU

{% include [gpu-vs-vgpu](../../_includes/compute/gpu-comparation.md) %}

## Смотрите также {#see-also}

* [{#T}](../operations/vm-create/create-vm-with-gpu.md).
* Узнайте, как [добавить GPU к существующей ВМ](../operations/vm-control/vm-update-resources.md#add-gpu).
* Узнайте, как [изменить количество GPU](../operations/vm-control/vm-update-resources.md#update-gpu).