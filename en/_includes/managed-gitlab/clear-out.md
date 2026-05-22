## Delete the resources you created {#clear-out}

If you no longer need the resources you created, delete them:
1. [Delete the {{ mgl-name }} instance](../../managed-gitlab/operations/instance/instance-delete.md) or the [{{ GL }}](../../compute/operations/vm-control/vm-delete.md) VM.
1. [Delete all Docker images](../../container-registry/operations/docker-image/docker-image-delete.md) from the [{{ container-registry-name }}](../../container-registry/concepts/registry.md).

Delete the other resources depending on how you created them:

{% list tabs group=instructions %}

- Manually {#manual}

  1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. [Delete](../../vpc/operations/address-delete.md) the [public static IP address](../../vpc/concepts/address.md#public-addresses) of the [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) if you reserved one.
  1. [Delete the service accounts](../../iam/operations/sa/delete.md).
  1. [Delete the {{ container-registry-name }}](../../container-registry/operations/registry/registry-delete.md).
  1. [Delete the subnets](../../vpc/operations/subnet-delete.md) and the [network](../../vpc/operations/network-delete.md).

- {{ TF }} {#tf}

  {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}