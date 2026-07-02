[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Концепции](../index.md) > Группа узлов > Группы узлов с GPU

# Группы узлов с GPU


Вы можете создавать [группы узлов](../index.md#node-group) [кластера Managed Service for Kubernetes](../index.md#kubernetes-cluster) с [графическими ускорителями](../../../compute/concepts/gpus.md) ([GPU](../../../glossary/gpu.md)). Узел создается из [образа](../../../compute/concepts/image.md) [виртуальной машины](../../../compute/concepts/vm.md), совместимой с GPU, — на ней установлены драйверы NVIDIA и [библиотеки CUDA](https://developer.nvidia.com/gpu-accelerated-libraries) для GPU-ускорения.

{% note info %}
     
Механизм управления ресурсами [cgroup v2](https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html) не поддерживается для узлов на [платформе](../../../compute/concepts/vm-platforms.md#gpu-platforms) Gen2 (`gpu-standard-v3i`).

{% endnote %}

## Требования {#requirements}

* В облаке должна быть ненулевая квота GPU.

  По умолчанию в облаке установлена нулевая [квота](../../../compute/concepts/limits.md#compute-quotas) на создание виртуальных машин с GPU. Вы можете запросить увеличение квоты в [консоли управления](https://console.yandex.cloud/cloud?section=quotas). Для этого нужна [роль](../../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше.

* Виртуальные машины на платформах Intel Broadwell with NVIDIA® Tesla® V100, Intel Cascade Lake with NVIDIA® Tesla® V100 и AMD EPYC™ with NVIDIA® Ampere® A100 можно создать в зонах доступности `ru-central1-a` и `ru-central1-b`.

  При выборе этих платформ группа узлов должна находиться в одной из указанных зон доступности или в обеих зонах.

## Тарификация {#pricing}

Чтобы запустить группы узлов с GPU, необходимы кластер Managed Service for Kubernetes, ВМ с GPU и трафик. Поэтому тарификация состоит из следующих частей:
* Использование [мастера Managed Service for Kubernetes](../index.md#master) оплачивается по [правилам Managed Service for Kubernetes](../../pricing.md).
* ВМ с GPU — по [правилам Yandex Compute Cloud](../../../compute/pricing.md#prices-instance-resources).
* Исходящий трафик — по [правилам Yandex Virtual Private Cloud](../../../vpc/pricing.md).

## Примеры использования {#examples}

* [Использование групп узлов с GPU без предустановленных драйверов](../../tutorials/driverless-gpu.md)