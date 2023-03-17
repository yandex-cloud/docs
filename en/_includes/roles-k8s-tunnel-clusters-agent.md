### {{ roles.k8s.tunnelClusters.agent }} {#k8s-tunnel-clusters-agent}

`{{ roles.k8s.tunnelClusters.agent }}` is a special role for creating [{{ k8s }} clusters](../managed-kubernetes/concepts/index.md#kubernetes-cluster) with [tunnel mode](../managed-kubernetes/concepts/network-policy.md#cilium). It enables you to create [node groups](../managed-kubernetes/concepts/index.md#node-group), disks, and internal load balancers. You can use previously created [{{ kms-full-name }} keys](../kms/concepts/key.md) to encrypt and decrypt secrets. It includes the following roles:
* `compute.admin`
* `iam.serviceAccounts.user`
* `k8s.viewer`
* `kms.keys.encrypterDecrypter`
* `load-balancer.privateAdmin`
