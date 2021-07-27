---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Creating a VM from a set of disks

You can create a VM from existing disks. The disks must reside in one of the availability zones and not be added to other VMs.

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

To create a VM from a set of disks:

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. See the description of the CLI's create VM command:
  
      ```
      $ yc compute instance create --help
      ```
  
  1. Get a list of disks in the default folder:
  
      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}
  
  1. Select the `ID` or `NAME` of the necessary disks.
  
  1. Create a VM in the default folder:
  
      ```
      $ yc compute instance create \
          --name first-instance \
          --zone ru-central1-a \
          --public-ip \
          --use-boot-disk disk-name=first-disk \
          --attach-disk disk-name=second-disk \
          --ssh-key ~/.ssh/id_rsa.pub
      ```
  
      This command creates a VM named `first-instance` in the `ru-central1-a` availability zone, with a public IP and two disks. To create a VM without a public IP, remove the `--public-ip` flag.
  
      {% include [name-format](../../../_includes/name-format.md) %}
  
      To specify whether to delete the disk when deleting the VM, set the `--auto-delete` flag:
  
      ```
      yc compute instance create \
      --name first-instance \
      --zone ru-central1-a \
      --public-ip \
      --use-boot-disk disk-name=first-disk,auto-delete=yes \
      --attach-disk disk-name=second-disk,auto-delete=yes \
      --ssh-key ~/.ssh/id_rsa.pub
      ```
  
- API
  
  Use the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource.
  
{% endlist %}

