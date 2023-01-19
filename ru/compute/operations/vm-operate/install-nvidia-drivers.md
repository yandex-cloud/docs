# Установка NVIDIA-драйверов

Для совместимости с [GPU](../../concepts/gpus.md) на виртуальной машине должны быть установлены драйверы NVIDIA. Драйверы можно установить как при [подготовке образа](../image-create/custom-image.md), так и изнутри ВМ после ее создания.

## Драйверы для Tesla® V100 {#install-v100-drivers}

Чтобы установить драйверы для графической карты NVIDIA® Tesla® V100:

1. Перейдите на страницу [формы]{% if region =="int" %}(https://www.nvidia.com/download/index.aspx){% else %}(https://www.nvidia.com/download/index.aspx?lang=ru){% endif %}.
1. Выберите Data Center / Tesla в поле **Тип продукта**.
1. Выберите V-Series в поле **Серия продуктов**.
1. Выберите Tesla V100 в поле **Семейство продуктов**.
1. Выберите ОС в поле **Операционная система**.
1. Укажите остальные настройки в соответствии с вашей операционной системой и требованиям к драйверу.
1. Нажмите кнопку **Поиск**. Откроется страница с подходящим драйвером.
1. Нажмите кнопку **Загрузить сейчас**.
1. Запустите загруженный установщик и следуйте инструкциям.

## Драйверы для Ampere® A100 {#install-a100-drivers}

В {{ compute-short-name }} доступно две [конфигурации](../../concepts/gpus.md#config) ВМ на платформе AMD EPYC® with NVIDIA® Ampere® A100: с 1 GPU и с 8 GPU. Для конфигурации с 8 GPU необходимо дополнительно установить [Fabric Manager](https://docs.nvidia.com/datacenter/tesla/fabric-manager-user-guide/index.html).

Чтобы установить драйверы для графической карты NVIDIA® Ampere® A100:

1. Перейдите на страницу [формы]{% if region =="int" %}(https://www.nvidia.com/download/index.aspx){% else %}(https://www.nvidia.com/download/index.aspx?lang=ru){% endif %}.
1. Выберите Data Center / Tesla в поле **Тип продукта**.
1. Выберите A-Series в поле **Серия продуктов**.
1. Выберите NVIDIA A100 в поле **Семейство продуктов**.
1. Выберите ОС в поле **Операционная система**.
1. Укажите остальные настройки в соответствии с вашей операционной системой и требованиям к драйверу.
1. Нажмите кнопку **Поиск**. Откроется страница с подходящим драйвером.
1. Нажмите кнопку **Загрузить сейчас**.
1. Запустите загруженный установщик и следуйте инструкциям.

Чтобы установить и настроить Fabric Manager:

1. В терминале выполните:

   ```bash
   sudo apt install -y nvidia-driver-<версия драйвера>-server nvidia-utils-<версия драйвера>-server nvidia-fabricmanager-<версия драйвера>
   sudo systemctl enable nvidia-fabricmanager
   sudo systemctl start nvidia-fabricmanager
   ```

   {% note info %}
   
   При установке укажите нужную версию драйвера (например, 460).

   {% endnote %}

1. Проверьте работу Fabric Manager:

   ```bash
   nvidia-smi nvlink -s
   ```
