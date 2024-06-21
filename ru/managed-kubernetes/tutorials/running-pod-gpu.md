# Запуск рабочих нагрузок с GPU


[Кластер {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster) позволяет запускать рабочие нагрузки на видеопроцессорах ([GPU](../../compute/concepts/gpus.md)), что может быть полезно для задач с особыми вычислительными требованиями.

Чтобы запустить рабочие нагрузки с GPU на [подах](../concepts/index.md#pod) кластера {{ managed-k8s-name }}:
1. [{#T}](#create-pod-gpu).
1. [{#T}](#check-pod).

Если созданные ресурсы вам больше не нужны, [удалите их](#delete-resources).

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Создайте кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.
1. [Создайте группу узлов {{ managed-k8s-name }}](../operations/node-group/node-group-create.md) с настройками:
   * **{{ ui-key.yacloud.k8s.node-group.overview.label_platform }}** — выберите `{{ ui-key.yacloud.component.compute.resources.value_platform-tab-gpu }}` → `Intel Broadwell with NVIDIA® Tesla v100`.
   * **{{ ui-key.yacloud.component.compute.resources.field_gpus }}** — укажите нужное количество GPU.
   * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — выберите созданные ранее группы безопасности.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Создайте под с GPU {#create-pod-gpu}

1. Сохраните спецификацию для создания пода с GPU в YAML-файл с названием `cuda-vector-add.yaml`:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: cuda-vector-add
   spec:
     restartPolicy: OnFailure
     containers:
       - name: cuda-vector-add
         # https://github.com/kubernetes/kubernetes/blob/v1.7.11/test/images/nvidia-cuda/Dockerfile
         image: "registry.k8s.io/cuda-vector-add:v0.1"
         resources:
           limits:
             nvidia.com/gpu: 1 # Запрос 1 GPU.
   ```

   Подробнее о спецификации для создания пода читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.25/#pod-v1-core).
1. Создайте под с GPU:

   ```bash
   kubectl create -f cuda-vector-add.yaml
   ```

## Проверьте работу пода {#check-pod}

1. Посмотрите информацию о созданном поде:

   ```bash
   kubectl describe pod cuda-vector-add
   ```

   Результат:

   ```text
   Name:         cuda-vector-add
   Namespace:    default
   Priority:     0
   ...
     Normal  Pulling    16m   kubelet, cl1i7hcbti99********-ebyq  Successfully pulled image "registry.k8s.io/cuda-vector-add:v0.1"
     Normal  Created    16m   kubelet, cl1i7hcbti99********-ebyq  Created container cuda-vector-add
     Normal  Started    16m   kubelet, cl1i7hcbti99********-ebyq  Created container
   ```

1. Посмотрите логи работы пода:

   ```bash
   kubectl logs -f cuda-vector-add
   ```

   Результат:

   ```text
   [Vector addition of 50000 elements]
   Copy input data from the host memory to the CUDA device
   CUDA kernel launch with 196 blocks of 256 threads
   Copy output data from the CUDA device to the host memory
   Test PASSED
   Done
   ```

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:
1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если вы зарезервировали для кластера {{ managed-k8s-name }} публичный статический [IP-адрес](../../vpc/concepts/address.md), [удалите его](../../vpc/operations/address-delete.md).
