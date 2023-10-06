# Использование групп узлов c GPU без предустановленных драйверов

Вы можете использовать группы узлов {{ managed-k8s-name }} для рабочих нагрузок на видеопроцессорах ([GPU](../../compute/concepts/gpus.md)) без предустановленных драйверов. Приложение [GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html) позволит вам самостоятельно выбрать подходящую версию драйвера.

Чтобы подготовить кластер и группу узлов {{ managed-k8s-name }} без предустановленных драйверов к запуску рабочих нагрузок:

1. [{#T}](#install-gpu-operator).
1. [{#T}](#check-install).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Создайте кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-create.md) любой подходящей конфигурации.

1. [Создайте группу узлов](../operations/node-group/node-group-create.md) на платформе с GPU и включите опцию **{{ ui-key.yacloud.k8s.node-groups.create.field_driverless-gpu }}**.

1. {% include [Настройка kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Установите GPU Operator {#install-gpu-operator}

1. {% include [Установка Helm](../../_includes/managed-kubernetes/helm-install.md) %}

1. Установите GPU Operator:

    ```bash
    helm repo add nvidia https://helm.ngc.nvidia.com/nvidia && \
    helm repo update && \
    helm install \
      --namespace gpu-operator \
      --create-namespace \
      --set toolkit.enabled=false \
      --set driver.version=<версия_драйвера> \
      gpu-operator nvidia/gpu-operator
    ```

    Где `driver.version` — версия драйвера NVIDIA®. Вы можете не указывать параметр с версией драйвера, в этом случае будет установлена версия [по умолчанию](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/platform-support.html#gpu-operator-component-matrix).

    {% note info %}

    Для платформы группы узлов {{ managed-k8s-name }} `{{ a100-epyc }}` (`gpu-standard-v3`) используйте [версию драйвера `515.48.07`](https://docs.nvidia.com/datacenter/tesla/tesla-release-notes-515-48-07/index.html).

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
Creating directory NVIDIA-Linux-x86_64-535.54.03
Verifying archive integrity... OK
Uncompressing NVIDIA Accelerated Graphics Driver for Linux-x86_64 535.54.03

...

Loading NVIDIA driver kernel modules...
+ modprobe nvidia
+ modprobe nvidia-uvm
+ modprobe nvidia-modeset

...

Done, now waiting for signal
```

Теперь вы можете запускать рабочие нагрузки с GPU согласно руководству [Запуск рабочих нагрузок с GPU](../tutorials/running-pod-gpu.md).

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

1. [Удалите кластер {{ k8s }}](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если вы создавали сервисные аккаунты, [удалите их](../../iam/operations/sa/delete.md).
