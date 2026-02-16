# Migrating services from an external NLB to an L7 ALB with an internal NLB as a target


You can migrate the load from a [{{ network-load-balancer-full-name }}](../../network-load-balancer/) load balancer to a [{{ alb-full-name }}](../../application-load-balancer/) L7 load balancer. A network load balancer distributes traffic across your load balancer pods deployed in a [{{ managed-k8s-full-name }}](../../managed-kubernetes/) cluster. If the L7 load balancer does not support your load balancer configuration, you can add an [internal network load balancer](../../network-load-balancer/concepts/nlb-types.md) as a target for your L7. The internal network load balancer will be distributing traffic across [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/) pods deployed in a {{ managed-k8s-name }} cluster; the internal network load balancer's IP address will be specified in the L7 load balancer's target group.

During the migration process, the L7 load balancer will have a [{{ sws-full-name }}](../../smartwebsecurity/) security profile connected to it. An L7 load balancer with a connected security profile operates as follows:

![image](../../_assets/tutorials/security/nlb-as-target-resource-alb.svg)

You can create a service migration infrastructure using the following tools:
