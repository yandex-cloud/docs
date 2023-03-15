### {{ roles.k8s.tunnelClusters.agent }} {#k8s-tunnel-clusters-agent}

`{{ roles.k8s.tunnelClusters.agent }}` — специальная роль для создания [кластера {{ k8s }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) с [туннельным режимом](../../../managed-kubernetes/concepts/network-policy.md#cilium). Дает право на создание [групп узлов](../../../managed-kubernetes/concepts/index.md#node-group), дисков, внутренних балансировщиков. Позволяет использовать заранее созданные [ключи {{ kms-full-name }}](../../../kms/concepts/key.md) для шифрования и расшифровки секретов. Включает роли:
* `compute.admin`
* `iam.serviceAccounts.user`
* `k8s.viewer`
* `kms.keys.encrypterDecrypter`
* `load-balancer.privateAdmin`
