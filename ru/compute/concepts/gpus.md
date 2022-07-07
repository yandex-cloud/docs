---
title: "GPU и vGPU – графические ускорители"
description: "GPU (Graphics Processing Unit) – это графический процессор, который обрабатывает некоторые типы данных намного эффективнее, чем vCPU. Может использоваться для сложных вычислений. {{ compute-name }} предоставляет графические ускорители (GPU) и виртуальные графические ускорители (vGPU) в составе графических карт."
---

# Графические ускорители GPU{% if product == "yandex-cloud" %} и vGPU{% endif %}

{{ compute-name }} предоставляет графические ускорители (GPU){% if product == "yandex-cloud" %} и виртуальные графические ускорители (vGPU) в составе графических карт{% endif %}. GPU обрабатывают некоторые типы данных эффективнее, чем vCPU, и могут использоваться для сложных вычислений.

В {{ compute-name }} доступны следующие графические карты:
{% if product == "yandex-cloud" %}* [NVIDIA® Tesla® V100]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/tesla-v100/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/v100/){% endif %} с 32 ГБ памяти HBM2 (High Bandwidth Memory). {% endif %}
* [NVIDIA® Ampere® A100]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/a100/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/a100/){% endif %} с 80 ГБ памяти HBM2.
{% if product == "yandex-cloud" %}* [NVIDIA® Tesla® T4]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/tesla-t4/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/tesla-t4/){% endif %} с 16 ГБ памяти GDDR6. {% endif %}

 {% if product == "yandex-cloud" %}

{% note warning %}

