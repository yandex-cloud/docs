# Группы узлов с GPU

Вы можете создавать [группы узлов](../index.md#node-group) [кластера {{ managed-k8s-name }}](../index.md#kubernetes-cluster) с [графическими ускорителями (GPU)](../../../compute/concepts/gpus.md). Узел создается из [образа](../../../compute/concepts/image.md) [виртуальной машины](../../../compute/concepts/vm.md), совместимой с GPU, — на ней установлены драйверы NVIDIA и [библиотеки CUDA](https://developer.nvidia.com/gpu-accelerated-libraries) для GPU-ускорения.

## Требования {#requirements}

* Ненулевая квота GPU.

  По умолчанию в [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) установлена нулевая [квота]({{ link-console-quotas }}) на использование ВМ с GPU. Чтобы изменить квоту, обратитесь в [техническую поддержку]({{ link-console-support }}).
* Кластер {{ managed-k8s-name }} в [зонах доступности](../../../overview/concepts/geo-scope.md) `{{ region-id }}-a` и `{{ region-id }}-b`, где доступны ВМ с GPU.

  Запрашивая квоту GPU, учитывайте, в каких зонах доступности вы собираетесь запускать кластеры {{ managed-k8s-name }}.

## Тарификация {#pricing}

Чтобы запустить группы узлов с GPU, необходимы кластер {{ managed-k8s-name }}, ВМ с GPU и трафик. Поэтому тарификация состоит из следующих частей:
* Использование [мастера {{ managed-k8s-name }}](../index.md#master) оплачивается по [правилам {{ managed-k8s-name }}](../../pricing.md).
* ВМ с GPU — по [правилам {{ compute-full-name }}](../../../compute/pricing.md#prices-instance-resources).
* Исходящий трафик — по [правилам {{ vpc-full-name }}](../../../vpc/pricing.md).