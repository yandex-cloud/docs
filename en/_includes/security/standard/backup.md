# 6. Backup


#### 6.1 Use {{ backup-short-name }} or scheduled snapshots {#snapshot}

Make sure to back up all VMs in your organization using one of these options: 
* Scheduled snapshots
* {{ backup-short-name }}

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the VMs in.
  1. In the list of services, select {{ compute-short-name }}.
  1. Make sure that the scheduled snapshot policy is set up on the VMs.
  1. In the list of services, select {{ backup-short-name }}.
  1. Make sure that it is enabled.

{% endlist %}
