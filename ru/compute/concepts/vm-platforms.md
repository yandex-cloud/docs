# Платформы

{{ compute-full-name }} предоставляет различные виды физических процессоров. Выбор платформы гарантирует тип физического процессора в дата-центре и определяет набор допустимых конфигураций vCPU и RAM. Также, к виртуальной машине можно добавить графический ускоритель (GPU). Платформу необходимо выбирать при создании каждой виртуальной машины.

## Стандартные платформы {#standard-platforms}

Платформа | Процессор | Макс. кол-во ядер (vCPU)</br> на виртуальной машине | Базовая тактовая</br> частота процессора, ГГц
--- | --- | --- | ---
Intel Broadwell</br> (`standard-v1`) | [Intel Xeon Processor E5-2660 v4](https://ark.intel.com/ru/products/91772/Intel-Xeon-Processor-E5-2660-v4-35M-Cache-2_00-GHz) | 32 | 2.00
Intel Cascade Lake</br> (`standard-v2`) | [Intel Xeon Gold 6230](https://ark.intel.com/content/www/ru/ru/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html) | 64 | 2.10

## Платформы с GPU {#gpu-platforms}

Платформа | Графический</br> ускоритель | Процессор | Характеристики |
--- | --- | --- | --- | --- | ---
Intel Broadwell with </br> NVIDIA Tesla V100 </br> (`gpu-standard-v1`) | [NVIDIA Tesla V100](https://www.nvidia.com/ru-ru/data-center/tesla-v100/) | [Intel Xeon</br>Processor E5-2660 v4](https://ark.intel.com/ru/products/91772/Intel-Xeon-Processor-E5-2660-v4-35M-Cache-2_00-GHz) | **Макс. кол-во GPU на 1 ВМ**: 4 </br> **Кол-во vCPU на 1 GPU**: 8 </br> **Объем RAM на 1 GPU**: 96 ГБ

## Смотрите также {#see-also}

* [Допустимые конфигурации vCPU и RAM](performance-levels.md).
* [Допустимые конфигурации GPU, vCPU и RAM](gpus.md#config).
* [Тарифы на вычислительные ресурсы для разных платформ](../pricing.md#prices).
