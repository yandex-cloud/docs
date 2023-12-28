# Connecting {{ compute-name }} VMs to {{ backup-name }}

To back up your [{{ compute-full-name }}](../../compute/) [VM](../../compute/concepts/vm.md) using {{ backup-name }}, you need to connect it to this service and set it up properly.

To connect your VM to {{ backup-name }}, make sure it has one of the [supported operating systems](#os) installed. For more information on connecting VMs, see [this guide](../operations/index.md#connect-vm).

For connections to work properly, link a [service account](#sa) with the `backup.editor` role to your VM or set up [network access](#vm-network-access) for the VM.

Once you have connected your VM to {{ backup-name }} and set it up, you need to link it to a [backup policy](policy.md).

## VM configuration requirements {#requirements}

A VM's minimum configuration required to install and correctly run the {{ backup-name }} agent is as follows:
* Free disk space:
  * For Linux-based VMs: 2 GB.
  * For Windows-based VMs: 1.2 GB.
* RAM: For backups, 1 GB of RAM is required per TB of a backup. The amount of RAM used depends on the volume and type of data being handled by the agent.

## Supported operating systems {#os}

You can automatically install the {{ backup-name }} agent when creating a VM from {{ marketplace-full-name }} images:

### Linux-based images {#linux}

* [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts)
* [Ubuntu 18.04 LTS](/marketplace/products/yc/ubuntu-18-04-lts)
* [Ubuntu 16.04 LTS](/marketplace/products/yc/ubuntu-26-04-lts)
* [CentOS 7](/marketplace/products/yc/centos-7)

### Windows-based images {#windows}

* [Kosmos VM 2022 based on Windows Server 2022 Datacenter](/marketplace/products/fotonsrv/kosmosvm2022)
* [Kosmos VM 2019 based on Windows Server 2019 Datacenter](/marketplace/products/fotonsrv/kosmosvm2019)
* [Kosmos VM 2016 on Windows Server 2016 Datacenter](/marketplace/products/fotonsrv/kosmosvm2016)
* [Kosmos VM RDS (5 licenses)](/marketplace/products/fotonsrv/kos-5-rds)
* [Kosmos VM RDS (10 licenses)](/marketplace/products/fotonsrv/kos-10-rds)
* [Kosmos VM RDS (50 licenses)](/marketplace/products/fotonsrv/kos-50-rds)
* [Kosmos BD WEB 2019](/marketplace/products/fotonsrv/kosmosbdweb2019)
* [Kosmos BD Standard 2019](/marketplace/products/fotonsrv/kosmosbdstd2019)
* [Kosmos VM Visio Pro 2021](/marketplace/products/fotonsrv/kosmosvisio)

{% note info %}

Install Ubuntu or CentOS from a public image (a {{ marketplace-full-name }} product). When creating a VM, you can select the OS directly or use an [image](../../compute/concepts/image.md) or [disk snapshot](../../compute/concepts/snapshot.md) from a different VM if its OS was also installed from a public image.

{% endnote %}

### Installing the agent on your own {#self-install}

You can install the {{ backup-name }} agent yourself:

* [Guide for Linux](../operations/connect-vm-linux.md)
* [Guide for Windows](../operations/connect-vm-windows.md)

For a complete list of supported operating systems, see the [backup provider documentation](https://docs.cyberprotect.ru/ru-RU/CyberBackupCloud/21.06/user/#supported-operating-systems-and-environments.html).

If you have issues while installing the agent, [contact]({{ link-console-support }}) support.

Going forward, {{ backup-name }} will support Ubuntu 22.04.

## Service accounts {#sa}

[Service account](../../iam/concepts/users/service-accounts.md) is a special account on behalf of which VM backups are created and uploaded to a {{ backup-name }} storage.

When you create a VM for which you want to set up backups in {{ backup-name }}, you need to link to it a service account with the [`backup.editor` role](../security/index.md).

You can [assign the role](../../iam/operations/sa/assign-role-for-sa.md) to an existing service account or [create](../../iam/operations/sa/create.md) a service account with relevant roles.

## VM network access permissions {#vm-network-access}

For the {{ backup-name }} agent to exchange data with the [backup provider](index.md#providers) servers, make sure the VM is granted network access to the IP addresses of {{ backup-name }} resources based on the following table:

{% list tabs %}

- Outgoing traffic

   | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
   --- | --- | --- | ---
   | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.193.0/24` |
   | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.204.0/24` |
   | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24` |
   | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.201.181.0/24` |
   | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `178.176.128.0/24` |
   | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `193.32.199.0/24` |
   | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.193.0/24` |
   | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.204.0/24` |
   | `7770-7800` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24` |
   | `8443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24` |
   | `44445` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `51.250.1.0/24` |

{% endlist %}

To provide network access, [assign](../../compute/operations/vm-control/vm-attach-public-ip.md) the VM a public IP or use a [route table](../../vpc/concepts/static-routes.md#rt-vm) that allows internet access via a [NAT gateway](../../vpc/concepts/gateways.md) or a custom router.

The VM's [security group](../../vpc/concepts/security-groups.md) rules must allow access to the specified resources. You can [add the rules](../../vpc/operations/security-group-add-rule.md) to an existing security group or [create](../../vpc/operations/security-group-create.md) a new group with the rules.

