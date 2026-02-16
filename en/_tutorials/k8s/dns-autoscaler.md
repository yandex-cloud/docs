# DNS autoscaling based on the cluster size


{{ managed-k8s-name }} supports DNS autoscaling. `kube-dns-autoscaler` running in a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) adjusts the number of CoreDNS replicas based on:
* Number of {{ managed-k8s-name }} cluster [nodes](../../managed-kubernetes/concepts/index.md#node-group).
* [Number of vCPUs](../../compute/concepts/performance-levels.md) in the {{ managed-k8s-name }} cluster.

The number of replicas is calculated [by the formulas](#parameters).

To automate DNS scaling:

1. [Configure kube-dns-autoscaler](#configure-autoscaler).
1. [Test scaling](#test-autoscaler).

If you no longer need automatic scaling, [disable it](#disable-autoscaler).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* Fee for using the master and outgoing traffic in a {{ managed-k8s-name }} cluster (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for each VM (cluster nodes and management VMs without public access) which covers the use of computing resources, operating system, and storage (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for a public IP address for cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).


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

     1. Download the [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf) configuration file for the {{ managed-k8s-name }} cluster to the same working directory. This file describes:
        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * {{ managed-k8s-name }} cluster.
        * {{ managed-k8s-name }} node group.
        * [Service account](../../iam/concepts/users/service-accounts.md) required to create the {{ managed-k8s-name }} cluster and node group.
        * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. Specify the [folder ID](../../resource-manager/operations/folder/get-id.md) in the configuration file.
     1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will show any errors found in your configuration files.
     1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

   {% include [kubectl info](../../_includes/managed-kubernetes/kubectl-info.md) %}

## Configure kube-dns-autoscaler {#configure-autoscaler}

### Make sure the app is up and running {#verify-app}

Check for [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) in the `kube-system` [namespace](../../managed-kubernetes/concepts/index.md#namespace):

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

The `kube-dns-autoscaler` [pod](../../managed-kubernetes/concepts/index.md#pod) regularly polls the {{ k8s }} server for the number of {{ managed-k8s-name }} cluster nodes and cores. Based on this data, it calculates the number of CoreDNS replicas.

There are two calculation modes:
* Linear
* Ladder (step function)

For more information about calculating, see [this cluster-proportional-autoscaler page on GitHub](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#calculation-of-number-of-replicas).

This example uses the `linear` mode which calculates the number of replicas by the following formula:

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

For more information about calculating, see [this cluster-proportional-autoscaler page on GitHub](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#calculation-of-number-of-replicas).

### Change the configuration {#edit-config}

1. Check the current settings.

   In this example, we have a {{ managed-k8s-name }} node group named `node-group-1` with the following settings:
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

   To get the `coredns` pod details, run this command:

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

1. Set new parameter values.

   Change the configuration as follows:
   * `coresPerReplica`: `4`
   * `nodesPerReplica`: `2`
   * `preventSinglePointFailure`: `true`

   ```text
   replicas = max( ceil( 12 * 1/4 ), ceil( 3 * 1/2 ) ) = 3
   ```

   To deliver the parameters to `kube-dns-autoscaler`, edit the relevant [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) using this command:

   ```bash
   kubectl edit configmap kube-dns-autoscaler --namespace=kube-system
   ```

   This will open the `kube-dns-autoscaler` configuration in a text editor. Edit the parameter line as follows:

   ```text
   linear: '{"coresPerReplica":4,"nodesPerReplica":2,"preventSinglePointFailure":true}'
   ```

   Save your changes. You will see the result of the operation on the screen:

   ```text
   configmap/kube-dns-autoscaler edited
   ```

   `kube-dns-autoscaler` will load this configuration and scale the DNS service based on the new parameters.

## Test scaling {#test-autoscaler}

### Resize the {{ managed-k8s-name }} cluster {#resize-cluster}

Create another {{ managed-k8s-name }} node group using this command:

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

Now the {{ managed-k8s-name }} cluster has five nodes with 20 vCPUs. Calculate the number of replicas:

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

### Set up {{ managed-k8s-name }} node downscaling {#reduce-nodes}

By default, {{ k8s-ca }} does not scale down nodes in autoscaling {{ managed-k8s-name }} node group if these nodes runs pods from the `kube-system` namespace managed by the [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/), [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/), or [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) controllers, e.g., CoreDNS pods. In this case, the number of {{ managed-k8s-name }} nodes per group cannot fall below the number of CoreDNS pods.

To enable {{ managed-k8s-name }} node downscaling, configure a [PodDisruptionBudget](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) that allows stopping up to two CoreDNS pods at the same time:

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

Set the number of replicas in the `kube-dns-autoscaler` [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) to zero:

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

  [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).

- {{ TF }} {#tf}

  {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
