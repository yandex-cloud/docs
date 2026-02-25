---
title: Recommendations on using {{ managed-k8s-full-name }}
description: Follow these recommendations if your applications need high availability, fault tolerance, load scaling, and resource isolation.
---

# Recommendations on using {{ managed-k8s-name }}


Use these recommendations for your `PRODUCTION` applications that require:
* High availability and [fault tolerance](../../architecture/fault-tolerance.md).
* Load scaling.
* Resource isolation.

{% note tip %}

Test the strategies below in a test environment before implementing them in `PRODUCTION`.

{% endnote %}

## High availability and fault tolerance {#high-availability}

* Use the `REGULAR` or `STABLE` [release channel](../concepts/release-channels-and-updates.md).

  {% note tip %}

  Use the `RAPID` release channel for test environments to test {{ k8s }} and {{ managed-k8s-name }} updates more quickly.

  {% endnote %}

* Control [cluster](./index.md#kubernetes-cluster) and [node group](./index.md#node-group) updates. Either disable auto updates and perform them manually, or set the update time so that your applications are available during active usage hours.
* Configure [`podDisruptionBudget` policies](node-group/node-drain.md) to minimize [service](service.md) downtime during updates.
* Select the [highly available](../concepts/index.md#master) master type running across three zones. {{ k8s }} services will be available in the event of an [availability zone](../../overview/concepts/geo-scope.md) level failure. The {{ managed-k8s-name }} [Service Level Agreement] applies to the configuration with a highly available master running across three zones.
* Allocate sufficient compute resources (CPUs, RAM) to the master and nodes.
* Minimize or eliminate resubscription of resources on the nodes, especially of RAM.
* Configure correct [health checks](../../network-load-balancer/concepts/health-check.md) for load balancers.
* To make your cluster more robust, [create node groups](../operations/node-group/node-group-create.md) with [autoscaling](autoscale.md) in multiple availability zones.

  {% note tip %}

  {{ managed-k8s-name }} uses {{ compute-full-name }} [VM groups](../../compute/concepts/instance-groups/index.md) as cluster node groups. See the [description of instance groups during a zonal incident and our mitigation guidelines](../../compute/concepts/instance-groups/zonal-inc/overview.md).

  {% endnote %}

* Deploy your `Deployment` and `StatefulSet` type services in multiple instances in different availability zones. Use the [Pod Topology Constraints](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/) and [AntiAffinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) strategies to ensure high availability of services and efficient consumption of {{ k8s }} cluster resources.

  Use the label combinations below for all strategies:
  * `topology.kubernetes.io/zone` to keep the services available in the event of an availability zone failure.
  * `kubernetes.io/hostname` to keep the services available in the event of a cluster node failure.

  {% note warning %}

  Autoscaling resources in the event of an availability zone failure takes time. Always use these labels to distribute pods across different nodes and availability zones so that your applications work properly.

  {% endnote %}

## Load scaling {#scaling}

Use these recommendations if the load on your {{ managed-k8s-name }} cluster is constantly increasing:
* To reduce the load on the {{ k8s }} DNS, use [NodeLocal DNS](../tutorials/node-local-dns.md). If the cluster has over 50 nodes, use [DNS autoscaling](../tutorials/dns-autoscaler.md).
* To reduce horizontal traffic within the cluster, use a [network load balancer](../operations/create-load-balancer.md) and the [`externalTrafficPolicy:Local` rule](../operations/create-load-balancer.md#advanced) where possible.
* Consider node storage requirements in advance:
  * Check the [disk limits](../../compute/concepts/limits.md) for {{ compute-full-name }}.
  * Load test your disk subsystem in a test environment.
* To reduce latency at high IOPS, use [non-replicated disks](../../compute/concepts/disk.md#disks_types).

### Network load balancer {#nlb}

A network load balancer distributes incoming traffic across targets (VMs). A listener with a public IP address enables the load balancer to process internet traffic, while a listener with a private IP address handles internal traffic. The load balancer uses health checks to test the availability of targets.

{{ yandex-cloud }} implements the `NLB Zone Shift` [mechanism](../../architecture/fault-tolerance.md#nlb-zone-shift), where you can mark the load balancer with a special flag. If there is a partial failure in the availability zone, which is undetected by health checks, {{ yandex-cloud }} support will disable the compromised zone for this load balancer.

To test your application in the event of an availability zone failure, check [this scenario](https://github.com/yandex-cloud-examples/yc-deploy-ha-app-with-nlb).

[Learn more about network load balancers](../../architecture/fault-tolerance.md#nlb).

### Application load balancer {#alb}

An application load balancer is based on the network load balancer, but it can route traffic to any private IP addresses, e.g., IP addresses of resources outside the cloud network. Traffic is routed through intermediate VMs acting as reverse proxies.

In an application load balancer, you can manually disable a partially failed availability zone.

[Learn more about application load balancers](../../architecture/fault-tolerance.md#alb).

## Isolating resources {#isolation}

Use these recommendations for applications that share {{ k8s }} cluster resources.

Set up `limits` and `requests` for all the cluster services:

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

Specify vCPU availability in thousandths and RAM in megabytes. The service will not exceed the vCPU and RAM limits specified in `limits`. Setting up `requests` allows you to autoscale cluster nodes.

To manage pod resources automatically, configure {{ k8s }} policies:
* [Quality of Service for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/quality-service-pod/) to create pods of different availability classes.
* [Limit Ranges](https://kubernetes.io/docs/concepts/policy/limit-range/) to set limits at the [namespace](../concepts/index.md#namespace) level.
* [Resource Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/) to limit overall resource consumption in a namespace.

### Resource Quota {#resource-quota}

Use the `ResourceQuota` policy to limit the resources that can be used within a single namespace:

```yaml
---
apiVersion: v1
kind: ResourceQuota
metadata:
  name: namespace-quota
  namespace: my-namespace
spec:
  hard:
    # Computing resources
    requests.cpu: "10"
    requests.memory: 20Gi
    limits.cpu: "20"
    limits.memory: 40Gi
    # Number of objects
    pods: "50"
    services: "10"
    secrets: "20"
    configmaps: "20"
    persistentvolumeclaims: "10"
    # Storage resources
    requests.storage: 100Gi
```

With `ResourceQuota`, you can set limits on:

| Resource type | Parameters | Description |
| --- | --- | --- |
| Computing | `requests.cpu`, `requests.memory`, `limits.cpu`, `limits.memory` | Total requests and vCPU and RAM limits for all pods in the namespace |
| Storage | `requests.storage`, `persistentvolumeclaims` | Total requested storage size and number of PVCs |
| Number of objects | `pods`, `services`, `secrets`, `configmaps`, `replicationcontrollers`, `deployments.apps`, `statefulsets.apps`, `jobs.batch`, `cronjobs.batch` | Maximum number of objects of each type |
| Advanced resources | `requests.nvidia.com/gpu`, `limits.nvidia.com/gpu` | GPU resources and other `extended resources` |

{% note tip %}

Use `ResourceQuota` together with `LimitRange`: `ResourceQuota` limits the total resource consumption in the namespace, while `LimitRange` sets default values ​​and limits for individual containers.

{% endnote %}

## Monitoring and escalation {#monitoring-escalation}

[Monitoring](../../monitoring/concepts/index.md) and [alerts](../../monitoring/concepts/alerting/alert.md) are key tools for ensuring fault tolerance.

* [Set up metric monitoring](../operations/kubernetes-cluster/kubernetes-cluster-get-stats.md) and [create alerts](../../monitoring/operations/alert/create-alert.md) to track the status of your master, nodes, pods, and persistent volumes.
* Configure [escalation](../../monitoring/concepts/alerting/escalations.md) policies for alerts.
