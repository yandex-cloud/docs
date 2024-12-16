---
title: How to perform DNS autoscaling based on {{ managed-k8s-full-name }} cluster size
description: Follow this guide to perform DNS autoscaling based on {{ managed-k8s-full-name }} cluster size.
---

# DNS autoscaling based on cluster size


{{ managed-k8s-name }} supports DNS autoscaling. The [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster) hosts the `kube-dns-autoscaler` app which adjusts the number of CoreDNS replicas depending on:
* Number of {{ managed-k8s-name }} cluster [nodes](../concepts/index.md#node-group).
* [Number of vCPUs](../../compute/concepts/performance-levels.md) in the {{ managed-k8s-name }} cluster.

The number of replicas is calculated [by the formulas](#parameters).

To automate DNS scaling:

1. [Configure kube-dns-autoscaler](#configure-autoscaler).
1. [Test scaling](#test-autoscaler).

If you no longer need automatic scaling, [disable it](#disable-autoscaler).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. Create {{ managed-k8s-name }} resources:

   {% list tabs group=instructions %}

   - Manually {#manual}

     1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}

     1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

   - {{ TF }} {#tf}

     1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
     1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
     1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
     1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

     1. Download the [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf) configuration file of the {{ managed-k8s-name }} cluster to the same working directory. The file describes:
        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * {{ managed-k8s-name }} cluster.
        * {{ managed-k8s-name }} node group.
        * [Service account](../../iam/concepts/users/service-accounts.md) required to create the {{ managed-k8s-name }} cluster and node group.
        * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. Specify the [folder ID](../../resource-manager/operations/folder/get-id.md) in the configuration file.
     1. Check that the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.
     1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

   {% include [kubectl info](../../_includes/managed-kubernetes/kubectl-info.md) %}

## Configure kube-dns-autoscaler {#configure-autoscaler}

### Make sure that the app is up and running {#verify-app}

Check [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) in the `kube-system` [namespace](../concepts/index.md#namespace):

```bash
kubectl get deployment --namespace=kube-system
```

Result:

```text
NAME                 READY  UP-TO-DATE  AVAILABLE  AGE
...
kube-dns-autoscaler  1/1    1           1          52m
```

### Define the scaling parameters {#parameters}

The `kube-dns-autoscaler` [pod](../concepts/index.md#pod) regularly polls the {{ k8s }} server for the number of {{ managed-k8s-name }} cluster nodes and cores. Based on this data, the number of CoreDNS replicas is calculated.

Two types of calculation are possible:
* Linear mode.
* Ladder mode (a step function).

For more information about calculating, see the [cluster-proportional-autoscaler](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#calculation-of-number-of-replicas) documentation.

In this example, we consider the `linear` mode in which the calculation follows this formula:

```text
replicas = max( ceil( cores * 1/coresPerReplica ) , ceil( nodes * 1/nodesPerReplica ) )
```

Where:
* `coresPerReplica`: Configuration parameter indicating the number of CoreDNS replicas per vCPU of the {{ managed-k8s-name }} cluster.
* `nodesPerReplica`: Configuration parameter indicating the number of CoreDNS replicas per node of the {{ managed-k8s-name }} cluster.
* `cores`: Actual number of vCPUs in the {{ managed-k8s-name }} cluster.
* `nodes`: Actual number of nodes in the {{ managed-k8s-name }} cluster.
* `ceil`: Function that rounds a decimal to an integer.
* `max`: Function that returns the maximum of the two values.

The optional `preventSinglePointFailure` parameter is relevant for multi-node {{ managed-k8s-name }} clusters. If `true`, the minimum number of DNS replicas is two.

You can also define the `min` and `max` configuration parameters that set the minimum and maximum number of CoreDNS replicas in the {{ managed-k8s-name }} cluster:

```text
replicas = min(replicas, max)
replicas = max(replicas, min)
```

For more information about calculating, see the [cluster-proportional-autoscaler](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#calculation-of-number-of-replicas) documentation.

### Change the configuration {#edit-config}

1. Check the current settings.

   In this example, we are creating a {{ managed-k8s-name }} node group named `node-group-1` with the following parameters:
   * Number of {{ managed-k8s-name }} nodes: `3`
   * Number of vCPUs: `12`

   By default, `linear` mode and the following scaling parameters are used:
   * `coresPerReplica`: `256`
   * `nodesPerReplica`: `16`
   * `preventSinglePointFailure`: `true`

   ```text
   replicas = max( ceil( 12 * 1/256 ), ceil( 3 * 1/16 ) ) = 1
   ```

   As `preventSinglePointFailure` is set to `true`, the number of CoreDNS replicas will be two.

   To get the `coredns` pod data, run this command:

   ```bash
   kubectl get pods -n kube-system
   ```

   Result:

   ```bash
   NAME                      READY  STATUS   RESTARTS  AGE
   ...
   coredns-7c********-4dmjl  1/1    Running  0         128m
   coredns-7c********-n7qsv  1/1    Running  0         134m
   ```

1. Set new parameters.

   Change the configuration as follows:
   * `coresPerReplica`: `4`.
   * `nodesPerReplica`: `2`.
   * `preventSinglePointFailure`: `true`.

   ```text
   replicas = max( ceil( 12 * 1/4 ), ceil( 3 * 1/2 ) ) = 3
   ```

   To deliver the parameters to `kube-dns-autoscaler`, edit the relevant [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) using this command:

   ```bash
   kubectl edit configmap kube-dns-autoscaler --namespace=kube-system
   ```

   This will open a text editor with a `kube-dns-autoscaler` configuration. Change the line with the following parameters:

   ```text
   linear: '{"coresPerReplica":4,"nodesPerReplica":2,"preventSinglePointFailure":true}'
   ```

   Save your changes. to see the operation output:

   ```text
   configmap/kube-dns-autoscaler edited
   ```

   `kube-dns-autoscaler` will upload this configuration and scale the DNS service based on the new parameters.

## Test scaling {#test-autoscaler}

### Resize the {{ managed-k8s-name }} cluster {#resize-cluster}

Create a second {{ managed-k8s-name }} node group using this command:

```bash
yc managed-kubernetes node-group create \
  --name node-group-2 \
  --cluster-name dns-autoscaler \
  --location zone={{ region-id }}-a \
  --public-ip \
  --fixed-size 2 \
  --cores 4 \
  --core-fraction 5
```

Result:

```text
done (2m43s)
...
```

Now the {{ managed-k8s-name }} cluster has 5 nodes with 20 vCPUs. Calculate the number of replicas:

```text
replicas = max( ceil( 20 * 1/4 ), ceil( 5 * 1/2 ) ) = 5
```

### Check the changes in the number of CoreDNS replicas {#inspect-changes}

Run this command:

```bash
kubectl get pods -n kube-system
```

Result:

```text
NAME                      READY  STATUS   RESTARTS  AGE
...
coredns-7c********-7l8mc  1/1    Running  0         3m30s
coredns-7c********-n7qsv  1/1    Running  0         3h20m
coredns-7c********-pv9cv  1/1    Running  0         3m40s
coredns-7c********-r2lss  1/1    Running  0         49m
coredns-7c********-s5jgz  1/1    Running  0         57m
```

### Set up the reducing of the number of {{ managed-k8s-name }} nodes {#reduce-nodes}

By default, {{ k8s-ca }} does not reduce the number of nodes in a {{ managed-k8s-name }} node group with autoscaling if these nodes contain pods from the `kube-system` namespace managed by the [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/), [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/), or [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) app replication controllers, e.g., CoreDNS pods. In this case, the number of {{ managed-k8s-name }} nodes per group cannot be less than the number of CoreDNS pods.

To allow the number of {{ managed-k8s-name }} nodes to decrease, configure the [PodDisruptionBudget](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) object for them, which enables you to stop two CoreDNS pods at a time:

```bash
kubectl create poddisruptionbudget <pdb_name> \
  --namespace=kube-system \
  --selector k8s-app=kube-dns \
  --min-available=2
```

Result:

```text
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: <pdb_name>
spec:
  minAvailable: 2
  selector:
    matchLabels:
      k8s-app: kube-dns
```

## Disable scaling {#disable-autoscaler}

Reset to zero the number of replicas in the `kube-dns-autoscaler` application's [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/):

```bash
kubectl scale deployment --replicas=0 kube-dns-autoscaler --namespace=kube-system
```

Result:

```text
deployment.apps/kube-dns-autoscaler scaled
```

Check the result with this command:

```bash
kubectl get rs --namespace=kube-system
```

Result:

```text
NAME                 READY  UP-TO-DATE  AVAILABLE  AGE
...
kube-dns-autoscaler  0/0    0           0          3h53m
```

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

  [Delete the {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).

- {{ TF }} {#tf}

  {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
