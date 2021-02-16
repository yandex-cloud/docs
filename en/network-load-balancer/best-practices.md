# Recommendations on how to use the network load balancer

This article provides a set of recommendations for using the Yandex.Cloud network load balancer.

#### Create resources in different availability zones {#targets-in-different-azs}

Create cloud resources in multiple availability zones. This way you can maintain the availability of your applications in case one of the zones becomes unavailable.

#### Use the same amount of cloud resources in different availability zones {#equal-performance}

The same amount of cloud resources should be hosted in each availability zone. If there are three VMs in the availability zone `ru-central1-a`, then the availability zones `ru-central1-b` and `ru-central1-c` should also host three VMs each.

#### Create cloud resources with redundancy {#redundancy}

If one of the VMs in a certain availability zone fails, that availability zone will continue receiving the same volume of traffic. This will increase load on the remaining VMs that are healthy. To avoid failure of all VMs, we recommend using extra resources in each availability zone in addition to the resources necessary for supporting the design load.

#### Use different load balancers for different applications {#logical-distribution}

If you use the Yandex.Cloud infrastructure to deploy multiple applications, you need to configure separate load balancers to serve them.

#### Set up a multi-layer infrastructure {#multi-layer-architecture}

To increase the reliability, set up a multi-layer architecture with L3 and L7 load balancing. The L3 load balancer will receive traffic and forward it to the target group of the L7 load balancers. They will distribute traffic across VMs with applications. You can use Yandex Compute Cloud VMs as L7 load balancers. To do this, install the necessary software on the VMs yourself.

