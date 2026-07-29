---
title: Connecting VMs and servers located outside {{ yandex-cloud }} to {{ backup-full-name }}
description: In this tutorial, you will learn how to connect VMs and servers located in your own infrastructure or in a third-party provider infrastructure to {{ backup-full-name }}.
---

# Connecting VMs and servers from outside {{ yandex-cloud }} to {{ backup-name }} 


With {{ backup-full-name }}, you can create backups of external resources, i.e., servers or VMs, located outside {{ yandex-cloud }}.

{{ backup-name }} allows you to store backups of your resources in our highly available and fault-tolerant [{{ objstorage-full-name }}](../../../storage/index.yaml) as well as manage backups and restore your resources using native {{ yandex-cloud }} [interfaces](../../../overview/concepts/interfaces.md). You can also use {{ backup-name }} to streamline the migration of VMs and servers from your infrastructure or a third-party provider infrastructure to the {{ yandex-cloud }} infrastructure.

To create backups of external VMs or servers, you need to install the [{{ backup-name }} agent](../agent.md) on those VMs or servers.

{% note info %}

To install the {{ backup-name }} agent, you need the `backup.user` [role](../../security/index.md#backup-user) or higher.

{% endnote %}

For more on installing the {{ backup-name }} agent on VMs or servers located outside {{ yandex-cloud }}, see [{#T}](../../operations/external/connect.md).

After installing the {{ backup-name }} agent, [link](../../operations/policy-vm/attach-and-detach-vm.md#attach-vm) your VM or server to a [backup policy](../policy.md).

## Supported operating systems {#supported-oss}

Currently, the {{ backup-name }} agent can be installed on VMs and servers running the following operating systems:

{% include [baremetal-os-list](../../../_includes/backup/baremetal-os-list.md) %}

For a complete list of supported operating systems, see the [backup provider documentation](https://docs.cyberprotect.ru/ru-RU/CyberBackupCloud/21.06/user/#supported-operating-systems-and-environments.html).

## Updating the operating system kernel {#os-kernel-update}

{% include [update-kernel-headers-description](../../../_includes/backup/operations/update-kernel-headers-description.md) %}

For information on how to upgrade the Linux kernel header version, see [{#T}](../../operations/backup-baremetal/restore-agent.md).

## Network access permissions {#vm-network-access}

For the {{ backup-name }} agent to be able to exchange data with the [backup provider servers](../index.md#providers), make sure the VM or server has consistent internet access and network access to the IP addresses of the {{ backup-name }} resources as per the table below:

{% list tabs group=traffic %}

- Outgoing traffic {#outgoing}

  {% include [outgoing-rules](../../../_includes/backup/outgoing-rules.md) %}

{% endlist %}

Make sure the VM or sever network settings do not block outgoing traffic to the specified resources.

{% note tip %}

When installing the {{ backup-name }} agent on your VM or server, you may need to install some missing software components from the internet. To have this done, allow all outgoing network traffic for the network interface for as long as the installation continues. Once the {{ backup-name }} agent is installed, you can restrict network traffic once again in line with the permissions [required](#vm-network-access) for the agent to operate.

{% endnote %}

#### See also {#see-also}

* [{#T}](../../operations/external/connect.md)
* [{#T}](../../operations/backup-baremetal/restore-agent.md)
* [{#T}](./compute.md)
* [{#T}](./baremetal.md)