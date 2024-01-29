## Delete the resources you created {#clear-out}

If you no longer need the resources you created, delete them:
1. [Delete the {{ mgl-name }} instance](../../managed-gitlab/operations/instance/instance-delete.md) or the [created VM with the {{ GL }} image](../../compute/operations/vm-control/vm-delete.md).
1. [Delete all Docker images](../../container-registry/operations/docker-image/docker-image-delete.md) from the {{ container-registry-name }} [registry](../../container-registry/concepts/registry.md).

Delete the other resources, depending on the method used to create them:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. If you reserved a [public static IP address](../../vpc/concepts/address.md#public-addresses) for the [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), [delete it](../../vpc/operations/address-delete.md).
   1. [Delete the service accounts](../../iam/operations/sa/delete.md).
   1. [Delete the {{ container-registry-name }} registry](../../container-registry/operations/registry/registry-delete.md).
   1. [Delete the subnets](../../vpc/operations/subnet-delete.md) and [network](../../vpc/operations/network-delete.md).

- {{ TF }} {#tf}

   To delete the infrastructure [created with {{ TF }}](#deploy-infrastructure):
   1. In the terminal window, switch to the directory containing the infrastructure plan.
   1. Delete the `k8s-and-registry-for-gitlab.tf` configuration file.
   1. Check that the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.
   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All resources described in the `k8s-and-registry-for-gitlab.tf` configuration file will be deleted.

{% endlist %}