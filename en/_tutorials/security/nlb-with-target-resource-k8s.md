# Migrating services from a NLB load balancer with a {{ managed-k8s-full-name }} cluster as a target to an L7 ALB load balancer


You [can use](../../network-load-balancer/concepts/scenarios.md#nlb-mk8s) a [{{ network-load-balancer-full-name }}](../../network-load-balancer/) load balancer as part of services within a [{{ managed-k8s-full-name }}](../../managed-kubernetes/) cluster. The cluster itself creates network load balancer objects according to the manifests provided and monitors the load balancer's target group receiving VMs from that cluster's node groups.

One of the options for a network load balancer in a {{ managed-k8s-name }} cluster is to use it as part of an [nginx Ingress controller](../../managed-kubernetes/operations/applications/ingress-nginx.md).

This tutorial covers the migration from a network load balancer to an [{{ alb-full-name }}](../../application-load-balancer/) L7 load balancer created by an [{{ alb-name }} Ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md), with a [{{ sws-full-name }}](../../smartwebsecurity/) security profile connected.

You can create a service migration infrastructure using the following tools:
