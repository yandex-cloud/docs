# Using node groups with GPUs and no pre-installed drivers

You can use {{ managed-k8s-name }} node groups for workloads on [GPUs](../../compute/concepts/gpus.md) without pre-installed drivers. Use the [GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html) to select a suitable driver version.

To prepare your cluster and {{ managed-k8s-name }} node group without pre-installed drivers for running workloads:

1. [{#T}](#install-gpu-operator)
1. [{#T}](#check-install)

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Create a {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md) with any suitable configuration.

1. [Create a node group](../operations/node-group/node-group-create.md) on a platform with a GPU, and enable **{{ ui-key.yacloud.k8s.node-groups.create.field_driverless-gpu }}**.

1. {% include [Настройка kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Install the GPU Operator {#install-gpu-operator}

1. {% include [Helm install](../../_includes/managed-kubernetes/helm-install.md) %}

1. Install the GPU Operator:

    ```bash
    helm repo add nvidia https://helm.ngc.nvidia.com/nvidia && \
    helm repo update && \
    helm install \
      --namespace gpu-operator \
      --create-namespace \
      --set driver.version=<driver_version> \
      gpu-operator nvidia/gpu-operator
    ```

    Where `driver.version` is the version of an NVIDIA® driver. You can omit the driver version parameter. In this case, the [default](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/platform-support.html#gpu-operator-component-matrix) version will be used.

    {% note info %}

    For the {{ managed-k8s-name }} `{{ a100-epyc }}` (`gpu-standard-v3`) node group platform, use [driver version `515.48.07`](https://docs.nvidia.com/datacenter/tesla/tesla-release-notes-515-48-07/index.html).

    {% endnote %}

## Check that drivers are installed correctly {#check-install}

Get the `nvidia-driver-daemonset` pod logs:

```bash
DRIVERS_POD_NAME="$(kubectl get pods --namespace gpu-operator | grep nvidia-driver-daemonset | awk '{print $1}')" && \
kubectl --namespace gpu-operator logs "${DRIVERS_POD_NAME}"
```

They should contain a message saying that the driver has been installed successfully, e.g.:

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

Now, you can run GPU-based workloads by following the [Running workloads with GPUs](../tutorials/running-pod-gpu.md) guide.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Delete the {{ k8s }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. If you created any service accounts, [delete them](../../iam/operations/sa/delete.md).
