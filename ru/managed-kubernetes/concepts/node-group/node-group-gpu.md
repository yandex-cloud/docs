# Группы узлов с GPU

Вы можете создавать [группы узлов](../index.md#node-group) [кластера {{ managed-k8s-name }}](../index.md#kubernetes-cluster) с [графическими ускорителями (GPU)](../../../compute/concepts/gpus.md). Узел создается из [образа](../../../compute/concepts/image.md) [виртуальной машины](../../../compute/concepts/vm.md), совместимой с GPU, — на ней установлены драйверы NVIDIA и [библиотеки CUDA](https://developer.nvidia.com/gpu-accelerated-libraries) для GPU-ускорения.

## Требования {#requirements}

* В облаке должна быть ненулевая квота GPU.

  {% include [compute-gpu-zero-quota](../../../_includes/compute/gpu-zero-quota.md) %}

* Группа узлов должна находиться в [зоне доступности](../../../overview/concepts/geo-scope.md) `{{ region-id }}-a`, `{{ region-id }}-b` или в обеих зонах. ВМ с GPU доступны только в этих зонах.

  Запрашивая квоту GPU, учитывайте, в каких зонах вы собираетесь запускать кластеры {{ k8s }}.


## Тарификация {#pricing}

Чтобы запустить группы узлов с GPU, необходимы кластер {{ managed-k8s-name }}, ВМ с GPU и трафик. Поэтому тарификация состоит из следующих частей:
* Использование [мастера {{ managed-k8s-name }}](../index.md#master) оплачивается по [правилам {{ managed-k8s-name }}](../../pricing.md).
* ВМ с GPU — по [правилам {{ compute-full-name }}](../../../compute/pricing.md#prices-instance-resources).
* Исходящий трафик — по [правилам {{ vpc-full-name }}](../../../vpc/pricing.md).