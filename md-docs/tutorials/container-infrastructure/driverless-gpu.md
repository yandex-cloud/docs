[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Контейнерная инфраструктура](index.md) > Managed Service for Kubernetes > Использование групп узлов c GPU без предустановленных драйверов

# Использование групп узлов Yandex Managed Service for Kubernetes c GPU без предустановленных драйверов

# Использование групп узлов с GPU без предустановленных драйверов


Вы можете использовать группы узлов Managed Service for Kubernetes для рабочих нагрузок на видеопроцессорах ([GPU](../../compute/concepts/gpus.md)) без предустановленных драйверов. Приложение [GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html) позволит вам самостоятельно выбрать подходящую версию драйвера.

Чтобы подготовить кластер и группу узлов Managed Service for Kubernetes без предустановленных драйверов к запуску рабочих нагрузок:

1. [Установите GPU Operator](#install-gpu-operator).
1. [Проверьте правильность установки драйверов](#check-install).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик ([тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища ([тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичный IP-адрес, если он назначен узлам кластера ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).


## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Создайте кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.

1. [Создайте группу узлов Managed Service for Kubernetes](../../managed-kubernetes/operations/node-group/node-group-create.md) с настройками:
   * **Вычислительные ресурсы** — перейдите на вкладку **GPU** и выберите подходящую платформу.
   * **Не устанавливать драйверы GPU** — выберите опцию.
   * **Группы безопасности** — выберите созданные ранее группы безопасности.
   * **Taint-политики узла** — укажите [taint-политику](../../managed-kubernetes/concepts/index.md#taints-tolerations) `nvidia.com/gpu=true:NoSchedule`.

   {% note info %}
        
   Механизм управления ресурсами [cgroup v2](https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html) не поддерживается для узлов на [платформе](../../compute/concepts/vm-platforms.md#gpu-platforms) Gen2 (`gpu-standard-v3i`).
   
   {% endnote %}

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

## Требования к версиям компонентов {#version-requirements}

Начиная с версии Kubernetes `1.30` для корректной работы группы узлов с GPU без предустановленных драйверов требуются:

* GPU Operator версии `24.9.2`.


* Драйвер NVIDIA версии `550.144.03` или выше.

При использовании компонентов более старых версий могут возникнуть ошибки компиляции драйверов.

## Установите GPU Operator {#install-gpu-operator}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.

1. Установите GPU Operator:

    ```bash
    helm repo add nvidia https://helm.ngc.nvidia.com/nvidia && \
    helm repo update && \
    helm install \
      --namespace gpu-operator \
      --create-namespace \
      --set driver.version=<версия_драйвера> \
      gpu-operator nvidia/gpu-operator
    ```

    Где `driver.version` — версия драйвера NVIDIA®. Вы можете не указывать параметр с версией драйвера, в этом случае будет установлена версия [по умолчанию](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/platform-support.html#gpu-operator-component-matrix).

    {% note info %}

    Рекомендуемая версия драйверов — [550.144.03](https://docs.nvidia.com/datacenter/tesla/tesla-release-notes-550-144-03/index.html) или выше.

    {% endnote %}

    GPU Operator будет установлен с параметрами по умолчанию. Подробнее о параметрах смотрите в [официальной документации](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html#common-chart-customization-options).

    {% note tip %}

    Вы можете посмотреть значения параметров в конфигурационном файле `values.yaml` Helm-чарта. Для этого скачайте архив Helm-чарта командой `helm pull --untar nvidia/gpu-operator`.

    {% endnote %}

## Проверьте правильность установки драйверов {#check-install}

Получите логи пода `nvidia-driver-daemonset`:

```bash
DRIVERS_POD_NAME="$(kubectl get pods --namespace gpu-operator | grep nvidia-driver-daemonset | awk '{print $1}')" && \
kubectl --namespace gpu-operator logs "${DRIVERS_POD_NAME}"
```

Они должны содержать сообщение об успешной установке драйвера, например:

```text
Defaulted container "nvidia-driver-ctr" out of: nvidia-driver-ctr, k8s-driver-manager (init)
DRIVER_ARCH is x86_64
Creating directory NVIDIA-Linux-x86_64-<версия_драйвера>
Verifying archive integrity... OK
Uncompressing NVIDIA Accelerated Graphics Driver for Linux-x86_64 <версия_драйвера>

...

Loading NVIDIA driver kernel modules...
+ modprobe nvidia
+ modprobe nvidia-uvm
+ modprobe nvidia-modeset

...

Done, now waiting for signal
```

Теперь вы можете запускать рабочие нагрузки с GPU согласно руководству [Запуск рабочих нагрузок с GPU](../../managed-kubernetes/tutorials/running-pod-gpu.md).

## Решение проблем {#troubleshooting}

### Ошибки компиляции драйверов {#compilation-error}

Если при установке драйверов возникают ошибки компиляции:

1. Убедитесь, что установлен GPU Operator версии `24.9.2`:

    ```bash
    helm list -n gpu-operator
    ```

1. Используйте предварительно скомпилированные драйверы:

    ```bash
    helm upgrade gpu-operator nvidia/gpu-operator \
      --namespace gpu-operator \
      --set driver.usePrecompiled=true \
      --set driver.version=550.144.03
    ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

1. [Удалите кластер Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если вы создавали сервисные аккаунты, [удалите их](../../iam/operations/sa/delete.md).