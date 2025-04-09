# Migrating services from a NLB to an L7 ALB for DDoS protection using {{ sws-full-name }}

Distributed denial of service, or [DDoS](https://en.wikipedia.org/wiki/Denial-of-service_attack), is a type of cyberattack that involves sending massive numbers of requests to a server or network to overwhelm it or make it inoperable.

You can deploy services in {{ yandex-cloud }} using a [{{ network-load-balancer-full-name }}](../../network-load-balancer/) which distributes traffic across cloud resources. To protect such services from DDoS attacks and bots at the application level (L7) using [{{ sws-full-name }}](../../smartwebsecurity/), you will need to migrate the service from the {{ network-load-balancer-name }} to an L7 [{{ alb-full-name }}](../../application-load-balancer/).

Service migration depends on what targets are used by the {{ network-load-balancer-name }}:

* [{{ network-load-balancer-name }} with VMs as targets](../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-vm/index.md)
* [{{ network-load-balancer-name }} with an instance group as a target](../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/index.md)
* [{{ network-load-balancer-name }} with a Managed Service for Kubernetes cluster as a target](../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/index.md)
* [{{ network-load-balancer-name }} as a target for {{ alb-name }}](../../tutorials/security/migration-from-nlb-to-alb/nlb-as-target-resource-alb/index.md)
