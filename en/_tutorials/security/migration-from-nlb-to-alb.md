# Migrating services from a NLB to an L7 ALB for DDoS protection using {{ sws-full-name }}

[DDoS](https://en.wikipedia.org/wiki/Denial-of-service_attack) (Distributed Denial of Service) is a cyberattack that involves sending massive numbers of requests to a server or network to overwhelm it or render it inoperable.

You can deploy services in {{ yandex-cloud }} using a [{{ network-load-balancer-full-name }}](../../network-load-balancer/) which distributes traffic across cloud resources. To protect such services from DDoS attacks and bots at the application level (L7) using [{{ sws-full-name }}](../../smartwebsecurity/), you will need to migrate the service from the {{ network-load-balancer-name }} to an L7 [{{ alb-full-name }}](../../application-load-balancer/).

Service migration depends on what target resources are used by the {{ network-load-balancer-name }}:

* [{{ network-load-balancer-name }} with target resources from VMs](../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-vm.md)
* [{{ network-load-balancer-name }} with target resources from an instance group](../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm.md)
* [{{ network-load-balancer-name }} with target resources from a Managed Service for Kubernetes cluster](../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-k8s.md)
* [{{ network-load-balancer-name }} as a target resource for {{ alb-name }}](../../tutorials/security/migration-from-nlb-to-alb/nlb-as-target-resource-alb.md)
