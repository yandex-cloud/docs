# Updating the Metrics Server parameters

[Metrics Server](https://github.com/kubernetes-sigs/metrics-server) is a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) service installed by default. It collects metrics from each {{ managed-k8s-name }} cluster [node](../../managed-kubernetes/concepts/index.md#node-group) using `kubelet` and sends them through the [Metrics API](https://github.com/kubernetes/metrics). [Horizontal Pod Autoscaler and Vertical Pod Autoscaler](../../managed-kubernetes/concepts/autoscale.md) run based on data from these metrics. You can get the metric data using the `kubectl top node` or `kubectl top pod` commands. For more information about Metrics Server, see [this guide](https://github.com/kubernetes-sigs/metrics-server#kubernetes-metrics-server).

A Metrics Server [pod](../../managed-kubernetes/concepts/index.md#pod) has two containers: `metrics-server` and `metrics-server-nanny`, the latter acting as [addon-resizer](https://github.com/kubernetes/autoscaler/tree/master/addon-resizer#addon-resizer) for `metrics-server`. The `metrics-server-nanny` container handles automatic allocation of resources to the `metrics-server` container based on the number of {{ managed-k8s-name }} cluster nodes.

In some cases, `metrics-server-nanny` may run incorrectly. For example, if a {{ managed-k8s-name }} cluster with few nodes runs a large number of pods. In this case, the Metrics Server pod will exceed its limits, which may degrade Metrics Server performance.

To avoid this, update the Metrics Server parameters manually:

1. [View the resources allocated to the Metrics Server pod](#get-resources).
1. [Update the Metrics Server parameters](#update-parameters).
1. [Check the result](#check-result).

To restore the default values of the Metrics Server parameters, [reset them](#reset).

## View the resources allocated to the Metrics Server pod {#get-resources}

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Run this command:

    ```bash
    kubectl get pod <Metrics_Server_pod_name> \
      --namespace=kube-system \
      --output=json | \
      jq '.spec.containers[] | select(.name == "metrics-server") | .resources'
    ```

    The resources are calculated using the following formulas:

    ```text
    cpu = baseCPU + cpuPerNode * nodesCount
    memory = baseMemory + memoryPerNode * nodesCount
    ```

    Where:

    * `baseCPU`: Base [CPU count](../../compute/concepts/vm-platforms.md).
    * `cpuPerNode`: Number of CPUs per node.
    * `nodesCount`: Number of {{ managed-k8s-name }} nodes.
    * `baseMemory`: Base RAM size.
    * `memoryPerNode`: RAM per node.

## Update the Metrics Server parameters {#update-parameters}

1. Open the Metrics Server configuration file:

    ```bash
    kubectl edit configmap metrics-server-config \
      --namespace=kube-system \
      --output=yaml
    ```

1. Add or update the resource parameters under `data.NannyConfiguration`:

    ```yaml
    apiVersion: v1
    data:
      NannyConfiguration: |-
        apiVersion: nannyconfig/v1alpha1
        kind: NannyConfiguration
        baseCPU: <base_CPU_count>m
        cpuPerNode: <number_of_CPUs_per_node>m
        baseMemory: <base_RAM_size>Mi
        memoryPerNode: <RAM_per_node>Mi
    ...
    ```

    {% cut "Configuration file example" %}

    ```yaml
    apiVersion: v1
    data:
      NannyConfiguration: |-
        apiVersion: nannyconfig/v1alpha1
        kind: NannyConfiguration
        baseCPU: 48m
        cpuPerNode: 1m
        baseMemory: 104Mi
        memoryPerNode: 3Mi
    kind: ConfigMap
    metadata:
      creationTimestamp: "2022-12-15T06:28:22Z"
      labels:
        addonmanager.kubernetes.io/mode: EnsureExists
      name: metrics-server-config
      namespace: kube-system
      resourceVersion: "303569"
      uid: 931b88ca-21da-4d04-a3c1-da7e********
    ```

    {% endcut %}

1. Restart Metrics Server. To do this, delete it and wait until the {{ k8s }} controller recreates it:

    ```bash
    kubectl delete deployment metrics-server \
      --namespace=kube-system
    ```

## Check the result {#check-result}

[View](#get-resources) the resources allocated for the Metrics Server pod again and make sure the new pod's allocation is different.

## Reset the Metrics Server parameters {#reset}

To reset the parameters to their default values, delete the Metrics Server configuration file and its Deployment:

```bash
kubectl delete configmap metrics-server-config \
  --namespace=kube-system && \
kubectl delete deployment metrics-server \
  --namespace=kube-system
```

This will automatically create a new Metrics Server pod.
