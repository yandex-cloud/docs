---
title: Вопросы и ответы – Графические ускорители GPU
description: Ответы на часто задаваемые вопросы о графических ускорителях GPU в инфраструктуре {{ yandex-cloud }}.
keywords:
  - gpu
  - кластер
  - графические ускорители
---

# Вопросы и ответы про графические ускорители GPU в {{ compute-name }}

{% include [minitoc](minitoc/gpu.md) %}

#### Что делать, если на ВМ перестал работать GPU? {#gpu-not-working}

Проверьте, виден ли GPU драйверу:

```bash
nvidia-smi
```

Если GPU перестал определяться, [остановите](../../compute/operations/vm-control/vm-stop-and-start.md#stop) и снова [запустите](../../compute/operations/vm-control/vm-stop-and-start.md#start) ВМ. При обычной перезагрузке ВМ остается на прежнем хосте, поэтому она может не устранить проблему.

Если `nvidia-smi` видит GPU, но CUDA недоступна в PyTorch, проверьте, что в используемом окружении установлена сборка PyTorch с поддержкой CUDA, совместимая с драйвером. Подберите команду установки в [документации PyTorch](https://pytorch.org/get-started/locally/), затем выполните:

```bash
python3 -c "import torch; print(torch.cuda.is_available())"
```

Если проблема осталась, [обратитесь в техническую поддержку]({{ link-console-support }}). Укажите идентификатор ВМ, образ и версию ОС, вывод `nvidia-smi`, версию PyTorch и полный текст ошибки.

#### Ошибка «Not Supported» при сбросе ускорителей {#not-supported}

{% include notitle [gpu-mig-troubleshooting](../../_includes/compute/gpu-mig-troubleshooting.md#not-supported) %}

#### Ошибка «In use by another client» при сбросе ускорителей {#in-use}

{% include notitle [gpu-mig-troubleshooting](../../_includes/compute/gpu-mig-troubleshooting.md#in-use) %}

#### Ошибка «Unknown Error» при выполнении команд nvidia-smi {#unknown-error}

{% include notitle [gpu-mig-troubleshooting](../../_includes/compute/gpu-mig-troubleshooting.md#unknown-error) %}

#### Ошибка «Warning: persistence mode is disabled on device» при включении режима MIG {#persistence-mode}

{% include notitle [gpu-mig-troubleshooting](../../_includes/compute/gpu-mig-troubleshooting.md#persistence-mode) %}


#### Как проверить физическое состояние кластера GPU? {#test-physical-state}

* Проверьте порты InfiniBand.
* Проверьте сеть.

Подробнее читайте в разделе [{#T}](../../compute/operations/gpu-cluster/gpu-cluster-test-physical-state.md).

#### Как запустить параллельные задачи в кластере GPU? {#mpirun-parallel}

Чтобы запустить параллельные задачи в кластере GPU:

1. Подключитесь к каждой ВМ по SSH и установите [Open MPI](https://www.open-mpi.org/) и [NCCL](https://github.com/NVIDIA/nccl).
1. На основной ВМ соберите тесты NVIDIA и настройте SSH-ключи без пароля.
1. На каждой ВМ добавьте публичный ключ в `authorized_keys`.
1. На основной ВМ выполните команду `mpirun` с IP-адресами ВМ и количеством GPU.

Подробнее читайте в разделе [{#T}](../../compute/operations/gpu-cluster/gpu-cluster-mpirun-parallel.md).

#### Как проверить пропускную способность InfiniBand? {#preinstall-software}

Чтобы проверить пропускную способность InfiniBand создайте и запустите скрипт для запуска тестов `perftest` с использованием `numactl`.

Подробнее читайте в разделе [{#T}](../../compute/operations/gpu-cluster/test-infiniband-bandwidth.md).

