---
title: Tips for using {{ managed-k8s-full-name }}
description: Follow these recommendations if your applications need high availability, fault tolerance, load scaling, and resource isolation.
---

# Tips for using {{ managed-k8s-name }}


Use these recommendations for your `PRODUCTION` applications that require:
* High availability and [fault tolerance](../../architecture/fault-tolerance.md).
* Load scaling.
* Resource isolation.

{% note tip %}

Test the proposed strategies in a test environment before migrating them to `PRODUCTION`.

{% endnote %}

## High availability and fault tolerance {#high-availability}

* Use the `REGULAR` or `STABLE` [release channel](../concepts/release-channels-and-updates.md).

  {% note tip %}

  Use the `RAPID` release channel for test environments to more quickly test {{ k8s }} and {{ managed-k8s-name }} updates.

  {% endnote %}

* Control [cluster](./index.md#kubernetes-cluster) and [node group](./index.md#node-group) updates. Either disable automatic updates and perform them manually, or set the update time so that your applications are available during active usage hours.
* Configure [`podDisruptionBudget` policies](node-group/node-drain.md) to minimize [service](service.md) downtime during updates.
* Select the [highly available](../concepts/index.md#master) master type located in three zones. {{ k8s }} services will be available in the event of an [availability zone](../../overview/concepts/geo-scope.md) level failure. The {{ managed-k8s-name }} [Service Level Agreement] applies to the configuration with a highly available master located in three zones.
* Allocate sufficient compute resources (CPU, RAM) to the master and nodes.
* Minimize or eliminate resubscription of resources on the nodes, especially of RAM.
* Configure correct [health checks](../../network-load-balancer/concepts/health-check.md) for load balancers.
* To make your cluster more robust, [create node groups](../operations/node-group/node-group-create.md) with [automatic scaling](autoscale.md) in multiple availability zones.
* Deploy your `Deployment` and `StatefulSet` type services in multiple instances in different availability zones. Use the [Pod Topology Constraints](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/) and [the AntiAffinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) strategies to ensure high service availability and efficient usage of {{ k8s }} cluster resources.

  Use the label combinations below for all strategies:
  * `topology.kubernetes.io/zone` to keep the services available in the event of an availability zone failure.
  * `kubernetes.io/hostname` to keep the services available in the event of a cluster node failure.

  {% note warning %}

  Autoscaling resources during an availability zone failure takes time. Always use specified labels to distribute pods across different nodes and availability zones so that your applications work properly.

  {% endnote %}

## Load scaling {#scaling}

Use these recommendations if the load on your {{ managed-k8s-name }} cluster is constantly growing:
* To reduce the load on the {{ k8s }} DNS, use [NodeLocal DNS](../tutorials/node-local-dns.md). If the cluster contains over 50 nodes, use [automatic DNS scaling](../tutorials/dns-autoscaler.md).
* To reduce horizontal traffic within the cluster, use a [network load balancer](../operations/create-load-balancer.md) and the [`externalTrafficPolicy:Local` rule](../operations/create-load-balancer.md#advanced) where possible.
* Consider node storage requirements in advance:
  * Review [disk limits](../../compute/concepts/limits.md) for {{ compute-full-name }}.
  * Load test your disk subsystem in a test environment.
* To reduce latency at high IOPS, use [non-replicated disks](../../compute/concepts/disk.md#disks_types).

### Network load balancer {#nlb}

The network load balancer distributes incoming traffic across target resources (VMs). A listener with a public IP address enables the balancer to process internet traffic, while a listener with a private IP address handles internal traffic. The load balancer uses health checks to test target resource availability.

{{ yandex-cloud }} implements the `NLB Zone Shift` [mechanism](../../architecture/fault-tolerance.md#nlb-zone-shift), where you can mark the load balancer with a special flag. If there is a partial failure in the availability zone, which is undetected by health checks, {{ yandex-cloud }} support will disable the compromised zone for this balancer.

To test your application during an availability zone failure, see this [scenario](https://github.com/yandex-cloud-examples/yc-deploy-ha-app-with-nlb).

[Learn more about network load balancers](../../architecture/fault-tolerance.md#nlb).

### Application load balancer {#alb}

The application load balancer is based on the network load balancer, but it can route traffic to any private IP addresses, e.g., IP addresses of resources outside the cloud network. Traffic is routed through intermediate VMs acting as reverse proxies.

In an application load balancer, you can manually disable an availability zone with partial failure.

[Learn more about application load balancers](../../architecture/fault-tolerance.md#alb).

## Isolating resources {#isolation}

Follow these recommendations for applications that use shared {{ k8s }} cluster resources.

Adjust `limits` and `requests` for all the cluster services:

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

Specify vCPU availability in thousandths and RAM in megabytes. The service will not exceed the vCPU or RAM limits specified in `limits`. Customized `requests` allow you to autoscale cluster nodes.

To manage pod resources automatically, configure {{ k8s }} policies:
* [Quality of Service for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/quality-service-pod/) to create pods of different availability classes.
* [Limit Ranges](https://kubernetes.io/docs/concepts/policy/limit-range/) to set limits at the [namespace](../concepts/index.md#namespace) level.

## Monitoring and escalation {#monitoring-escalation}

[Monitoring](../../monitoring/concepts/index.md) and [alerts](../../monitoring/concepts/alerting/alert.md) are key tools for ensuring fault tolerance.

* [Set up metric monitoring](../operations/kubernetes-cluster/kubernetes-cluster-get-stats.md) and [create alerts](../../monitoring/operations/alert/create-alert.md) to track the status of master, nodes, pods, and persistent volumes.
* Configure [escalation](../../monitoring/concepts/alerting/escalations.md) policies for alerts.
