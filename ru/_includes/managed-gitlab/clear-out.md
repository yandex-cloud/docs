## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:
1. [Удалите инстанс {{ mgl-name }}](../../managed-gitlab/operations/instance/instance-delete.md) или [созданную виртуальную машину с образом {{ GL }}](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите все Docker-образы](../../container-registry/operations/docker-image/docker-image-delete.md) из [реестра](../../container-registry/concepts/registry.md) {{ container-registry-name }}.

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. Если вы зарезервировали для [кластера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) [публичный статический IP-адрес](../../vpc/concepts/address.md#public-addresses), [удалите его](../../vpc/operations/address-delete.md).
  1. [Удалите сервисные аккаунты](../../iam/operations/sa/delete.md).
  1. [Удалите реестр {{ container-registry-name }}](../../container-registry/operations/registry/registry-delete.md).
  1. [Удалите подсети](../../vpc/operations/subnet-delete.md) и [сеть](../../vpc/operations/network-delete.md).

- {{ TF }} {#tf}

  {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}