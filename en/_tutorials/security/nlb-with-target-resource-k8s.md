# Migrating services from an NLB with a {{ managed-k8s-full-name }} cluster as a target to an L7 ALB


You can migrate the load from a [{{ network-load-balancer-full-name }}](../../network-load-balancer/) load balancer to a [{{ alb-full-name }}](../../application-load-balancer/) L7 load balancer. The network load balancer is [used](../../network-load-balancer/concepts/scenarios.md#nlb-mk8s) as part of the [NGINX Ingress Controller](../../managed-kubernetes/operations/applications/ingress-nginx.md) within a [{{ managed-k8s-full-name }}](../../managed-kubernetes/) cluster. The cluster itself creates network load balancer objects as per the provided manifests and monitors the load balancer's target group consisting of the VMs from that cluster's node groups.

During the migration, an L7 load balancer with an active [{{ sws-full-name }}](../../smartwebsecurity/) security profile will be created using the [{{ alb-name }} ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md). An L7 load balancer with a connected security profile operates as follows:

![image](../../_assets/tutorials/security/nlb-with-target-resource-k8s.svg)

You can create a service migration infrastructure using the following tools:
