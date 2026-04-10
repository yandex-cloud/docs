`k8s.tunnelClusters.agent` is a special role for creating [Kubernetes clusters](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) with tunnel mode. It enables you to create [node groups](../../../managed-kubernetes/concepts/index.md#node-group), disks, and internal load balancers. You can use previously created Yandex Key Management Service [keys](../../../kms/concepts/key.md) to encrypt and decrypt secrets.

This role includes the `compute.admin`, `iam.serviceAccounts.user`, `k8s.viewer`, `kms.keys.encrypterDecrypter`, and `load-balancer.privateAdmin` permissions.
