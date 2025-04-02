# Connecting {{ compute-name }} VMs and {{ baremetal-full-name }} servers to {{ backup-name }}

If you want to back up your [{{ compute-full-name }}](../../compute/) [instances](../../compute/concepts/vm.md) or [{{ baremetal-name }} servers](../../baremetal/concepts/servers.md) in {{ backup-name }}, you need them connected VM to the service and properly set up.

{% include [baremetal-note](../../_includes/backup/baremetal-note.md) %}

You can connect the following to {{ backup-name }}:
* VMs created from [supported {{ marketplace-full-name }} images](#os). The {{ backup-name }} agent is installed automatically on such VMs.
* VMs created from other images, if those images are supported by the Cyberprotect backup [provider](./index.md#providers). You will need to [install the {{ backup-name }} agent on such VMs manually](#self-install).
* {{ baremetal-name }} servers running a [supported](#self-install) operating system. You can only install the {{ backup-name }} agent on {{ baremetal-name }} servers [manually](#self-install).

For more information about connecting to {{ backup-name }}, see these [guides](../operations/index.md).

For the connection to work properly on the VM, link a [service account](#sa) with the `backup.editor` role to the VM and configure [network access](#vm-network-access). You do not need to link the service account to {{ baremetal-name }} servers.

After connecting to {{ backup-name }}, [add](../operations/policy-vm/attach-and-detach-vm.md#attach-vm) the VM or the {{ baremetal-name }} server to the [backup policy](policy.md).

{% include [vm-running](../../_includes/backup/vm-running.md) %}

A policy can also be linked to a virtual machine when creating it. A policy is linked asynchronously after you create and initialize a VM, as well as install and configure a {{ backup-name }} agent. This may take up to 10-15 minutes. For more information, see [{#T}](../tutorials/vm-with-backup-policy/index.md).

## VM and {{ baremetal-name }} server specification requirements {#requirements}

{% include [vm-requirements](../../_includes/backup/vm-requirements.md) %}

## Supported {{ marketplace-name }} images with automatic installation of the {{ backup-name }} agent {#os}

The {{ backup-name }} agent is available for automatic installation on VMs when you create your VMs from the following {{ marketplace-name }} images:

### Linux-based images {#linux}

* [Astra Linux SE 1.7 Voronezh](/marketplace/products/astralinux/alse)
* [Astra Linux SE 1.7 Orel](/marketplace/products/astralinux/alse-orel)
* [CentOS 7](/marketplace/products/yc/centos-7)
* [CentOS 7 OS Login](/marketplace/products/yc/centos-7-oslogin)
* [CentOS Stream](/marketplace/products/yc/centos-stream-8)
* [Debian 12](/marketplace/products/yc/debian-12)
* [Ubuntu 16.04 LTS](/marketplace/products/yc/ubuntu-16-04-lts)
* [Ubuntu 18.04 LTS](/marketplace/products/yc/ubuntu-18-04-lts)
* [Ubuntu 18.04 LTS OS Login](/marketplace/products/yc/ubuntu-1804-lts-oslogin)
* [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts)
* [Ubuntu 20.04 LTS OS Login](/marketplace/products/yc/ubuntu-2004-lts-oslogin)
* [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts)
* [Ubuntu 22.04 LTS OS Login](/marketplace/products/yc/ubuntu-2204-lts-oslogin)
* [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-2404-lts-oslogin)

### Windows-based images {#windows}

* [Kosmos VM 2022 based on Windows Server Datacenter 2022](/marketplace/products/fotonsrv/kosmosvm2022)
* [Kosmos VM 2019 based on Windows Server Datacenter 2019](/marketplace/products/fotonsrv/kosmosvm2019)
* [Kosmos VM 2016 based on Windows Server Datacenter 2016](/marketplace/products/fotonsrv/kosmosvm2016)
* [Kosmos VM RDS (5 licenses)](/marketplace/products/fotonsrv/kos-5-rds)
* [Kosmos VM RDS (10 licenses)](/marketplace/products/fotonsrv/kos-10-rds)
* [Kosmos VM RDS (50 licenses)](/marketplace/products/fotonsrv/kos-50-rds)
* [Kosmos BD WEB 2019](/marketplace/products/fotonsrv/kosmosbdweb2019)
* [Kosmos BD Standard 2019](/marketplace/products/fotonsrv/kosmosbdstd2019)
* [Kosmos VM Visio Pro 2021](/marketplace/products/fotonsrv/kosmosvisio)

{% note info %}

The OS must be installed from a public image (a {{ marketplace-full-name }} product). When creating a VM, you can select the OS directly or use an [image](../../compute/concepts/image.md) or [disk snapshot](../../compute/concepts/snapshot.md) of a different VM if its OS was also installed from a public image.

{% endnote %}

Automatic installation of the {{ backup-name }} agent is not currently supported on {{ baremetal-name }} servers: you can only install it [manually](#self-install).

### Unaided installation on a supported operating system {#self-install}

You can install the {{ backup-name }} agent yourself on a VM or {{ baremetal-name }} server:

{% list tabs group=backup_resource_type %}

- VM instance {#vm}

  * [Guide for Linux](../operations/connect-vm-linux.md)
  * [Guide for Windows](../operations/connect-vm-windows.md)

  For a complete list of supported operating systems, see the [backup provider documentation](https://docs.cyberprotect.ru/ru-RU/CyberBackupCloud/21.06/user/#supported-operating-systems-and-environments.html).

- {{ baremetal-name }} server {#baremetal-server}

  You can install the {{ backup-name }} agent on a server running one of these operating systems:

  {% include [baremetal-os-list](../../_includes/backup/baremetal-os-list.md) %}

  To install the agent on a server, follow this [guide on connecting a {{ baremetal-name }} server to {{ backup-name }}](../operations/backup-baremetal/backup-baremetal.md).

{% endlist %}

If you have issues installing the {{ backup-name }} agent, [contact]({{ link-console-support }}) support.

### Updating the operating system kernel {#os-kernel-update}

{% include [update-kernel-headers-description](../../_includes/backup/operations/update-kernel-headers-description.md) %}

To update the Linux kernel header versions, follow these guides: [Restoring the {{ backup-name }} agent on a VM](../operations/update-backup-agent.md#restore-agent) and [Restoring the {{ backup-name }} agent on a {{ baremetal-name }} server](../operations/backup-baremetal/restore-agent.md).

## Service account {#sa}

[Service account](../../iam/concepts/users/service-accounts.md) is a special account the {{ backup-name }} agent uses to get registered with the Cyberprotect provider.

When creating a VM you want to configure backups for in {{ backup-name }}, you need to link to it a service account with the `backup.editor` [role](../security/index.md#backup-editor).

You do not need to link the service account to the {{ baremetal-name }} server. The IAM token of the service account with the `backup.editor` [role](../security/index.md#backup-editor) is provided to the {{ backup-name }} agent when [installing](../operations/backup-baremetal/backup-baremetal.md#agent-install) it on the server.

You can [assign the role](../../iam/operations/sa/assign-role-for-sa.md) to an existing service account or [create](../../iam/operations/sa/create.md) a new service account with required roles.

## Network access permissions {#vm-network-access}

For the {{ backup-name }} agent to be able to exchange data with the [backup provider](index.md#providers) servers, make sure the VM or {{ baremetal-name }} server has network access to the IP addresses of the {{ backup-name }} resources as per the table below:

{% list tabs group=traffic %}

- Egress traffic {#outgoing}

  {% include [outgoing traffic](../../_includes/backup/outgoing-rules.md) %}

{% endlist %}

To provide network access:
{#provide-access}
{% list tabs group=backup_resource_type %}

- VM instance {#vm}

  [Assign](../../compute/operations/vm-control/vm-attach-public-ip.md) the VM a public IP or use a [route table](../../vpc/concepts/routing.md#rt-vm) that allows internet access via a [NAT gateway](../../vpc/concepts/gateways.md) or a custom router.

  The VM's [security group](../../vpc/concepts/security-groups.md) rules must allow access to the specified resources. You can [add the rules](../../vpc/operations/security-group-add-rule.md) to an existing security group or [create](../../vpc/operations/security-group-create.md) a new group with the rules.

- {{ baremetal-name }} server {#baremetal-server}

  When [ordering a server](../../baremetal/operations/servers/server-lease.md), select `{{ ui-key.yacloud.baremetal.label_public-ip-auto }}` in the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field to assign a public IP address to the server.

  Make sure the sever network settings do not block outgoing traffic to the specified resources.

{% endlist %}
