---
title: Connecting {{ compute-full-name }} VMs to {{ backup-full-name }}
description: In this tutorial, you will learn how to connect {{ compute-full-name }} VMs to {{ backup-full-name }}.
---

# Connecting {{ compute-full-name }} VMs to {{ backup-name }}


To back up your [{{ compute-full-name }}](../../../compute/index.yaml) [instances](../../../compute/concepts/vm.md) in {{ backup-name }}, you need them connected to the service and properly set up.

For more information on connecting a {{ compute-name }} VM to {{ backup-name }}, see [{#T}](../../operations/index.md#connect-vm).

For the {{ backup-name }} connection to work correctly, link to the VM a [service account](#sa) with the `backup.user` [role](../../security/index.md#backup-user) or higher and configure [network access](#vm-network-access).

{% note tip %}

{% include [user-console-vm-creation-notice](../../../_includes/backup/user-console-vm-creation-notice.md) %}

{% endnote %}

After connecting to {{ backup-name }}, [associate](../../operations/policy-vm/attach-and-detach-vm.md#attach-vm) your VM with a [backup policy](../policy.md).

{% note info %}

When initiating a backup, make sure the VM is running.

{% endnote %}

A policy can also be linked to a virtual machine when creating it. A policy is linked asynchronously after you create and initialize a VM, as well as install and configure a {{ backup-name }} agent. This may take up to 10-15 minutes. For more information on automatic linking of policies to VMs, see [{#T}](../../tutorials/vm-with-backup-policy/index.md).

## Supported {{ marketplace-name }} images with automatic installation of the {{ backup-name }} agent {#os}


The {{ backup-name }} agent is available for automatic installation on {{ compute-name }} VMs if you create your VMs using the following {{ marketplace-name }} images:

### Linux-based images {#linux}

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

The OS must be installed from a public image (a {{ marketplace-full-name }} product). You can select the OS directly during VM creation or use an [image](../../../compute/concepts/image.md) or [disk snapshot](../../../compute/concepts/snapshot.md) of a different VM whose OS was also installed from a public image.

{% endnote %}

### Unaided installation on a supported operating system {#self-install}

You can manually install the {{ backup-name }} agent on a VM. For more information, see:

* [Guide for Linux](../../operations/connect-vm-linux.md)
* [Guide for Windows](../../operations/connect-vm-windows.md)

For a complete list of supported operating systems, see the [backup provider documentation](https://docs.cyberprotect.ru/ru-RU/CyberBackupCloud/21.06/user/#supported-operating-systems-and-environments.html).

If you have issues installing the {{ backup-name }} agent, [contact]({{ link-console-support }}) support.

### Updating the operating system kernel {#os-kernel-update}

{% include [update-kernel-headers-description](../../../_includes/backup/operations/update-kernel-headers-description.md) %}

For information on how to upgrade the Linux kernel header version, see [{#T}](../../operations/backup-baremetal/restore-agent.md).

## Service account {#sa}

{% note info %}

{% include [user-console-vm-creation-notice](../../../_includes/backup/user-console-vm-creation-notice.md) %}

{% endnote %}

A [service account](../../../iam/concepts/users/service-accounts.md) is a special account the {{ backup-name }} agent uses to get registered with the Cyberprotect [provider](../index.md#providers).

When creating a {{ compute-name }} VM you want to configure backups for in {{ backup-name }}, you need to link to it a service account with the `backup.user` [role](../../security/index.md#backup-user) or higher.

You can [assign the role](../../../iam/operations/sa/assign-role-for-sa.md) to an existing service account or [create](../../../iam/operations/sa/create.md) a new service account with the required role.

## Network access permissions {#vm-network-access}

For the {{ backup-name }} agent to be able to exchange data with the backup provider servers, make sure the VM has network access to the IP addresses of the {{ backup-name }} resources as per the table below:

{% list tabs group=traffic %}

- Outgoing traffic {#outgoing}

  {% include [outgoing traffic](../../../_includes/backup/outgoing-rules.md) %}

  {% note tip %}

  When installing the [{{ backup-name }}](../agent.md) agent on your VM, you may need to install some missing software components from the internet. To do this, add the following outgoing traffic rule to the [security group](../../../vpc/concepts/security-groups.md):
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.
  Once the {{ backup-name }} agent is installed, you can delete this rule.

  To access the VM over [SSH](../../../compute/operations/vm-connect/ssh.md), add the following incoming traffic rule:
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

  {% endnote %}

{% endlist %}

To provide network access: {#provide-access}

[Assign](../../../compute/operations/vm-control/vm-attach-public-ip.md) the VM a public IP or use a [route table](../../../vpc/concepts/routing.md#rt-vm) that allows internet access via a [NAT gateway](../../../vpc/concepts/gateways.md) or a custom router.

The VM's [security group](../../../vpc/concepts/security-groups.md) rules must allow access to the specified resources. You can [add the rules](../../../vpc/operations/security-group-add-rule.md) to an existing security group or [create](../../../vpc/operations/security-group-create.md) a new group with the rules.

## Connection statuses {#statuses}

{% include [connection-statuses](../../../_includes/backup/connection-statuses.md) %}

#### See also {#see-also}

* [{#T}](../../tutorials/vm-with-backup-policy/index.md)
* [{#T}](./baremetal.md)
* [{#T}](./external-resources.md)
