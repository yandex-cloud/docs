# Creating a VM from a set of disk snapshots

To create a VM from a set of disk snapshots:

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. See the description of the CLI's create VM command:
  
      ```
      $ yc compute instance create --help
      ```
  
  1. Prepare the snapshots of the disks you need, see [#T](../disk-control/create-snapshot.md).
  
  1. Get a list of snapshots in the default folder:
  
      {% include [compute-snapshot-list](../../_includes_service/compute-snapshot-list.md) %}
  
  1. Select the `ID` or `NAME` of the necessary snapshots.
  
  1. Create a VM in the default folder:
  
      ```
      $ yc compute instance create \
          --name first-instance \
          --zone ru-central1-a \
          --public-ip \
          --create-boot-disk snapshot-name=first-snapshot \
          --create-disk snapshot-name=second-snapshot \
          --ssh-key ~/.ssh/id_rsa.pub
      ```
  
      This command creates a VM named `first-instance` in the `ru-central1-a` availability zone, with a public IP and the disks from the snapshots. To create a VM without a public IP, remove the `--public-ip` flag.
  
      {% include [name-format](../../../_includes/name-format.md) %}
  
- API
  
  Use the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource.
  
{% endlist %}

