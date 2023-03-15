### {{ roles.k8s.clusters.agent }} {#k8s-clusters-agent}

`{{ roles.k8s.clusters.agent }}` — специальная роль для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) [кластера {{ k8s }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster). Дает право на создание [групп узлов](../../../managed-kubernetes/concepts/index.md#node-group), дисков, внутренних балансировщиков. Позволяет использовать заранее созданные [ключи {{ kms-full-name }}](../../../kms/concepts/key.md) для шифрования и расшифровки секретов, а также подключать заранее созданные [группы безопасности](../../../managed-kubernetes/operations/connect/security-groups.md). В комбинации с ролью `load-balancer.admin` позволяет создать сетевой балансировщик нагрузки с [публичным IP-адресом](../../../vpc/concepts/address.md#public-addresses). Включает роли:
* `{{ roles.k8s.tunnelClusters.agent }}`
* `vpc.privateAdmin`
