# Графические ускорители (GPU)

{{ compute-full-name }} предоставляет графические ускорители (GPU) в составе графических карт. GPU обрабатывают некоторые типы данных эффективнее, чем vCPU, и могут использоваться для сложных вычислений.

В {{ compute-short-name }} доступны графические карты [NVIDIA® Tesla® V100](https://www.nvidia.com/ru-ru/data-center/tesla-v100/) с 32 ГБ памяти HBM2.

Графическая карта NVIDIA® Tesla® V100 содержит 5120 ядер CUDA®, позволяющих выполнять [высокопроизводительные вычисления](https://www.nvidia.com/ru-ru/high-performance-computing/) (High Performance Computing, HPC), а также 640 ядер Tensor, позволяющих решать задачи глубокого обучения (Deep Learning, DL).

Кроме того, графические ускорители подходят для задач машинного обучения (Machine Learning, ML), искусственного интеллекта (Artificial Intelligence, AI) и обработки трехмерной графики (3D Rendering).

Контролировать GPU и RAM можно непосредственно с виртуальной машины.

## Конфигурации виртуальных машин {#config}

Доступные конфигурации вычислительных ресурсов:

* Платформа Intel Broadwell with NVIDIA® Tesla® V100 (`gpu-standard-v1`):

  Количество GPU | Количество vCPU | Объем RAM, ГБ |
  --- | --- | ---
  1 | 8 | 96
  2 | 16 | 192
  4 | 32 | 384

* Платформа Intel Cascade Lake with NVIDIA® Tesla® V100 (`gpu-standard-v2`):

  Количество GPU | Количество vCPU | Объем RAM, ГБ |
  --- | --- | ---
  1 | 8 | 48
  2 | 16 | 96
  4 | 32 | 192
  8 | 64 | 384

Ознакомиться с организационными и техническими ограничениями виртуальных машин можно в разделе [Квоты и лимиты](../concepts/limits.md).

## Образы операционных систем {#os}

{% include [gpu-os](../../_includes/compute/gpu-os.md) %}

## Смотрите также {#see-also}

* [Создайте виртуальную машину с GPU](../operations/vm-create/create-vm-with-gpu.md).
* Узнайте, как [добавить GPU к существующей виртуальной машине](../operations/vm-control/vm-update-resources.md#add-gpu).
* Узнайте, как [изменить количество GPU](../operations/vm-control/vm-update-resources.md#update-gpu).