---
title: Running workloads with GPUs
description: Follow this guide to run workloads with GPUs.
---

# Running workloads with GPUs


A [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster) allows running workloads on [GPUs](../../compute/concepts/gpus.md) (GPUs), which may be of use in tasks with special computing requirements.

To run workloads using GPUs on {{ managed-k8s-name }} cluster [pods](../concepts/index.md#pod):

1. [Create a pod with a GPU](#create-pod-gpu).
1. [Test the pod](#check-pod).

If you no longer need the resources you created, [delete them](#delete-resources).


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for the {{ managed-k8s-name }} cluster: using the master and outgoing traffic (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Cluster nodes (VM) fee: using computing resources, operating system, and storage (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for a public IP address assigned to cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).


## Getting started {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Create a {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md) with any suitable configuration. When creating them, specify the security groups prepared earlier.
1. [Create a {{ managed-k8s-name }} node group](../operations/node-group/node-group-create.md) with the following settings:
   * **{{ ui-key.yacloud.k8s.node-group.overview.label_platform }}**: Select `{{ ui-key.yacloud.compute.components.PlatformField.value_platform-tab-gpu_hGyQ8 }}` → `Intel Broadwell with NVIDIA® Tesla v100`.
   * **{{ ui-key.yacloud.component.compute.resources.field_gpus }}**: Specify the required number of GPUs.
   * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: Select the security groups created earlier.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Create a pod with a GPU {#create-pod-gpu}

1. Save the GPU pod creation specification to a YAML file named `cuda-vector-add.yaml`:

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
             nvidia.com/gpu: 1 # Request for 1 GPU.
   ```

   To learn more about the pod creation specification, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.25/#pod-v1-core).
1. Create a pod with a GPU:

   ```bash
   kubectl create -f cuda-vector-add.yaml
   ```

## Test the pod {#check-pod}

1. View the information about the new pod:

   ```bash
   kubectl describe pod cuda-vector-add
   ```

   Result:

   ```text
   Name:         cuda-vector-add
   Namespace:    default
   Priority:     0
   ...
     Normal  Pulling    16m   kubelet, cl1i7hcbti99********-ebyq  Successfully pulled image "registry.k8s.io/cuda-vector-add:v0.1"
     Normal  Created    16m   kubelet, cl1i7hcbti99********-ebyq  Created container cuda-vector-add
     Normal  Started    16m   kubelet, cl1i7hcbti99********-ebyq  Created container
   ```

1. View the pod logs:

   ```bash
   kubectl logs -f cuda-vector-add
   ```

   Result:

   ```text
   [Vector addition of 50000 elements]
   Copy input data from the host memory to the CUDA device
   CUDA kernel launch with 196 blocks of 256 threads
   Copy output data from the CUDA device to the host memory
   Test PASSED
   Done
   ```

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:
1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. If you reserved a public static [IP address](../../vpc/concepts/address.md) for your {{ managed-k8s-name }} cluster, [delete it](../../vpc/operations/address-delete.md).
