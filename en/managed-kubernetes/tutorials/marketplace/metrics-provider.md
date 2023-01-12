# Using {{ MP }} to stream metrics

{{ MP }} streams metrics of {{ managed-k8s-name }} [cluster](../../concepts/index.md#kubernetes-cluster) objects to monitoring systems and [auto scaling systems](../../concepts/autoscale.md).

In this article, you will learn how to set up transfers of external metrics to {{ k8s-hpa }} using {{ MP }}.

To set up the transfer of metrics:
1. [{#T}](#create-files).
1. [{#T}](#install).
1. [{#T}](#validate).
1. [{#T}](#clear-out).

## Before you begin {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Create a {{ managed-k8s-name }} cluster](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration.

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Set up a working environment {#create-files}

To test {{ MP }}, an `nginx` test app and [{{ k8s-hpa }}](../../concepts/autoscale.md#hpa) are created, where {{ MP }} will transfer CPU usage metrics.
1. Create a file named `app.yaml` with the `nginx` application manifest:

   {% cut "app.yaml" %}

   ```yaml
   ---
   ### Deployment
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: nginx
     namespace: kube-system
     labels:
       app: nginx
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: nginx
     template:
       metadata:
         name: nginx
         labels:
           app: nginx
       spec:
         containers:
           - name: nginx
             image: k8s.gcr.io/hpa-example
             resources:
               requests:
                 memory: "256Mi"
                 cpu: "500m"
               limits:
                 memory: "500Mi"
                 cpu: "1"
   ---
   ### Service
   apiVersion: v1
   kind: Service
   metadata:
     name: nginx
     namespace: kube-system
   spec:
     selector:
       app: nginx
     ports:
       - protocol: TCP
         port: 80
         targetPort: 80
     type: LoadBalancer
   ```

   {% endcut %}

1. Create a file named `hpa.yaml` with the {{ k8s-hpa }} `test-hpa` manifest:

   ```yaml
   apiVersion: autoscaling/v2beta2
   kind: HorizontalPodAutoscaler
   metadata:
     name: test-hpa
     namespace: kube-system
   spec:
     maxReplicas: 2
     scaleTargetRef:
       apiVersion: apps/v1
       kind: Deployment
       name: nginx
     metrics:
       - type: External
         external:
           metric:
             name: cpu_usage
             selector:
               matchLabels:
                 service: "compute"
                 resource_id: "<node name>"
                 resource_type: "vm"
           target:
             type: Value
             value: "20"
   ```

   You can get the name of the node where {{ MP }} and the runtime environment will be deployed with a list of cluster nodes:

   ```bash
   kubectl get nodes
   ```

## Install {{ MP }} and the runtime environment {#install}

1. Follow the [instructions](../../operations/applications/metrics-provider.md) to install {{ MP }}.
1. Create a test application and {{ k8s-hpa }}:

   ```bash
   kubectl apply -f app.yaml && \
   kubectl apply -f hpa.yaml
   ```

1. Make sure that the [pods](../../concepts/index.md#pod) of your applications have changed their status to `Running`:

   ```bash
   kubectl get pods -n kube-system | grep nginx && \
   kubectl get pods -n kube-system | grep metrics
   ```

   Result:

   ```text
   nginx-6c5cbfc6d9-dbfrn                      1/1     Running   0          2d22h
   nginx-6c5cbfc6d9-gckhp                      1/1     Running   0          2d22h
   metrics-server-v0.3.1-6b998b66d6-f7dv6      2/2     Running   4          7d3h
   ```

## Test {{ MP }} {#validate}

Make sure that {{ k8s-hpa }} gets metrics from {{ MP }} and uses them to calculate the number of the `nginx` application pods:

```bash
kubectl -n kube-system describe hpa test-hpa
```

In the expected command output, the `AbleToScale` and `ScalingActive` conditions should have the `True` status:

```text
Name:                          test-hpa
Namespace:                     kube-system
...
Min replicas:                  1
Max replicas:                  2
Deployment pods:               2 current / 2 desired
Conditions:
  Type            Status  Reason            Message
  ----            ------  ------            -------
  AbleToScale     True    ReadyForNewScale  recommended size matches current size
  ScalingActive   True    ValidMetricFound  the HPA was able to successfully calculate a replica count from external metric cpu_usage(&LabelSelector{MatchLabels:map[string]string{resource_id: <node name>,resource_type: vm,service: compute,},MatchExpressions:[]LabelSelectorRequirement{},})
Events:           <none>
```

{% note info %}

It will take {{ MP }} some time to receive metrics from the {{ managed-k8s-name }} cluster. If the `unable to get external metric ... no metrics returned from external metrics API` error is returned, rerun the provider performance check in a few minutes.

{% endnote %}

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:
1. [Delete a {{ managed-k8s-name }} cluster](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. If you reserved a [public static IP address](../../../vpc/concepts/address.md#public-addresses) for the cluster, [delete it](../../../vpc/operations/address-delete.md).