---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Detaching a disk from a VM

To detach a disk from a VM:

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. View a description of the CLI's detach disk command:
  
      ```
      $ yc compute instance detach-disk --help
      ```
  
  1. Get a list of VMs in the default folder:
  
      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}
  
  1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).
  
  1. Stop the VM:
  
      ```
      $ yc compute instance stop first-instance
      ```
  
  1. Get a list of disks attached to the VM:
  
      ```
      $ yc compute instance get --full first-instance
      ```
  
  1. Choose the `disk_id` of the disk you need (for example, `fhm4aq4hvq5g3nepvt9b`).
  
  1. Detach the disk:
  
      ```
      $ yc compute instance detach-disk first-instance \
          --disk-id fhm4aq4hvq5g3nepvt9b
      ```
  
  1. Start the VM:
  
      ```
      $ yc compute instance start first-instance
      ```
  
- API
  
  Use the [detachDisk](../../api-ref/Instance/detachDisk.md) method for the [Instance](../../api-ref/Instance/) resource.
  
{% endlist %}

