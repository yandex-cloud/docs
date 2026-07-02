[Документация Yandex Cloud](../../index.md) > [Yandex Compute Cloud](../index.md) > [Концепции](index.md) > Виртуальные машины > Платформы

# Платформы


Yandex Compute Cloud предоставляет различные виды физических процессоров. Выбор платформы гарантирует тип физического процессора в дата-центре и определяет набор допустимых конфигураций vCPU и RAM. Также, к виртуальной машине можно добавить графический ускоритель ([GPU](gpus.md)). Платформу необходимо выбирать при создании каждой виртуальной машины.


{% note warning %}

В [зонах доступности](../../overview/concepts/geo-scope.md) `ru-central1-d` и `ru-central1-e` не поддерживаются ВМ на некоторых платформах Compute Cloud. Подробнее читайте в разделе [Ограничения](#restrictions).

{% endnote %}


## Стандартные платформы {#standard-platforms}

Платформа | Процессор | Макс. кол-во ядер (vCPU)</br> на виртуальной машине | Базовая тактовая</br> частота процессора, ГГц
--- | --- | --- | ---
Intel Broadwell</br>(`standard-v1`) | Intel® Xeon® Processor E5-2660 v4 | 32 | 2.00
Intel Cascade Lake</br>(`standard-v2`) | Intel® Xeon® Gold 6230 | 80 | 2.10
Intel Ice Lake</br>(`standard-v3`) | Intel® Xeon® Gold 6338 | 96 | 2.00
AMD Zen 3</br>(`amd-v1`)^1^ | AMD EPYC™ 7713 | 128 | 2.00
AMD Zen 4</br>(`standard-v4a`) | AMD EPYC™ 9654 | 288 | 2.40

^1^ Платформа `amd-v1` доступна в ограниченном количестве для закрытого тестирования на стадии [Preview](../../overview/concepts/launch-stages.md) и тарифицируется. Чтобы запросить доступ к платформе, обратитесь к вашему аккаунт-менеджеру.

{% note warning %}

* ВМ с количеством vCPU больше 256 будут корректно работать только на операционных системах с ядром Linux версии 5.15 и выше. 

* Для ВМ с операционными системами Windows максимальное количество vCPU составляет 224.

{% endnote %}

## Высокопроизводительные платформы {#compute-optimized-platforms}

Платформа | Процессор | Макс. кол-во ядер (vCPU)</br> на виртуальной машине | Базовая тактовая</br> частота процессора, ГГц
--- | --- | --- | ---
Intel Ice Lake Compute-Optimized</br>(`highfreq-v3`) | Intel® Xeon® Processor 6354 | 56 | 3.00
AMD Zen 4 Compute-Optimized</br>(`highfreq-v4a`) | AMD EPYC™ 9374F | 80 | 3.85

## Платформы с GPU {#gpu-platforms}

Платформа | Графический</br> ускоритель | Процессор | Характеристики
--- | --- | --- | ---
Intel Broadwell with</br>NVIDIA® Tesla® V100</br>(`gpu-standard-v1`) | [NVIDIA® Tesla® V100](https://www.nvidia.com/ru-ru/data-center/tesla-v100/) | Intel® Xeon®</br>Processor E5-2660 v4 | **Макс. кол-во GPU на 1 ВМ**: 4 </br> **Кол-во vCPU на 1 GPU**: 8 </br> **Объем RAM на 1 GPU**: 96 ГБ
Intel Cascade Lake</br>with NVIDIA® Tesla® V100</br>(`gpu-standard-v2`) | [NVIDIA® Tesla® V100](https://www.nvidia.com/ru-ru/data-center/tesla-v100/) | Intel® Xeon® Gold 6230 | **Макс. кол-во GPU на 1 ВМ**: 8 </br> **Кол-во vCPU на 1 GPU**: 8 </br> **Объем RAM на 1 GPU**: 48 ГБ
AMD EPYC™</br>with NVIDIA® Ampere® A100</br>(`gpu-standard-v3`) | [NVIDIA® Ampere® A100](https://www.nvidia.com/ru-ru/data-center/a100/) | [AMD EPYC™ 7702](https://www.amd.com/ru/products/cpu/amd-epyc-7702) | **Макс. кол-во GPU на 1 ВМ**: 8 </br> **Кол-во vCPU на 1 GPU**: 28 </br> **Объем RAM на 1 GPU**: 119 ГБ
Gen2</br>(`gpu-standard-v3i`) | Gen2 | [Gen2](https://www.amd.com/en/products/processors/server/epyc/4th-generation-9004-and-8004-series/amd-epyc-9474f.html) | **Макс. кол-во GPU на 1 ВМ**: 8 </br> **Кол-во vCPU на 1 GPU**: 22,5 или 18 </br> **Объем RAM на 1 GPU**: 180 или 144 ГБ
Intel Ice Lake with</br>NVIDIA® Tesla® T4</br>(`standard-v3-t4`) | [NVIDIA® Tesla® T4](https://www.nvidia.com/ru-ru/data-center/tesla-t4//) | Intel® Xeon® Gold 6338 | **Макс. кол-во GPU на 1 ВМ**: 1 </br> **Кол-во vCPU на 1 GPU**: 4, 8, 16 или 32 </br> **Объем RAM на 1 GPU**: 16, 32, 64 или 128 ГБ
Intel Ice Lake with T4i</br>(`standard-v3-t4i`) | T4i | Intel® Xeon® Gold 6338 | **Макс. кол-во GPU на 1 ВМ**: 1 </br> **Кол-во vCPU на 1 GPU**: 4, 8, 16 или 32 </br> **Объем RAM на 1 GPU**: 16, 32, 64 или 128 ГБ
GPU PLATFORM V4</br>(`gpu-standard-v4`) | GPU V4 | Intel® Xeon® Platinum | **Макс. кол-во GPU на 1 ВМ**: 8 </br> **Кол-во vCPU на 1 GPU**: 22 или 22,5 </br> **Объем RAM на 1 GPU**: 220 или 225 ГБ

## Ограничения {#restrictions}

В таблице ниже представлена информация о поддержке платформ Compute Cloud в [зонах доступности](../../overview/concepts/geo-scope.md) `ru-central1-d` и `ru-central1-e`.

#|
|| Платформа {align="center"} | Зона доступности {align="center"} | > ||
|| ^ | `ru-central1-d` | `ru-central1-e` ||
|| **Стандартные платформы** {align="center"} | > | > ||
|| Intel Broadwell | ![image](../../_assets/common/no.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| Intel Cascade Lake | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/yes.svg) {align="center"} ||
|| Intel Ice Lake | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/yes.svg) {align="center"} ||
|| AMD Zen 3 | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/yes.svg) {align="center"} ||
|| AMD Zen 4 | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/yes.svg) {align="center"} ||
|| **Высокопроизводительные платформы** {align="center"} | > | > ||
|| Intel Ice Lake Compute-Optimized | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| AMD Zen 4 Compute-Optimized | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/yes.svg) {align="center"} ||
|| **Платформы с GPU** {align="center"} | > | > ||
|| Intel Broadwell with NVIDIA® Tesla® V100 | ![image](../../_assets/common/no.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| Intel Cascade Lake with NVIDIA® Tesla® V100 | ![image](../../_assets/common/no.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| AMD EPYC™ with NVIDIA® Ampere® A100 | ![image](../../_assets/common/no.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| Gen2 | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| Intel Ice Lake with NVIDIA® Tesla® T4 | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| Intel Ice Lake with T4i | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| GPU PLATFORM V4 | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/yes.svg) {align="center"} ||
|#

{% note tip %}

Чтобы перенести ВМ с неподдерживаемой платформой в зоны `ru-central1-d` или `ru-central1-e`, воспользуйтесь одним из вариантов:
* [Сделайте](../operations/disk-control/create-snapshot.md) снимок диска и [создайте](../operations/vm-create/create-from-snapshots.md) из него новую ВМ в зоне `ru-central1-d` или `ru-central1-e` на другой платформе.
* [Остановите](../operations/vm-control/vm-stop-and-start.md#stop) ВМ, [измените](../operations/vm-control/vm-update-resources.md#update-vcpu-ram) платформу и [переместите](../operations/vm-control/vm-change-zone.md#relocate-command) ВМ командой [yc compute instance relocate](../cli-ref/instance/relocate.md).

{% endnote %}

### Смотрите также {#see-also}

* [Допустимые конфигурации vCPU и RAM](performance-levels.md).
* [Допустимые конфигурации GPU, vCPU и RAM](gpus.md#config).
* [Тарифы на вычислительные ресурсы для разных платформ](../pricing.md#prices).