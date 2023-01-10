# Recommendations for using {{ managed-k8s-name }}

Use these recommendations for your `PRODUCTION` applications that require:
* High availability and fault tolerance.
* Load scaling.
* Resource isolation.

## High availability and fault tolerance {#high-availability}

* Use the `REGULAR` or `STABLE` [release channel](../concepts/release-channels-and-updates.md). [NodeLocal DNS](../tutorials/node-local-dns.md) and [Pod Topology Constraints](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/) are available in all {{ k8s }} versions.

{% note tip %}

Use the `RAPID` release channel for test environments to more quickly test {{ k8s }} and {{ managed-k8s-name }} updates.

{% endnote %}

* Update [cluster](./index.md#kubernetes-cluster) and [node groups](./index.md#node-group) manually. To do this, disable automatic [master](../operations/kubernetes-cluster/kubernetes-cluster-update.md) and [node group](../operations/node-group/node-group-update.md) updates.
* When [creating a cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md), select the [Regional](../concepts/index.md#master) master type. {{ k8s }} [services](service.md) will be available in the event of a failure at the [availability zone](../../overview/concepts/geo-scope.md) level. [The Service Level Agreement] {{ managed-k8s-name }} applies to the configuration with the regional master.
* Deploy multiple instances of services like `Deployment` and `StatefulSet` in different availability zones. Use the [Pod Topology Constraints](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/) and [the AntiAffinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) strategies to ensure high service availability and efficient usage of {{ k8s }} cluster resources.

  Use combinations of the labels below for all strategies:
  * `topology.kubernetes.io/zone` to keep the services available in case of availability zone failure.
  * `kubernetes.io/hostname` to keep the services available in the event of cluster node failure.

  {% note tip %}

  Test the strategies in a test environment before implementing them in `PRODUCTION`.

  {% endnote %}

## Load scaling {#scaling}

Use these recommendations if the load on your {{ managed-k8s-name }} cluster is constantly growing:
* To make your cluster more robust, [create node groups](../operations/node-group/node-group-create.md) with [automatic scaling](autoscale.md) in multiple availability zones.
* To reduce the load on the {{ k8s }} DNS, use [NodeLocal DNS](../tutorials/node-local-dns.md). If a cluster is made up of over 50 nodes, use [automatic DNS scaling](../tutorials/dns-autoscaler.md).
* To reduce horizontal traffic within a cluster, use the [Network Load Balancer](../operations/create-load-balancer.md) and the [`externalTrafficPolicy:Local` rule](../operations/create-load-balancer.md#advanced) if possible.
* Consider node storage requirements in advance:
  * Review [disk limits](../../compute/concepts/limits.md) for {{ compute-full-name }}.
  * Load test your disk subsystem in a test environment.
* To reduce latency at high IOPS, use [non-replicated disks](../../compute/concepts/disk.md#disks_types).

## Isolating resources {#isolation}

Follow these recommendations for applications that use shared {{ k8s }} cluster resources.

Adjust the values of `limits` and `requests` for all cluster services:

```yaml
---
...
containers:
...
  resources:
    limits:
      cpu: 250m
      memory: 128Mi
    requests:
      cpu: 100m
      memory: 64Mi
...
```

Specify vCPU availability in thousandths and RAM in megabytes. The service will not exceed the vCPU or RAM values specified in `limits`. Customized `requests` enable you to scale cluster nodes using automatic scaling.

To manage pod resources automatically, configure {{ k8s }} policies:
* [Quality of Service for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/quality-service-pod/) to create pods in different availability classes.
* [Limit Ranges](https://kubernetes.io/docs/concepts/policy/limit-range/) to set limits at the [namespace](../concepts/index.md#namespace) level.