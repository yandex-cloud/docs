---
title: "How to connect a Linux VM to {{ backup-full-name }}"
description: "Follow this guide to connect a Linux VM to {{ backup-name }}."
---

# Connecting a Linux VM to {{ backup-name }}

You can back up {{ compute-name }} [VMs](../../compute/concepts/vm.md) with [supported Linux-based operating systems](../concepts/vm-connection.md#linux).

{% include [requirements](../../_includes/backup/requirements.md) %}

{% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

1. [Create](../../iam/operations/sa/create.md) a service account with the `backup.editor` [role](../security/index.md#backup-editor).
1. [Connect](../../compute/operations/vm-control/vm-update.md) the previously created service account to the VM.
1. [Set up](../concepts/vm-connection.md#vm-network-access) network access for your VM.
1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.
1. Run the following commands:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

      ```bash
      sudo apt update && \
      sudo apt install -y jq && \
      curl https://{{ s3-storage-host }}/backup-distributions/agent_installer.sh | sudo bash
      ```

      Result:

      ```text
      ...
      Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
      ```

   - CentOS {#centos}

      ```bash
      sudo yum install epel-release -y && \
      sudo yum update -y && \
      sudo yum install jq -y && \
      curl https://{{ s3-storage-host }}/backup-distributions/agent_installer.sh | sudo bash
      ```

      Result:

      ```text
      ...
      Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
      ```

   {% endlist %}

After that, you can link your VM to [backup policies](../concepts/policy.md).

To connect an existing VM to {{ backup-name }}, you can also [take](../../compute/operations/disk-control/create-snapshot.md) snapshots of the VM disks and [create](../../compute/operations/vm-create/create-from-snapshots.md) a new VM based on those snapshots by selecting the backup option.

#### See also {#see-also}

* [{#T}](create-vm.md)
* [Attaching a VM to a backup policy](./policy-vm/update.md#update-vm-list)
* [{#T}](./policy-vm/create.md)
* [{#T}](./backup-vm/recover.md)
