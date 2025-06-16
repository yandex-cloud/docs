---
title: How to connect a Linux VM to {{ backup-full-name }}
description: Follow this guide to connect a Linux VM to {{ backup-name }}.
---

# Connecting an existing Linux VM to {{ backup-name }}

You can back up your {{ compute-name }} [VMs](../../compute/concepts/vm.md) with [supported Linux-based operating systems](../concepts/vm-connection.md#linux).

{% include [requirements](../../_includes/backup/requirements.md) %}

{% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

If you have [deleted](delete-vm.md) a VM from {{ backup-name }} and want to reconnect it, follow the steps below.

To connect a Linux VM to {{ backup-name }}:

1. [{#T}](#create-sa).
1. [{#T}](#connect-sa-to-vm).
1. [{#T}](#configure-network-access).
1. [{#T}](#connect-vm).


## Create a service account {#create-sa}

{% include [create-sa-backup-editor](../../_includes/backup/operations/create-sa-backup-editor.md) %}


## Link a service account to the VM {#connect-sa-to-vm}

{% include [connect-sa-to-vm](../../_includes/backup/operations/connect-sa-to-vm.md) %}


## Set up network access for the VM {#configure-network-access}

### Create a security group {#create-sg}

{% include [create-sg](../../_includes/backup/operations/create-sg.md) %}


### Configure the VM network interface {#configure-vm}

{% include [configure-vm](../../_includes/backup/operations/configure-vm.md) %}


## Install the {{ backup-name }} agent {#connect-vm}

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
1. Install the {{ backup-name }} agent on the VM:

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

{% note info %}

{% include [lvm-restoration-notice](../../_includes/backup/lvm-restoration-notice.md) %}

{% endnote %}

#### See also {#see-also}

* [{#T}](create-vm.md)
* [Linking a VM to a backup policy](policy-vm/update.md#update-vm-list)
* [{#T}](policy-vm/create.md)
* [{#T}](backup-vm/recover.md)
