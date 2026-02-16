# Using {{ MP }} to deliver metrics

{{ MP }} delivers metrics of {{ managed-k8s-name }} [cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) objects to monitoring systems and [automatic scaling systems](../../managed-kubernetes/concepts/autoscale.md).

In this tutorial, you will learn how to set up the delivery of external metrics to {{ k8s-hpa }} using {{ MP }}.

To set up the delivery of metrics:

1. [Set up the runtime environment](#create-files).
1. [Install {{ MP }} and the runtime environment](#install).
1. [Test {{ MP }}](#validate).

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

1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) with any suitable configuration. When creating, specify the preconfigured security groups.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Set up the runtime environment {#create-files}

To test {{ MP }}, you will create the `nginx` test app and [{{ k8s-hpa }}](../../managed-kubernetes/concepts/autoscale.md#hpa) to receive CPU utilization metrics from {{ MP }}.
1. Create the `app.yaml` file with the `nginx` app manifest:

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
             image: registry.k8s.io/hpa-example
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

1. Create the `hpa.yaml` file with the {{ k8s-hpa }} manifest for `test-hpa`:

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
                 resource_id: "<node_name>"
                 resource_type: "vm"
           target:
             type: Value
             value: "20"
   ```

   You can get the name of the node for deploying {{ MP }} and the runtime environment with the list of cluster nodes:

   ```bash
   kubectl get nodes
   ```

## Install {{ MP }} and the runtime environment {#install}

1. Install {{ MP }} by following [this guide](../../managed-kubernetes/operations/applications/metrics-provider.md).
1. Create a test application and {{ k8s-hpa }}:

   ```bash
   kubectl apply -f app.yaml && \
   kubectl apply -f hpa.yaml
   ```

1. Make sure the app [pods](../../managed-kubernetes/concepts/index.md#pod) switched to `Running`:

   ```bash
   kubectl get pods -n kube-system | grep nginx && \
   kubectl get pods -n kube-system | grep metrics
   ```

   Result:

   ```text
   nginx-6c********-dbfrn                      1/1     Running   0          2d22h
   nginx-6c********-gckhp                      1/1     Running   0          2d22h
   metrics-server-v0.3.1-6b********-f7dv6      2/2     Running   4          7d3h
   ```

## Test {{ MP }} {#validate}

Make sure that {{ k8s-hpa }} receives metrics from {{ MP }} and uses them to calculate the number of the `nginx` app pods:

```bash
kubectl -n kube-system describe hpa test-hpa
```

In the expected command output, the `AbleToScale` and `ScalingActive` conditions should be `True`:

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
  ScalingActive   True    ValidMetricFound  the HPA was able to successfully calculate a replica count from external metric cpu_usage(&LabelSelector{MatchLabels:map[string]string{resource_id: <node_name>,resource_type: vm,service: compute,},MatchExpressions:[]LabelSelectorRequirement{},})
Events:           <none>
```

{% note info %}

{{ MP }} will take some time to fetch metrics from the {{ managed-k8s-name }} cluster. If the `unable to get external metric ... no metrics returned from external metrics API` error occurs, repeat the provider test after a few minutes.

{% endnote %}

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Delete](../../vpc/operations/address-delete.md) the cluster [public static IP address](../../vpc/concepts/address.md#public-addresses) if you reserved one.
