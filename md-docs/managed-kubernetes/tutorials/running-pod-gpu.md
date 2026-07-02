[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Kubernetes](../index.md) > [Практические руководства](index.md) > Запуск рабочих нагрузок с GPU

# Запуск рабочих нагрузок с GPU


[Кластер Managed Service for Kubernetes](../concepts/index.md#kubernetes-cluster) позволяет запускать рабочие нагрузки на [видеопроцессорах](../../compute/concepts/gpus.md) ([GPU](../../glossary/gpu.md)), что может быть полезно для задач с особыми вычислительными требованиями.

Чтобы запустить рабочие нагрузки с GPU на [подах](../concepts/index.md#pod) кластера Managed Service for Kubernetes:

1. [Создайте под с GPU](#create-pod-gpu).
1. [Проверьте работу пода](#check-pod).

Если созданные ресурсы вам больше не нужны, [удалите их](#delete-resources).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик ([тарифы Managed Service for Kubernetes](../pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища ([тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичный IP-адрес, если он назначен узлам кластера ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).


## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Создайте группы безопасности](../operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Создайте кластер Managed Service for Kubernetes](../operations/kubernetes-cluster/kubernetes-cluster-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.
1. [Создайте группу узлов Managed Service for Kubernetes](../operations/node-group/node-group-create.md) с настройками:
   * **Платформа** — выберите `Есть GPU` → `Intel Broadwell with NVIDIA® Tesla v100`.
   * **GPU** — укажите нужное количество GPU.
   * **Группы безопасности** — выберите созданные ранее группы безопасности.

   {% note info %}
        
   Механизм управления ресурсами [cgroup v2](https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html) не поддерживается для узлов на [платформе](../../compute/concepts/vm-platforms.md#gpu-platforms) Gen2 (`gpu-standard-v3i`).
   
   {% endnote %}

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../operations/connect/index.md#kubectl-connect).

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

   Подробнее о спецификации для создания пода читайте в [документации Kubernetes](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.25/#pod-v1-core).
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
1. [Удалите кластер Managed Service for Kubernetes](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если вы зарезервировали для кластера Managed Service for Kubernetes публичный статический [IP-адрес](../../vpc/concepts/address.md), [удалите его](../../vpc/operations/address-delete.md).