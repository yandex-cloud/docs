# Установка Time-Slicing GPUs


Плагин [Time-Slicing GPUs в {{ k8s }}](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/gpu-sharing.html) используется для чередования рабочих нагрузок, которые выполняются на одном [GPU](../../compute/concepts/gpus.md) с избыточной подпиской.

Чтобы установить плагин Time-Slicing GPUs в {{ managed-k8s-name }}:
1. [{#T}](#configure-time-slicing).
1. [{#T}](#check-time-slicing).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

1. {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Создайте кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-create.md).

1. [Создайте группу узлов {{ managed-k8s-name }}](../operations/node-group/node-group-create.md) c [GPU NVIDIA® Tesla® T4](../../compute/concepts/gpus.md#tesla-t4).

1. {% include [Настройка kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Настройте Time-Slicing GPUs {#configure-time-slicing}

1. Создайте конфигурацию time-slicing:
   1. Подготовьте файл `time-slicing-config.yaml` со следующим содержимым:

      ```yaml
      ---
      kind: Namespace
      apiVersion: v1
      metadata:
        name: gpu-operator

      ---
      apiVersion: v1
      kind: ConfigMap
      metadata:
        name: time-slicing-config
        namespace: gpu-operator
      data:
        a100-80gb: |-
          version: v1
          sharing:
            timeSlicing:
              resources:
              - name: nvidia.com/gpu
                replicas: 5
        tesla-t4: |-
          version: v1
          sharing:
            timeSlicing:
              resources:
              - name: nvidia.com/gpu
                replicas: 5
      ```

   1. Выполните команду:

      ```bash
      kubectl create -f time-slicing-config.yaml
      ```

      Результат:

      ```text
      namespace/gpu-operator created
      configmap/time-slicing-config created
      ```

1. Установите [GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html):

   ```bash
   helm repo add nvidia https://helm.ngc.nvidia.com/nvidia && \
   helm repo update && \
   helm install \
     --namespace gpu-operator \
     --create-namespace \
     --set devicePlugin.config.name=time-slicing-config \
     gpu-operator nvidia/gpu-operator
   ```

1. Примените конфигурацию time-slicing для [кластера {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster) или [группы узлов](../concepts/index.md#node-group):

   {% list tabs %}

   - Кластер {{ managed-k8s-name }}

     ```bash
     kubectl patch clusterpolicies.nvidia.com/cluster-policy \
       --namespace gpu-operator \
       --type merge \
       --patch='{"spec": {"devicePlugin": {"config": {"name": "time-slicing-config", "default": "tesla-t4"}}}}'
     ```

   - Группа узлов {{ managed-k8s-name }}

     ```bash
     yc managed-kubernetes node-group add-labels <идентификатор_или_имя_группы_узлов> \
       --labels nvidia.com/device-plugin.config=tesla-t4
     ```

     Идентификатор и имя группы узлов {{ managed-k8s-name }} можно получить со [списком групп узлов в каталоге](../operations/node-group/node-group-list.md#list).

   {% endlist %}

## Проверьте работу Time-Slicing GPUs {#check-time-slicing}

1. Создайте тестовое приложение:
   1. Сохраните следующую спецификацию для создания приложения в YAML-файл с именем `nvidia-plugin-test.yml`.

      [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) — объект API {{ k8s }}, который управляет реплицированным приложением.

      ```yaml
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        name: nvidia-plugin-test
        labels:
          app: nvidia-plugin-test
      spec:
        replicas: 5
        selector:
          matchLabels:
            app: nvidia-plugin-test
        template:
          metadata:
            labels:
              app: nvidia-plugin-test
          spec:
            tolerations:
              - key: nvidia.com/gpu
                operator: Exists
                effect: NoSchedule
            containers:
              - name: dcgmproftester11
                image: nvidia/samples:dcgmproftester-2.0.10-cuda11.0-ubuntu18.04
                command: ["/bin/sh", "-c"]
                args:
                  - while true; do /usr/bin/dcgmproftester11 --no-dcgm-validation -t 1004 -d 300; sleep 30; done
                resources:
                  limits:
                    nvidia.com/gpu: 1
                securityContext:
                  capabilities:
                    add: ["SYS_ADMIN"]
      ```

   1. Выполните команду:

      ```bash
      kubectl apply -f nvidia-plugin-test.yml
      ```

      Результат:

      ```text
      deployment.apps/nvidia-plugin-test created
      ```

1. Убедитесь, что все пять [подов {{ managed-k8s-name }}](../concepts/index.md#pod) приложения находятся в состоянии `Running`:

   ```bash
   kubectl get pods | grep nvidia-plugin-test
   ```

1. Выполните команду `nvidia-smi` в запущенном поде {{ managed-k8s-name }} `nvidia-container-toolkit`:

   ```bash
   kubectl exec <имя_пода_nvidia-container-toolkit> \
     --namespace gpu-operator -- nvidia-smi
   ```

   Результат:

   ```text
   Defaulted container "nvidia-container-toolkit-ctr" out of: nvidia-container-toolkit-ctr, driver-validation (init)
   Thu Jan 26 09:42:51 2023
   +-----------------------------------------------------------------------------+
   | NVIDIA-SMI 515.65.01    Driver Version: 515.65.01    CUDA Version: N/A      |
   |-------------------------------+----------------------+----------------------+
   | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
   | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
   |                               |                      |               MIG M. |
   |===============================+======================+======================|
   |   0  Tesla T4            Off  | 00000000:8B:00.0 Off |                    0 |
   | N/A   72C    P0    70W /  70W |   1579MiB / 15360MiB |    100%      Default |
   |                               |                      |                  N/A |
   +-------------------------------+----------------------+----------------------+

   +-----------------------------------------------------------------------------+
   | Processes:                                                                  |
   |  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
   |        ID   ID                                                   Usage      |
   |=============================================================================|
   |    0   N/A  N/A     43108      C   /usr/bin/dcgmproftester11         315MiB |
   |    0   N/A  N/A     43211      C   /usr/bin/dcgmproftester11         315MiB |
   |    0   N/A  N/A     44583      C   /usr/bin/dcgmproftester11         315MiB |
   |    0   N/A  N/A     44589      C   /usr/bin/dcgmproftester11         315MiB |
   |    0   N/A  N/A     44595      C   /usr/bin/dcgmproftester11         315MiB |
   +-----------------------------------------------------------------------------+
   ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не тратить на них средства:
1. [Удалите кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если вы создавали [сервисные аккаунты](../../iam/concepts/users/service-accounts.md), [удалите их](../../iam/operations/sa/delete.md).