`k8s.tunnelClusters.agent` is a special role for creating Kubernetes clusters with tunnel mode. It enables you to create node groups, disks, and internal load balancers. You can use previously created Yandex Key Management Service keys to encrypt and decrypt secrets. It includes the following roles:

* `compute.admin`
* `iam.serviceAccounts.user`
* `k8s.viewer`
* `kms.keys.encrypterDecrypter`
* `load-balancer.privateAdmin`