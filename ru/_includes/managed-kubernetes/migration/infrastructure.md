## Подготовьте инфраструктуру {{ yandex-cloud }} {#infrastructure}

Подготовьте целевую среду в {{ yandex-cloud }} для переноса нагрузок.

### Настройте доступы и права {#access-and-permissions}

[Создайте сервисные аккаунты](../../../iam/operations/sa/create.md) для управления ресурсами кластера и рабочих узлов и [назначьте им роли](../../../iam/operations/sa/assign-role-for-sa.md).

{% cut "Какие роли могут потребоваться?" %}

Для управления кластером:

* `k8s.clusters.agent`
* `k8s.tunnelClusters.agent` — вместо `k8s.clusters.agent`, если кластер создается в режиме туннелирования.

Подробнее о [ролях {{ managed-k8s-name }}](../../../managed-kubernetes/security/index.md).

Для управления сетевыми ресурсами:

* `vpc.publicAdmin`
* `vpc.privateAdmin`
* `vpc.user`
* `vpc.bridgeAdmin` — если VPC находится в другом каталоге.

Подробнее о [ролях {{ vpc-short-name }}](../../../vpc/security/index.md).

Для работы с образами:

* `cloud-registry.artifacts.puller`

Подробнее о [ролях {{ cloud-registry-name }}](../../../cloud-registry/security/index.md).

Для шифрования секретов:

* `kms.keys.encrypterDecrypter`

Подробнее о [ролях {{ kms-short-name }}](../../../kms/security/index.md).

Для резервного копирования в {{ objstorage-short-name }}:

* `storage.editor`

Подробнее о [ролях {{ objstorage-short-name }}](../../../storage/security/index.md).

{% endcut %}

### Создайте сетевую инфраструктуру {#network-infrastructure}

Настройте сетевую инфраструктуру, необходимую для работы кластера, — изолированную сеть с настроенными правилами безопасности для всех типов трафика кластера.

1. Создайте [сеть](../../../vpc/operations/network-create.md) и [подсети](../../../vpc/operations/subnet-create.md) в выбранных [зонах доступности](../../../overview/concepts/geo-scope.md). Для обеспечения высокой доступности используйте несколько зон.
1. Создайте [группы безопасности](../../../managed-kubernetes/operations/connect/security-groups.md) для изоляции трафика кластера, узлов и входящих соединений.

### Создайте кластер {{ managed-k8s-name }} {#cluster}

1. [Создайте кластер](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) {{ managed-k8s-name }}. Выбирайте версию {{ k8s }} не ниже версии в исходном кластере.
1. [Создайте группу узлов](../../../managed-kubernetes/operations/node-group/node-group-create.md) в каждой из выбранных зон доступности.
