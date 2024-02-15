## Create a {{ GL }} instance {#create-gitlab}

Create a [{{ mgl-name }} instance](../../managed-gitlab/concepts/index.md#instance) or a [VM](../../compute/concepts/vm.md) with a [{{ GL }} image](../../compute/concepts/image.md) on the same [cloud network](../../vpc/concepts/network.md#network) as the [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

{% list tabs group=gl_installation %}


- {{ mgl-name }} instance {#instance-mgl}

   Create a {{ mgl-name }} instance by following [this guide](../../managed-gitlab/quickstart.md#instance-create).


- VM running a {{ GL }} image {#gl-image-vm}

   Launch {{ GL }} on a VM with a [public IP](../../vpc/concepts/address.md#public-addresses).

   {% include [create-gitlab](../../_includes/managed-gitlab/create.md) %}

{% endlist %}