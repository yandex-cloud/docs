# Платформы

{{ compute-full-name }} предоставляет различные виды физических процессоров. Выбор платформы гарантирует тип физического процессора в дата-центре и определяет набор допустимых конфигураций vCPU и RAM. Также, к виртуальной машине можно добавить графический ускоритель (GPU). Платформу необходимо выбирать при создании каждой виртуальной машины.

## Стандартные платформы {#standard-platforms}

Платформа | Процессор | Макс. кол-во ядер (vCPU)</br> на виртуальной машине | Базовая тактовая</br> частота процессора, ГГц
--- | --- | --- | ---
Intel Broadwell</br>(`standard-v1`) | [Intel® Xeon® Processor E5-2660 v4](https://ark.intel.com/ru/products/91772/Intel-Xeon-Processor-E5-2660-v4-35M-Cache-2_00-GHz) | 32 | 2.00
Intel Cascade Lake</br>(`standard-v2`) | [Intel Xeon Gold 6230](https://ark.intel.com/content/www/ru/ru/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html) | 80 | 2.10

## Платформы с GPU {#gpu-platforms}

Платформа | Графический</br> ускоритель | Процессор | Характеристики |
--- | --- | --- | --- | --- | ---
Intel Broadwell with</br>NVIDIA® Tesla® V100</br>(`gpu-standard-v1`) | [NVIDIA® Tesla® V100](https://www.nvidia.com/ru-ru/data-center/tesla-v100/) | [Intel Xeon</br>Processor E5-2660 v4](https://ark.intel.com/ru/products/91772/Intel-Xeon-Processor-E5-2660-v4-35M-Cache-2_00-GHz) | **Макс. кол-во GPU на 1 ВМ**: 4 </br> **Кол-во vCPU на 1 GPU**: 8 </br> **Объем RAM на 1 GPU**: 96 ГБ
Intel Cascade Lake</br>with NVIDIA® Tesla® V100</br>(`gpu-standard-v2`) | [NVIDIA® Tesla® V100](https://www.nvidia.com/ru-ru/data-center/tesla-v100/) | [Intel Xeon Gold 6230](https://www.intel.ru/content/www/ru/ru/products/processors/xeon/scalable/gold-processors/gold-6230.html) | **Макс. кол-во GPU на 1 ВМ**: 8 </br> **Кол-во vCPU на 1 GPU**: 8 </br> **Объем RAM на 1 GPU**: 48 ГБ

## Платформы с vGPU {#vgpu-platforms}

Платформа | Графический</br>ускоритель | Процессор | Характеристики |
--- | --- | --- | --- | --- | ---
Intel Broadwell with</br>NVIDIA® vGPU Tesla® V100 8G</br>(`vgpu-standard-v1`) | [NVIDIA® Tesla® V100](https://www.nvidia.com/ru-ru/data-center/tesla-v100/) | [Intel Xeon</br>Processor E5-2660 v4](https://ark.intel.com/content/www/ru/ru/ark/products/91772/intel-xeon-processor-e5-2660-v4-35m-cache-2-00-ghz.html) | **Кол-во vGPU**: 1</br>**Кол-во vCPU**: 4</br>**Объем RAM**: 12 ГБ</br>**Объем GPU RAM**: 8 ГБ

## Смотрите также {#see-also}

* [Допустимые конфигурации vCPU и RAM](performance-levels.md).
* [Допустимые конфигурации GPU, vCPU и RAM](gpus.md#config).
* [Тарифы на вычислительные ресурсы для разных платформ](../pricing.md#prices).