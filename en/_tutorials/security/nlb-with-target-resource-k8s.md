# Migrating services from an NLB with a {{ managed-k8s-full-name }} cluster as a target to L7 ALB


You [can use](../../network-load-balancer/concepts/scenarios.md#nlb-mk8s) a [{{ network-load-balancer-full-name }}](../../network-load-balancer/) as part of services within a [{{ managed-k8s-full-name }}](../../managed-kubernetes/) cluster. The cluster itself creates network load balancer objects as per the provided manifests and monitors the load balancer's target group consisting of the VMs from that cluster's node groups.

One of the options for a network load balancer in a {{ managed-k8s-name }} cluster is to use it as part of an [NGINX Ingress controller](../../managed-kubernetes/operations/applications/ingress-nginx.md).

This tutorial covers migration from a network load balancer to an L7 [{{ alb-full-name }}](../../application-load-balancer/) created by an [{{ alb-name }} ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md), with a [{{ sws-full-name }}](../../smartwebsecurity/) profile enabled.

Here is how an L7 load balancer with a {{ sws-name }} profile works:

![image](../../_assets/tutorials/security/nlb-with-target-resource-k8s.svg)

You can create a service migration infrastructure using the following tools:
