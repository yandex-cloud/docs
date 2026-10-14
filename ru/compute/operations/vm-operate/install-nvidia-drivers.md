---
title: Установка NVIDIA-драйверов
description: Следуя данной инструкции, вы сможете установить NVIDIA-драйверы.
---


# Установка NVIDIA-драйверов


Приложения на ВМ используют CUDA для вычислений на GPU, а доступ к GPU обеспечивает драйвер NVIDIA. Можно использовать [образ с предустановленными драйверами](../../concepts/gpus.md#os), а также установить драйверы самостоятельно — [при подготовке образа](../image-create/custom-image.md) или изнутри уже созданной ВМ.

{% note info %}
   
{% include [gpu-driver-versions](../../../_includes/compute/gpu-driver-versions.md) %}

{% endnote %}

## Выберите драйвер на сайте NVIDIA {#select-driver}

На официальном сайте NVIDIA выберите драйвер для GPU и операционной системы вашей ВМ.

{% list tabs %}

- Tesla® V100 {#install-v100-drivers}

  1. Перейдите на [страницу поиска](https://www.nvidia.com/download/index.aspx).
  1. В поле **Product Category** выберите `Data Center / Tesla`.
  1. В поле **Product Series** выберите `V-Series`.
  1. В поле **Product** выберите `Tesla V100`.
  1. В поле **Operating System** выберите ОС, установленную на ВМ.
  1. Укажите остальные настройки в соответствии с операционной системой ВМ и требованиями к драйверу.
  1. Нажмите кнопку **Find**.
  1. Перейдите на страницу драйвера. В поле **CUDA Toolkit** указана максимальная версия CUDA, которую поддерживает драйвер.

- Ampere® A100 {#install-a100-drivers}

  1. Перейдите на [страницу поиска](https://www.nvidia.com/download/index.aspx).
  1. В поле **Product Category** выберите `Data Center / Tesla`.
  1. В поле **Product Series** выберите `A-Series`.
  1. В поле **Product** выберите `NVIDIA A100`.
  1. В поле **Operating System** выберите ОС, установленную на ВМ.
  1. Укажите остальные настройки в соответствии с операционной системой ВМ и требованиями к драйверу.
  1. Нажмите кнопку **Find**.
  1. Перейдите на страницу драйвера. В поле **CUDA Toolkit** указана максимальная версия CUDA, которую поддерживает драйвер.

{% endlist %}

## Установите драйвер {#install-driver}

Для NVIDIA® Ampere® A100 можно установить драйвер из официального репозитория. [Подключитесь к ВМ по SSH](../vm-connect/ssh.md) и выполните:

```bash
sudo apt update
sudo apt install -y nvidia-driver-<версия_драйвера>-server
```

Где `<версия_драйвера>` — мажорная версия драйвера на сайте NVIDIA. Например, версии `580.178.04` соответствует имя пакета `nvidia-driver-580-server`.

NVIDIA® Tesla® V100 использует более раннюю архитектуру, которую поддерживают не все версии драйверов. Если совместимого пакета нет в подключенных репозиториях или возникают ошибки, установите драйвер с сайта NVIDIA.

Чтобы установить драйвер вручную:

1. [Подключитесь к ВМ по SSH](../vm-connect/ssh.md).
1. Скопируйте прямую ссылку на файл установщика со страницы драйвера.
1. Скачайте установщик с помощью `wget` и установите [по инструкции NVIDIA для Ubuntu](https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/ubuntu.html).

Если скачать установщик с ВМ не получается, скачайте его на локальный компьютер и [скопируйте на ВМ по SCP](../vm-connect/scp-sftp.md#scp).

## Проверить работу драйвера и версию CUDA {#check-cuda}

После установки драйвера выполните на ВМ:

```bash
nvidia-smi
```
Если драйвер работает и GPU доступен, команда выведет таблицу с информацией о GPU. Поле `Driver Version` содержит версию драйвера, а `CUDA Version` — максимальную версию CUDA, которую он поддерживает.

На ВМ с несколькими GPU проверьте состояние соединений NVLink:

```bash
nvidia-smi nvlink -s
```

Чтобы узнать версию установленного CUDA Toolkit, выполните:

```bash
nvcc --version
```

Версия указана в строке `Cuda compilation tools, release ...` и должна быть [совместима](https://docs.nvidia.com/deploy/cuda-compatibility/minor-version-compatibility.html) с установленным драйвером. Подробнее об установке и настройке CUDA Toolkit читайте в [документации NVIDIA](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/).

#### Полезные ссылки {#see-also}

* [{#T}](../enable-mig.md)
