# {{ gpu-operator }}

{{ stackland-name }} enables you to provision {{ nvidia }} GPUs in a {{ stackland-name }} cluster using {{ gpu-operator }}, a component which automates management of GPU resources and ensures their availability for workloads. An implementation of the [{{ nvidia }} GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html), it provides a comprehensive toolkit for GPU provisioning in Kubernetes.

{{ gpu-operator }} use cases include:

* Auto-detection of GPUs on cluster nodes
* Provisioning GPUs as Kubernetes resources for pods
* Support for GPU virtualization technologies (multi-instance GPU or MIG)
* Support for NVLink to create GPU clusters
* GPU health monitoring and metric collection

{{ gpu-operator }} requires {{ nvidia }} GPU nodes to operate.

## Main components {#components}

### {{ nvidia }} driver {#nvidia-driver}

Version: 580.126

The {{ nvidia }} driver provides a low-level interface between the OS and GPU. The driver exposes the GPU hardware capabilities, manages device memory, and handles commands from applications.

### {{ nvidia }} Container Toolkit {#nvidia-container-toolkit}

Version: 580.126

{{ nvidia }} Container Toolkit enables running GPU-accelerated containers. The toolkit integrates with the container runtime and provides GPU access to containers via the Container Device Interface (CDI). This component automatically configures the container environment, mounts the required libraries and devices, and manages GPU resource isolation across containers.

### {{ nvidia }} Fabric Manager {#nvidia-fabric-manager}

Version: 580.126

{{ nvidia }} Fabric Manager manages NVLink and NVSwitch in multi-GPU systems. This component ensures high-speed GPU interconnection, optimizes communication topology, and manages distributed memory in multi-GPU configurations.

### {{ nvidia }} Operator {#nvidia-operator}

Version: 25.10

The {{ nvidia }} {{ gpu-operator }} automates GPU management in a Kubernetes cluster. It creates, configures, and manages components required for GPU provisioning, including drivers, libraries, device plugins, and monitoring systems. The {{ nvidia }} GPU Operator uses CRDs to manage the lifecycle of GPU components.

### DCGM {#dcgm}

{{ nvidia }} Data Center GPU Manager (DCGM) is a tool for monitoring and management of datacenter GPUs. DCGM collects performance, temperature, memory usage, and other GPU metrics.

### DCGM Exporter {#dcgm-exporter}

DCGM Exporter exports GPU metrics in Prometheus format. The [monitoring](monitoring.md) component automatically collects metrics and exposes them for visualization in Grafana.

## GPU monitoring {#monitoring}

DCGM Exporter automatically collects GPU metrics and makes them available in Grafana. {{ stackland-name }} provides prebuilt dashboards for GPU monitoring:

* [{{ nvidia }} DCGM Dashboard](../cluster-monitoring/nvidia-dcgm-monitoring.md): Overview dashboard with metrics of all cluster GPUs.
* [{{ nvidia }} DCGM Dashboard with MIG metrics](../cluster-monitoring/nvidia-dcgm-mig-monitoring.md): Dashboard for MIG GPU monitoring.
* [{{ nvidia }} DCGM Dashboard w/o MIG metrics](../cluster-monitoring/nvidia-dcgm-no-mig-monitoring.md): Dashboard for non-MIG GPU monitoring.

## Using GPUs in pods {#usage}

To use a GPU in a pod, specify the `nvidia.com/gpu` resource in the container specification:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: gpu-pod
spec:
  containers:
  - name: cuda-container
    image: nvidia/cuda:12.0-base
    resources:
      limits:
        nvidia.com/gpu: 1
```

Kubernetes will automatically place the pod on a node with an available GPU.

## Configuration {#configuration}

### MIG Manager settings {#mig-settings}

```yaml
migManager:
  enabled: false
  strategy: "single"
  config:
    default: "all-disabled"
```

* `enabled`: Enables multi-instance GPU support.
* `strategy`: MIG strategy. The possible values are `single` to apply the same MIG configuration to all GPUs on the node or `mixed` to use different MIG configurations on different GPUs.
* `config.default`: Default MIG configuration.

To enable MIG support, set `enabled` to `true` and configure the GPU node:

```
kubectl label nodes my-node nvidia.com/mig.config=all-1g.5gb --overwrite
```

This command applies a MIG profile to `my-node` to partition each of the node’s GPU into multiple independent GPUs, each with one compute slice and 5 GB of video memory.

To view all available MIG profiles, run the following command:

```
kubectl -n stackland-nvidia-gpu get cm default-mig-parted-config -o jsonpath='{.data.config\.yaml}'
```

## See also {#see-also}

* [Cluster and component monitoring](monitoring.md)
* [GPU Operator guides](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html)
