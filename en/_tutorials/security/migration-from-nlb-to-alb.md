# Migrating services from NLB to L7 ALB for enabling {{ sws-full-name }} protection

You can deploy services in {{ yandex-cloud }} using a [{{ network-load-balancer-full-name }}](../../network-load-balancer/) which distributes traffic across cloud resources. With [{{ sws-full-name }}](../../smartwebsecurity/), you can protect them from DDoS attacks at the application level. To do this, migrate from your {{ network-load-balancer-name }} to an L7 [{{ alb-full-name }}](../../application-load-balancer/).

Service migration depends on what targets your {{ network-load-balancer-name }} is using or what it actually does in your infrastructure:

* [Uses VM instances as targets](../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-vm/index.md)
* [Uses instance groups as targets](../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/index.md)
* [Uses a Managed Service for Kubernetes cluster as a targets](../../tutorials/security/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/index.md)
* [Acts as a target for {{ alb-name }}](../../tutorials/security/migration-from-nlb-to-alb/nlb-as-target-resource-alb/index.md)
