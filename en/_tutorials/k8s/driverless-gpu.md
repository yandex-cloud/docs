# Using node groups with GPUs without pre-installed drivers


You can use {{ managed-k8s-name }} node groups for [GPU](../../compute/concepts/gpus.md) workloads without pre-installed drivers. With [GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html), you can choose the driver version that suits your needs.

To set up a {{ managed-k8s-name }} cluster and node group without pre-installed drivers for workloads:

1. [Install GPU Operator](#install-gpu-operator).
1. [Check that drivers are installed correctly](#check-install).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* Fee for using the master and outgoing traffic in a {{ managed-k8s-name }} cluster (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for using computing resources, OS, and storage in cluster nodes (VMs) (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for a public IP address assigned to cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).


## Getting started {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) with any suitable configuration. When creating, specify the security groups prepared earlier.

1. [Create a {{ managed-k8s-name }} node group](../../managed-kubernetes/operations/node-group/node-group-create.md) with the following settings:
   * **{{ ui-key.yacloud.compute.instances.create.section_platform }}**: Navigate to the **GPU** tab and select the platform.
   * **{{ ui-key.yacloud.k8s.node-groups.create.field_driverless-gpu }}**: Select this option.
   * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: Select the security groups you created earlier.
   * **{{ ui-key.yacloud.k8s.node-groups.create.field_node-taints }}**: Specify the `nvidia.com/gpu=true:NoSchedule` [taint policy](../../managed-kubernetes/concepts/index.md#taints-tolerations).


1. {% include [kubectl-install](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Component version requirements {#version-requirements}

Starting with {{ k8s }} version `1.30`, for a group of nodes with GPUs to work correctly without pre-installed drivers, you will need the following:

* GPU Operator version `24.9.2`.

  {% note info %}

  GPU Operator versions above `24.9.2` were not tested in {{ yandex-cloud }}.

  {% endnote %}

* NVIDIA driver `550.144.03` or higher.

Older version components may cause driver compilation errors.

## Install GPU Operator {#install-gpu-operator}

1. {% include [helm-install](../../_includes/managed-kubernetes/helm-install.md) %}

1. Install GPU Operator:

    ```bash
    helm repo add nvidia https://helm.ngc.nvidia.com/nvidia && \
    helm repo update && \
    helm install \
      --namespace gpu-operator \
      --create-namespace \
      --set driver.version=<driver_version> \
      gpu-operator nvidia/gpu-operator
    ```

    Where `driver.version` is the NVIDIA® driver version. If you skip this setting, the [default](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/platform-support.html#gpu-operator-component-matrix) version will be used.

    {% note info %}

    Recommended driver versions:

    * For node groups of {{ k8s }} `1.30` or higher: [`550.144.03`](https://docs.nvidia.com/datacenter/tesla/tesla-release-notes-550-144-03/index.html) or higher.

    * For node groups on {{ a100-epyc }} (`gpu-standard-v3`): [`515.48.07`](https://docs.nvidia.com/datacenter/tesla/tesla-release-notes-515-48-07/index.html).

    {% endnote %}

    GPU Operator will be installed with default parameters. For more information about parameters, see [this guide](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html#common-chart-customization-options).

    {% note tip %}

    You can view parameter values in the Helm chart's `values.yaml` configuration file. To do this, download the Helm chart archive using the `helm pull --untar nvidia/gpu-operator` command.

    {% endnote %}

## Check that drivers are installed correctly {#check-install}

Get the `nvidia-driver-daemonset` pod logs:

```bash
DRIVERS_POD_NAME="$(kubectl get pods --namespace gpu-operator | grep nvidia-driver-daemonset | awk '{print $1}')" && \
kubectl --namespace gpu-operator logs "${DRIVERS_POD_NAME}"
```

They should contain a message saying that the driver has been installed successfully, such as the following:

```text
Defaulted container "nvidia-driver-ctr" out of: nvidia-driver-ctr, k8s-driver-manager (init)
DRIVER_ARCH is x86_64
Creating directory NVIDIA-Linux-x86_64-<driver_version>
Verifying archive integrity... OK
Uncompressing NVIDIA Accelerated Graphics Driver for Linux-x86_64 <driver_version>

...

Loading NVIDIA driver kernel modules...
+ modprobe nvidia
+ modprobe nvidia-uvm
+ modprobe nvidia-modeset

...

Done, now waiting for signal
```

You can now run GPU workloads by following [this tutorial](../../managed-kubernetes/tutorials/running-pod-gpu.md).

## Troubleshooting {#troubleshooting}

### Driver compilation errors {#compilation-error}

If you get compilation errors when installing drivers:

1. Make sure you are running GPU Operator `24.9.2` or higher:

    ```bash
    helm list -n gpu-operator
    ```
    {% note info %}

    GPU Operator versions above `24.9.2` were not tested in {{ yandex-cloud }}.

    {% endnote %}

1. Use precompiled drivers:

    ```bash
    helm upgrade gpu-operator nvidia/gpu-operator \
      --namespace gpu-operator \
      --set driver.usePrecompiled=true \
      --set driver.version=550.144.03
    ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Delete the {{ k8s }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. If you created any service accounts, [delete them](../../iam/operations/sa/delete.md).