В отличие от vGPU, GPU работает в режиме [TCC](https://docs.nvidia.com/nsight-visual-studio-edition/reference/index.html#tesla-compute-cluster), который не использует графические драйверы операционной системы.

{% endnote %}

{% endif %}

По умолчанию в облаке установлена нулевая [квота](../concepts/limits.md#compute-quotas) на создание виртуальных машин с GPU{% if product == "yandex-cloud" %} и vGPU{% endif %}. Чтобы изменить [квоту]({{ link-console-quotas }}), обратитесь в [техническую поддержку]({{ link-console-support }}).

{% if product == "yandex-cloud" %}

ВМ с GPU и vGPU нельзя создавать в зоне доступности `ru-central1-c`. Подробнее см. в разделе [{#T}](../../overview/concepts/ru-central1-c-deprecation.md).

{% endif %}

## Графические ускорители (GPU) {#gpu}

Графические ускорители подходят для задач машинного обучения (Machine Learning, ML), искусственного интеллекта (Artificial Intelligence, AI) и обработки трехмерной графики (3D Rendering).

Контролировать GPU и RAM можно непосредственно с ВМ.

{% if product == "yandex-cloud" %}

### NVIDIA® Tesla® V100 {#tesla-v100}

Графическая карта NVIDIA® Tesla® V100 содержит 5120 ядер CUDA®, позволяющих выполнять [высокопроизводительные вычисления]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/high-performance-computing/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/high-performance-computing/){% endif %} (High Performance Computing, HPC), а также 640 ядер Tensor, позволяющих решать задачи глубокого обучения (Deep Learning, DL).

{% endif %}

### NVIDIA® Ampere® A100 {#a100}

NVIDIA® A100, построенная на базе микроархитектуры [Ampere®]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/ampere-architecture/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/ampere-architecture/){% endif %}, использует тензорные ядра третьего поколения и предоставляет 80 ГБ памяти HBM2 с пропускной способностью до 2 ТБ/с.

{% if product == "yandex-cloud" %}

### NVIDIA® Tesla® T4 {#tesla-t4}

NVIDIA® Tesla® T4, построенная на базе архитектуры [Turing™](https://images.nvidia.com/aem-dam/en-zz/Solutions/design-visualization/technologies/turing-architecture/NVIDIA-Turing-Architecture-Whitepaper.pdf), использует тензорные ядра Turing и ядра RT, предоставляет 16 ГБ памяти GDDR6 с [пропускной способностью 300 ГБ/с](https://www.nvidia.com/content/dam/en-zz/Solutions/Data-Center/tesla-t4/t4-tensor-core-datasheet-951643.pdf).

{% endif %}

### Конфигурации виртуальных машин {#config}

Доступные конфигурации вычислительных ресурсов:

{% if product == "yandex-cloud" %}

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

{% endif %}

* Платформа {{ a100-epyc }} (`gpu-standard-v3`):

  Количество GPU | Объем VRAM, ГБ | Количество vCPU | Объем RAM, ГБ
  --- | --- | --- | ---
  1 | 80 | 28 | 119
  2 | 160 | 56 | 238
  4 | 320 | 112 | 476
  8 | 640 | 224 | 952

{% if product == "yandex-cloud" %}

* Платформа {{ t4-ice-lake }} (`standard-v3-t4`):

  Количество GPU | Объем VRAM, ГБ | Количество vCPU | Объем RAM, ГБ
  --- | --- | --- | ---
  1 | 16 | 32 | 128

{% include [gpu-zones](../../_includes/compute/gpu-zones.md) %}

{% endif %}

Ознакомиться с организационными и техническими ограничениями ВМ можно в разделе [Квоты и лимиты](../concepts/limits.md).

### Образы операционных систем {#os}

{% include [gpu-os](../../_includes/compute/gpu-os.md) %}

{% if product == "yandex-cloud" %}

## Виртуальные графические ускорители (vGPU) {#vgpu}

{% include [vgpu-to-standard](../../_includes/compute/vgpu-to-standard.md) %}

{{ compute-name }} предоставляет возможность виртуализации графических ускорителей (GPU). Виртуализация машин с GPU основана на технологии [NVIDIA® vGPU]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/virtualization/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/virtual-solutions/){% endif %}.

Технология NVIDIA® vGPU позволяет использовать карты с GPU как для решения графических, так и для вычислительных задач на vGPU. Для этого вам понадобятся соответствующие [лицензии](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/solutions/resources/documents1/Virtual-GPU-Packaging-and-Licensing-Guide.pdf).

Чтобы воспользоваться технологией vGPU, необходимы:
* ВМ на [платформе](vm-platforms.md) `vgpu-standard-v1` с одним из образов:
  * [Ubuntu 18.04 LTS vGPU](/marketplace/products/f2e8k6h1vu1rc360rr0h);
  * [Windows Server 2019 Datacenter vGPU](/marketplace/products/f2ent6cnb49sf5n9s1u2).
* Лицензия [NVIDIA® RTX vWS]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/design-visualization/virtual-workstation/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/design-visualization/virtual-workstation/){% endif %} для использования технологии [NVIDIA® vGPU](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/solutions/resources/documents1/Virtual-GPU-Packaging-and-Licensing-Guide.pdf).
* Сервер лицензий [NVIDIA® vGPU Software License Server](https://docs.nvidia.com/grid/ls/latest/grid-license-server-user-guide/index.html).

Для работы с лицензией вы можете:
* Использовать свой текущий сервер лицензий.

  Текущий сервер лицензий должен быть доступен по сети из ВМ с vGPU.
* Создать ВМ с сервером лицензий NVIDIA® vGPU Software License Server в {{ yandex-cloud }}.

  Как установить и настроить сервер лицензий читайте в [документации NVIDIA](https://docs.nvidia.com/grid/ls/latest/grid-license-server-user-guide/index.html#installing-nvidia-grid-license-server).

### Конфигурации виртуальных машин с vGPU {#config-vgpu}

Для ВМ с vGPU доступна конфигурация на платформе {{ v100-broadwell }} 8G (`vgpu-standard-v1`):

Количество vGPU | Количество vCPU | Объем RAM, ГБ | Объем GPU RAM, ГБ
--- | --- | --- | ---
1 | 4 | 12 | 8

## Сравнение GPU и vGPU

{% include [gpu-vs-vgpu](../../_includes/compute/gpu-comparation.md) %}

{% endif %}

## Смотрите также {#see-also}

* [{#T}](../operations/vm-create/create-vm-with-gpu.md).
* Узнайте, как [добавить GPU к существующей ВМ](../operations/vm-control/vm-update-resources.md#add-gpu).
* Узнайте, как [изменить количество GPU](../operations/vm-control/vm-update-resources.md#update-gpu).