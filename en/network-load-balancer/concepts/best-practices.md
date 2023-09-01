# Recommendations for use

### Use different availability zones {#place-resources-in-different-zones}

Create cloud resources in multiple availability zones. This way you can maintain the availability of your applications in case one of the zones becomes unavailable.

### Allocate resources across zones uniformly {#distribute-resources}

The same amount of cloud resources should be hosted in each availability zone. If there are three VMs in the `{{ region-id }}-a` availability zone, then the `{{ region-id }}-b` and `{{ region-id }}-c` availability zones should also host three VMs each.

### Create cloud resources with redundancy {#create-reserves}

If one of the VMs in a certain availability zone fails, that availability zone will continue receiving the same volume of traffic. This will increase the load on the remaining healthy VMs. To prevent all the VMs from failing, we recommend allocating extra resources in each availability zone in addition to the resources required for supporting the design load.

### Assign a dedicated balancer to each app {#one-balancer-one-app}

When deploying multiple applications in {{ yandex-cloud }}, create an independent load balancer for each application.

### Set up a multi-layer infrastructure {#multi-level-infrastructure}

To increase the reliability, set up a multi-layer architecture with L3 and L7 load balancing. The L3 load balancer will receive traffic and forward it to the target group of the L7 load balancers. They will distribute traffic across VMs with applications. You can use [{{ alb-name }}](../../application-load-balancer/) as L7 load balancers.
