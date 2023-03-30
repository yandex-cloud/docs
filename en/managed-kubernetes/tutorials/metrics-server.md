# Updating the Metrics Server parameters

[Metrics Server](https://github.com/kubernetes-sigs/metrics-server) is a service in a [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster), which is installed by default. It collects metrics from each cluster [node](../concepts/index.md#node-group) using `kubelet` and provides them through the [Metrics API](https://github.com/kubernetes/metrics). [Horizontal Pod Autoscaler and Vertical Pod Autoscaler](../concepts/autoscale.md) run based on data from these metrics. You can get metric data by running the `kubectl top node` or `kubectl top pod` command. For more information, see the [Metrics Server documentation](https://github.com/kubernetes-sigs/metrics-server#kubernetes-metrics-server).

A [pod](../concepts/index.md#pod) on the Metrics Server has two containers, `metrics-server` and `metrics-server-nanny`, the latter running [addon-resizer](https://github.com/kubernetes/autoscaler/tree/master/addon-resizer#addon-resizer) for `metrics-server`. The `metrics-server-nanny` container is responsible for the automatic allocation of resources to the `metrics-server` container depending on the number of {{ managed-k8s-name }} cluster nodes.

In some cases, the `metrics-server-nanny` component may run incorrectly. For instance, if many pods are created while there are few nodes in the {{ managed-k8s-name }} cluster. If so, the Metrics Server pod will exceed its limits, which may degrade the server performance.

To avoid this, change the parameters of the Metrics Server manually:
1. [{#T}](#get-resources).
1. [{#T}](#update-parameters).
1. [{#T}](#check-result).

To restore the default values of the Metrics Server parameters, [reset them](#reset).

## View the amount of resources allocated to the Metrics Server pod {#get-resources}

Run the following command:

```bash
kubectl get pod <metrics server pod name> \
  --namespace=kube-system \
  --output=json | \
  jq '.spec.containers[] | select(.name == "metrics-server") | .resources'
```

The resources are calculated using the following formula:

```text
cpu = baseCPU + cpuPerNode * nodesCount
memory = baseMemory + memoryPerNode * nodesCount
```

Where:
* `baseCPU` is the base number of CPUs.
* `cpuPerNode` is the number of CPUs per node.
* `nodesCount` is the number of nodes.
* `baseMemory` is the base amount of RAM.
* `memoryPerNode` is the amount of RAM per node.

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
       baseCPU: <base number of CPUs>m
       cpuPerNode: <CPUs per node>m
       baseMemory: <base amount of RAM>Mi
       memoryPerNode: <RAM per node>Mi
   ...
   ```

   {% cut "Sample configuration file" %}

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
     uid: 931b88ca-21da-4d04-a3c1-da7e8c95cc47
   ```

   {% endcut %}

1. Restart the Metrics Server. To do this, delete it and wait until the {{ k8s }} controller creates it again:

   ```bash
   kubectl delete deployment metrics-server \
     --namespace=kube-system
   ```

## Check the results {#check-result}

[View](#get-resources) the amount of resources allocated to the Metrics Server pod once again and make sure it has been updated for the new pod.

## Reset the Metrics Server parameters {#reset}

To reset the parameters to their default values, delete the Metrics Server configuration file and its Deployment:

```bash
kubectl delete configmap metrics-server-config \
  --namespace=kube-system && \
kubectl delete deployment metrics-server \
  --namespace=kube-system
```

As a result, a new pod of the Metrics Server is created automatically.