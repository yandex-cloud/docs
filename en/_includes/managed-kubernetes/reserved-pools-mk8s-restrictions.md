Reserved instance pools _are not supported_ for node groups with the following properties:
* [Autoscaling](../../managed-kubernetes/concepts/node-group/cluster-autoscaler.md)
* [vCPU performance levels below 100%](../../compute/concepts/performance-levels.md)
* [Preemptible VMs](../../compute/concepts/preemptible-vm.md)
* [VM placement groups](../../compute/concepts/placement-groups.md)