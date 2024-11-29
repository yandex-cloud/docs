# Connecting {{ compute-name }} VMs to {{ backup-name }}

To back up your [{{ compute-full-name }}](../../compute/) [VM](../../compute/concepts/vm.md) using {{ backup-name }}, you need to connect it to this service and set it up properly.

{% include [baremetal-note](../../_includes/backup/baremetal-note.md) %}

To connect your VM to {{ backup-name }}, make sure it has one of the [supported operating systems](#os) installed. For more information on connecting VMs, see [this guide](../operations/index.md#connect-vm).

For the connection to work properly, assign a [service account](#sa) with the `backup.editor` role to your VM and configure [network access](#vm-network-access) for the VM.

After connecting to {{ backup-name }}, [add](../operations/policy-vm/attach-and-detach-vm.md#attach-vm) the VM to the [backup policy](policy.md).

{% include [vm-running](../../_includes/backup/vm-running.md) %}

You can also link a policy to a virtual machine while creating it. A policy is linked asynchronously after you create and initialize a VM, as well as install and configure a backup agent. This may take up to 10-15 minutes. For more information, see [{#T}](../tutorials/vm-with-backup-policy/index.md).

## VM configuration requirements {#requirements}

{% include [vm-requirements](../../_includes/backup/vm-requirements.md) %}

## Supported operating systems {#os}

You can automatically install the {{ backup-name }} agent when creating a VM from {{ marketplace-full-name }} images:

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

### Unaided installation {#self-install}

You can install the {{ backup-name }} agent yourself:

* [Guide for Linux](../operations/connect-vm-linux.md)
* [Guide for Windows](../operations/connect-vm-windows.md)

For a complete list of supported operating systems, see the [backup provider documentation](https://docs.cyberprotect.ru/ru-RU/CyberBackupCloud/21.06/user/#supported-operating-systems-and-environments.html).

If you have issues while installing the agent, [contact]({{ link-console-support }}) technical support.

## Service account {#sa}

[Service account](../../iam/concepts/users/service-accounts.md) is a special account on behalf of which VM backups are created and uploaded to a {{ backup-name }} storage.

When creating a VM you want to configure backups for in {{ backup-name }}, you need to link to it a service account with the [`backup.editor` role](../security/index.md).

You can [assign the role](../../iam/operations/sa/assign-role-for-sa.md) to an existing service account or [create](../../iam/operations/sa/create.md) a service account with relevant roles.

## VM network access permissions {#vm-network-access}

For the {{ backup-name }} agent to exchange data with the [backup provider](index.md#providers) servers, make sure the VM is granted network access to the IP addresses of {{ backup-name }} resources based on the following table:

{% list tabs group=traffic %}

- Egress traffic {#outgoing}

  {% include [outgoing traffic](../../_includes/backup/outgoing-rules.md) %}

{% endlist %}

To provide network access, [assign](../../compute/operations/vm-control/vm-attach-public-ip.md) the VM a public IP or use a [route table](../../vpc/concepts/routing.md#rt-vm) that allows internet access via a [NAT gateway](../../vpc/concepts/gateways.md) or a custom router.

The VM's [security group](../../vpc/concepts/security-groups.md) rules must allow access to the specified resources. You can [add the rules](../../vpc/operations/security-group-add-rule.md) to an existing security group or [create](../../vpc/operations/security-group-create.md) a new group with the rules.
