### Cloud Backup or scheduled snapshots are used {#snapshot}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | compute.snapshot ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for backup and snapshot configurations on virtual machines.

{% endnote %}

Make sure to back up all VMs in your organization using one of these options:

* Scheduled snapshots
* Cloud Backup

**Performing a check in the management console:**

1. In the management console, select the cloud or folder to check the VMs in.
2. In the list of services, select Compute Cloud.
3. Make sure that the scheduled snapshot policy is set up on the VMs.
4. In the list of services, select Cloud Backup.
5. Make sure that it is enabled.

#### Guides and solutions

Guides and solutions to use:

* It is recommended to activate the Yandex Cloud Backup service: <https://yandex.cloud/en/docs/backup/operations/activate-service>