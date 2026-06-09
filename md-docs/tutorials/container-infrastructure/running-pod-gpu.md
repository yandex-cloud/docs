# Запуск рабочих нагрузок с GPU в {{ managed-k8s-full-name }}

# Запуск рабочих нагрузок с GPU


[Кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) позволяет запускать рабочие нагрузки на [видеопроцессорах](../../compute/concepts/gpus.md) ([GPU](../../glossary/gpu.md)), что может быть полезно для задач с особыми вычислительными требованиями.

Чтобы запустить рабочие нагрузки с GPU на [подах](../../managed-kubernetes/concepts/index.md#pod) кластера {{ managed-k8s-name }}:

1. [Создайте под с GPU](#create-pod-gpu).
1. [Проверьте работу пода](#check-pod).

Если созданные ресурсы вам больше не нужны, [удалите их](#delete-resources).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ managed-k8s-name }}: использование мастера и исходящий трафик (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за публичный IP-адрес, если он назначен узлам кластера (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md#prices-public-ip)).


## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера {{ managed-k8s-name }} и входящих в него групп узлов.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.
1. [Создайте группу узлов {{ managed-k8s-name }}](../../managed-kubernetes/operations/node-group/node-group-create.md) с настройками:
   * **{{ ui-key.yacloud.k8s.node-group.overview.label_platform }}** — выберите `{{ ui-key.yacloud.compute.components.PlatformField.value_platform-tab-gpu_hGyQ8 }}` → `Intel Broadwell with NVIDIA® Tesla v100`.
   * **{{ ui-key.yacloud.component.compute.resources.field_gpus }}** — укажите нужное количество GPU.
   * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — выберите созданные ранее группы безопасности.

1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

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