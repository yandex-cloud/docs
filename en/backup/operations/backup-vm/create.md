---
title: "How to create a VM backup in {{ backup-full-name }}"
description: "Follow this guide to create a backup of your VM."
---

# Creating a VM backup

To create a backup of your VM, [connect](../../concepts/vm-connection.md) it to {{ backup-name }}, and [link](../policy-vm/attach-and-detach-vm.md#attach-vm) it to at least one [backup policy](../../concepts/policy.md). Any backup can only be created within policies.

VM backups in {{ backup-name }} are automatically created on the schedule specified in the respective policy.

To create a non-scheduled VM backup:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select a folder in which to create a backup.
  1. In the list of services, select **{{ compute-name }}**.
  1. Select the VM to create a backup of.
  1. Go to the **Backups** tab.
  1. Click **Create backup**.
  1. In the window that opens, select the backup policy to create the VM backup under and click **Create**.

  The VM backup creation will start.

{% endlist %}