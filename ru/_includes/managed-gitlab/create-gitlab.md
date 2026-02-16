## Создайте инстанс {{ GL }} {#create-gitlab}

Создайте [инстанс {{ mgl-name }}](../../managed-gitlab/concepts/index.md#instance) или [виртуальную машину](../../compute/concepts/vm.md) с [образом](../../compute/concepts/image.md) {{ GL }} в той же [облачной сети](../../vpc/concepts/network.md#network), где расположен [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

{% list tabs group=gl_installation %}

- Инстанс {{ mgl-name }} {#instance-mgl}

  Создайте инстанс {{ mgl-name }} [согласно инструкции](../../managed-gitlab/quickstart.md#instance-create).

- ВМ с образом {{ GL }} {#gl-image-vm}

  Запустите {{ GL }} на ВМ с [публичным IP-адресом](../../vpc/concepts/address.md#public-addresses).

  {% include [create-gitlab](../../_includes/managed-gitlab/create.md) %}

{% endlist %}