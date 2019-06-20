# Deleting a VM

{% note important %}

Deleting a VM is an operation that cannot be canceled or reversed. You cannot restore a deleted VM.

{% endnote %}

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

If previously created disks are attached to the VM, they will be detached when the VM is deleted. The disk data will be preserved and you will be able to attach these disks to another VM in the future.

{% list tabs %}

- Management console
  
  1. Select the folder the VM belongs to.
  1. Click on the **Compute Cloud** tile.
  1. Select the VM → click ![image](../../../_assets/dots.svg) → select **Delete**.
  
      To do this with multiple VMs, select the VMs you need to delete from the list → click **Delete** at the bottom of the screen.
  
  1. Confirm the deletion.
  
- CLI
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. See the description of the CLI's delete VM command:
  
      ```
      $ yc compute instance delete --help
      ```
  
  1. Get a list of VMs in the default folder:
  
      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}
  
  1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).
  1. Delete the VM:
  
      ```
      $ yc compute instance delete first-instance
      ```
  
{% endlist %}

