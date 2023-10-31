`k8s.clusters.agent` is a special role for the Kubernetes cluster service account. It enables you to create node groups, disks, and internal load balancers. You can use previously created Yandex Key Management Service keys to encrypt and decrypt secrets and connect previously created security groups. When combined with the `load-balancer.admin` role, it enables you to create a network load balancer with a public IP address. It includes the following roles:

* `k8s.tunnelClusters.agent`
* `vpc.privateAdmin`