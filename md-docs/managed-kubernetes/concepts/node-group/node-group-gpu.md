# Группы узлов с GPU


Вы можете создавать [группы узлов](../index.md#node-group) [кластера {{ managed-k8s-name }}](../index.md#kubernetes-cluster) с [графическими ускорителями](../../../compute/concepts/gpus.md) ([GPU](../../../glossary/gpu.md)). Узел создается из [образа](../../../compute/concepts/image.md) [виртуальной машины](../../../compute/concepts/vm.md), совместимой с GPU, — на ней установлены драйверы NVIDIA и [библиотеки CUDA](https://developer.nvidia.com/gpu-accelerated-libraries) для GPU-ускорения.

## Требования {#requirements}

* В облаке должна быть ненулевая квота GPU.

  По умолчанию в облаке установлена нулевая [квота](../../../compute/concepts/limits.md#compute-quotas) на создание виртуальных машин с GPU. Вы можете запросить увеличение квоты в [консоли управления]({{ link-console-quotas }}). Для этого нужна [роль](../../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше.

* Виртуальные машины на платформах {{ v100-broadwell }}, {{ v100-cascade-lake }} и {{ a100-epyc }} можно создать в зонах доступности `{{ region-id }}-a` и `{{ region-id }}-b`.

  При выборе этих платформ группа узлов должна находиться в одной из указанных зон доступности или в обеих зонах.

## Тарификация {#pricing}

Чтобы запустить группы узлов с GPU, необходимы кластер {{ managed-k8s-name }}, ВМ с GPU и трафик. Поэтому тарификация состоит из следующих частей:
* Использование [мастера {{ managed-k8s-name }}](../index.md#master) оплачивается по [правилам {{ managed-k8s-name }}](../../pricing.md).
* ВМ с GPU — по [правилам {{ compute-full-name }}](../../../compute/pricing.md#prices-instance-resources).
* Исходящий трафик — по [правилам {{ vpc-full-name }}](../../../vpc/pricing.md).

## Примеры использования {#examples}

* [{#T}](../../tutorials/driverless-gpu.md)