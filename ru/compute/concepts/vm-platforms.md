# Платформы

{{ compute-full-name }} предоставляет различные виды физических процессоров. Выбор платформы гарантирует тип физического процессора в дата-центре и определяет набор допустимых конфигураций vCPU и RAM. Также, к виртуальной машине можно добавить графический ускоритель (GPU). Платформу необходимо выбирать при создании каждой виртуальной машины.

## Стандартные платформы {#standard-platforms}

Платформа | Процессор | Макс. кол-во ядер (vCPU)</br> на виртуальной машине | Базовая тактовая</br> частота процессора, ГГц
--- | --- | --- | ---
{% if product == "yandex-cloud" %}Intel Broadwell</br>(`standard-v1`) | [Intel® Xeon® Processor E5-2660 v4]{% if lang == "ru" %}(https://ark.intel.com/ru/products/91772/Intel-Xeon-Processor-E5-2660-v4-35M-Cache-2_00-GHz){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/91772/intel-xeon-processor-e5-2660-v4-35m-cache-2-00-ghz.html){% endif %} | 32 | 2.00
Intel Cascade Lake</br>(`standard-v2`) | [Intel Xeon Gold 6230]{% if lang == "ru" %}(https://ark.intel.com/content/www/ru/ru/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html){% endif %} | 80 | 2.10{% endif %}
Intel Ice Lake</br>(`standard-v3`) | [Intel Xeon Gold 6338]{% if lang == "ru" %}(https://ark.intel.com/content/www/ru/ru/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html){% endif %} | 96 | 2.00

## Платформы с GPU {#gpu-platforms}

Платформа | Графический</br> ускоритель | Процессор | Характеристики |
--- | --- | --- | --- 
{% if product == "yandex-cloud" %}Intel Broadwell with</br>NVIDIA® Tesla® V100</br>(`gpu-standard-v1`) | [NVIDIA® Tesla® V100]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/tesla-v100/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/v100/){% endif %} | [Intel Xeon</br>Processor E5-2660 v4]{% if lang == "ru" %}(https://ark.intel.com/ru/products/91772/Intel-Xeon-Processor-E5-2660-v4-35M-Cache-2_00-GHz){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/91772/intel-xeon-processor-e5-2660-v4-35m-cache-2-00-ghz.html){% endif %} | **Макс. кол-во GPU на 1 ВМ**: 4 </br> **Кол-во vCPU на 1 GPU**: 8 </br> **Объем RAM на 1 GPU**: 96 ГБ
Intel Cascade Lake</br>with NVIDIA® Tesla® V100</br>(`gpu-standard-v2`) | [NVIDIA® Tesla® V100]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/tesla-v100/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/v100/){% endif %} | [Intel Xeon Gold 6230]{% if lang == "ru" %}(https://ark.intel.com/content/www/ru/ru/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html){% endif %} | **Макс. кол-во GPU на 1 ВМ**: 8 </br> **Кол-во vCPU на 1 GPU**: 8 </br> **Объем RAM на 1 GPU**: 48 ГБ
Intel Ice Lake with</br>NVIDIA® Tesla® T4</br>(`standard-v3-t4`) | [NVIDIA® Tesla® T4]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/tesla-t4//){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/tesla-t4//){% endif %} | [Intel Xeon Gold 6338]{% if lang == "ru" %}(https://ark.intel.com/content/www/ru/ru/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html){% endif %} | **Макс. кол-во GPU на 1 ВМ**: 1 </br> **Кол-во vCPU на 1 GPU**: 32 </br> **Объем RAM на 1 GPU**: 128 ГБ{% endif %}
AMD EPYC™</br>with NVIDIA® Ampere® A100</br>(`gpu-standard-v3`) | [NVIDIA® Ampere® A100]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/a100/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/a100/){% endif %} | [AMD EPYC™ 7702]{% if lang == "ru" %}(https://www.amd.com/ru/products/cpu/amd-epyc-7702){% endif %}{% if lang == "en" %}(https://www.amd.com/en/products/cpu/amd-epyc-7702){% endif %} | **Макс. кол-во GPU на 1 ВМ**: 8 </br> **Кол-во vCPU на 1 GPU**: 28 </br> **Объем RAM на 1 GPU**: 119 ГБ


{% if product == "yandex-cloud" %}

## Платформы с vGPU {#vgpu-platforms}

{% include [vgpu-to-standard](../../_includes/compute/vgpu-to-standard.md) %}

Платформа | Графический</br>ускоритель | Процессор | Характеристики |
--- | --- | --- | --- 
Intel Broadwell with</br>NVIDIA® vGPU Tesla® V100 8G</br>(`vgpu-standard-v1`) | [NVIDIA® Tesla® V100]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/tesla-v100/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/v100/){% endif %} | [Intel Xeon</br>Processor E5-2660 v4]{% if lang == "ru" %}(https://ark.intel.com/content/www/ru/ru/ark/products/91772/intel-xeon-processor-e5-2660-v4-35m-cache-2-00-ghz.html){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/91772/intel-xeon-processor-e5-2660-v4-35m-cache-2-00-ghz.html){% endif %} | **Кол-во vGPU**: 1</br>**Кол-во vCPU**: 4</br>**Объем RAM**: 12 ГБ</br>**Объем GPU RAM**: 8 ГБ

{% endif %}

## Смотрите также {#see-also}

* [Допустимые конфигурации vCPU и RAM](performance-levels.md).
* [Допустимые конфигурации GPU, vCPU и RAM](gpus.md#config).
* [Тарифы на вычислительные ресурсы для разных платформ](../pricing.md#prices).