# Automatic DNS scaling by cluster size

{{ managed-k8s-name }} supports automatic DNS scaling. In a cluster, the `kube-dns-autoscaler` application is run and managed by the [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) controller. The application adjusts the number of CoreDNS replicas using [formulas](#parameters) depending on:
* The number of cluster nodes.
* The number of cluster vCPUs.

In this scenario, you'll edit the `kube-dns-autoscaler` configuration and track the changes in the DNS [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/).

To set up scaling, follow these steps:
1. [Prepare the environment](#prepare).
1. [Configure kube-dns-autoscaler](#configure-autoscaler).
1. [Test scaling](#test-autoscaler).

If you don't need the number of CoreDNS replicas to change depending on the cluster size, [disable scaling](#disable-autoscaler).

## Prepare the environment {#prepare}

1. Create resources.

   For this use case, you'll need a cloud network, subnet, and service account. You can use existing resources or create new ones.

   {% cut "How to create resources" %}

   1. Create a [cloud network](../../vpc/operations/network-create.md).
   1. In the cloud network, create a [subnet](../../vpc/operations/subnet-create.md).
   1. Create a [service account](../../iam/operations/sa/create.md) with the `editor` role.

   {% endcut %}

1. Create a {{ k8s }} cluster and a group of nodes.

   You can use an existing cluster and a group of {{ k8s }} nodes or create new ones.

   {% cut "How to create a {{ k8s }} cluster and a group of nodes" %}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Create a {{ k8s }} cluster:

      ```bash
      yc managed-kubernetes cluster create \
        --name dns-autoscaler \
        --service-account-name <service account name> \
        --node-service-account-name <service account name> \
        --public-ip \
        --zone {{ region-id }}-a \
        --network-name <cloud network name>
      ```

      Result:

      ```text
      done (7m21s)
      ...
      ```

   1. Create a node group:

      ```bash
      yc managed-kubernetes node-group create \
        --name node-group-1 \
        --cluster-name dns-autoscaler \
        --location zone={{ region-id }}-a \
        --public-ip \
        --fixed-size 3 \
        --cores 4 \
        --core-fraction 5
      ```

      Result:

      ```text
      done (2m43s)
      ...
      ```

   {% endcut %}

1. Configure kubectl.

   To run commands for a {{ k8s }} cluster, install and configure the kubectl management console.

   {% cut "How to configure the kubectl" %}

   1. Install the {{ k8s }} CLI [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl).

   1. Add the {{ k8s }} cluster credentials to the kubectl configuration file:

      ```bash
      yc managed-kubernetes cluster get-credentials --external --name dns-autoscaler
      ```

      Result:

      ```text
      Context 'dns-autoscaler' was added as default to kubeconfig '/home/<your home folder>/.kube/config'.
      ...
      ```

   {% endcut %}

## Configure kube-dns-autoscaler {#configure-autoscaler}

### Check a deployment {#check-startup}

To make sure the app is working properly, check a [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) in the `kube-system` namespace.

To do this, run the command:

```bash
kubectl get deployment --namespace=kube-system
```

Result:

```text
NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
...
kube-dns-autoscaler     1/1     1            1           52m
...
```

### Define the scaling parameters {#parameters}

The `kube-dns-autoscaler` pod regularly polls the Kubernetes server for the number of cluster nodes and cores. Based on this data, the number of CoreDNS replicas is calculated.

Two types of calculation are possible:
* Linear mode.
* Ladder mode (a step function).

In linear mode, the following formula is used for calculations:

```
replicas = max( ceil( cores * 1/coresPerReplica ) , ceil( nodes * 1/nodesPerReplica ) )
```

Where:

* `coresPerReplica` is a configuration parameter indicating the number of CoreDNS replicas per vCPU of the cluster.
* `nodesPerReplica` is a configuration parameter indicating the number of CoreDNS replicas per cluster node.
* `cores` is the actual number of vCPUs in the cluster.
* `nodes` is the actual number of nodes in the cluster.
* `ceil` is the ceiling function that rounds up a decimal number to an integer.
* `max` is the max function that returns the largest of the two values.

The `preventSinglePointFailure` additional parameter is relevant for multi-node clusters. If `true`, the minimum number of DNS replicas is two.

You can also define the `min` and `max` configuration parameters that set the minimum and maximum number of CoreDNS replicas in the cluster:

```
replicas = min(replicas, max)
replicas = max(replicas, min)
```

For more information about calculating the number of replicas, see the [cluster-proportional-autoscaler](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#calculation-of-number-of-replicas) documentation.

### Change the configuration {#edit-config}

To configure scaling, follow these steps:
1. Check the current settings.

   In this scenario, a node group named `node-group-1` is created. The number of nodes is 3 and the number of vCPUs is 12.

   By default, `linear` mode and the following scaling parameters are used:
   * `coresPerReplica`: `256`.
   * `nodesPerReplica`: `16`.
   * `preventSinglePointFailure`: `true`.

   ```
   replicas = max( ceil( 12 * 1/256 ), ceil( 3 * 1/16 ) ) = 1
   ```

   The `preventSinglePointFailure` parameter is `true`, meaning the number of CoreDNS replicas is two.

   To get the `coredns` pod data, run the command:

   ```bash
   kubectl get pods -n kube-system
   ```

   Result:

   ```text
   NAME                                    READY   STATUS    RESTARTS   AGE
   ...
   coredns-7c646474c9-4dmjl                1/1     Running   0          128m
   coredns-7c646474c9-n7qsv                1/1     Running   0          134m
   ...
   ```

1. Set new parameters.

   Change the configuration as follows:
   * `coresPerReplica`: `4`.
   * `nodesPerReplica`: `2`.
   * `preventSinglePointFailure`: `true`.

   ```
   replicas = max( ceil( 12 * 1/4 ), ceil( 3 * 1/2 ) ) = 3
   ```

   To pass the parameters to the `kube-dns-autoscaler` application, edit the corresponding [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) using the command:

   ```bash
   kubectl edit configmap kube-dns-autoscaler --namespace=kube-system
   ```

   A text editor with the `kube-dns-autoscaler` configuration opens. Change the line with the parameters:

   ```bash
   linear: '{"coresPerReplica":4,"nodesPerReplica":2,"preventSinglePointFailure":true}'
   ```

   Save the changes. The operation output is displayed:

   ```bash
   configmap/kube-dns-autoscaler edited
   ```

   The `kube-dns-autoscaler` application uploads the configuration and scales the DNS service with the new parameters.

## Test scaling {#test-autoscaler}

### Resize the cluster {#resize-cluster}

Create a second node group using the command:

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

Now the cluster has 5 nodes with 20 vCPUs. Calculate the number of replicas:

```
replicas = max( ceil( 20 * 1/4 ), ceil( 5 * 1/2 ) ) = 5
```

### Track the changes in the DNS service {#inspect-changes}

To check the number of CoreDNS replicas, run the command:

```bash
kubectl get pods -n kube-system
```

Result:

```text
NAME                                    READY   STATUS    RESTARTS   AGE
...
coredns-7c646474c9-7l8mc                1/1     Running   0          3m30s
coredns-7c646474c9-n7qsv                1/1     Running   0          3h20m
coredns-7c646474c9-pv9cv                1/1     Running   0          3m40s
coredns-7c646474c9-r2lss                1/1     Running   0          49m
coredns-7c646474c9-s5jgz                1/1     Running   0          57m
...
```

## Disable scaling {#disable-autoscaler}

To disable scaling, set the number of replicas in the `kube-dns-autoscaler` application [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) to 0:

```bash
kubectl scale deployment --replicas=0 kube-dns-autoscaler --namespace=kube-system
```

Result:

```text
deployment.apps/kube-dns-autoscaler scaled
```

Check the results with the command:

```bash
kubectl get rs --namespace=kube-system
```

Result:

```text
NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
...
kube-dns-autoscaler     0/0     0            0           3h53m
...
```