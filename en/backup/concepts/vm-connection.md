# Connecting {{ compute-name }} VMs to {{ backup-name }}

To back up your [{{ compute-full-name }}](../../compute/) [VM](../../compute/concepts/vm.md) using {{ backup-name }}, you need to connect it to this service and set it up properly.

To connect your VM to {{ backup-name }}, make sure it has one of the [supported operating systems](#os) installed: Linux (CentOS, Ubuntu) or Windows Server. You can connect existing Linux and Windows Server VMs or create a Linux VM with a connection to {{ backup-name }}. For more information on connecting VMs, see [this guide](../operations/index.md#connect-vm).

For the connection to work properly, you need to assign the VM a [service account](#sa) with the `backup.editor` role, a [public IP address](#public-ip-address), and a [security group](#security-groups) with relevant rules (if this feature is enabled for your [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud)).

Once you have connected your VM to {{ backup-name }} and set it up, you need to link it to a [backup policy](policy.md).

## Supported operating systems {#os}

{{ backup-name }} supports backing up VMs running the following operating systems:
* Ubuntu 20.04 or lower
* CentOS 7
* Windows Server 2019 and 2022

Install Ubuntu or CentOS from a public image (a {{ marketplace-full-name }} product). When creating a VM, you can select the OS directly or use an [image](../../compute/concepts/image.md) or [disk snapshot](../../compute/concepts/snapshot.md) from a different VM if its OS was also installed from a public image.

Going forward, {{ backup-name }} will support Ubuntu 22.04.

## Service accounts {#sa}

[Service account](../../iam/concepts/users/service-accounts.md) is a special account on behalf of which VM backups are created and uploaded to a {{ backup-name }} storage.

When you create a VM for which you want to set up backups in {{ backup-name }}, you need to link to it a service account with the [`backup.editor` role](../security/index.md).

You can [assign the role](../../iam/operations/sa/assign-role-for-sa.md) to an existing service account or [create](../../iam/operations/sa/create.md) a service account with relevant roles.

## Public IP address {#public-ip-address}

The VM instance connected to {{ backup-name }} must exchange data with the [backup provider](index.md#providers) server. For this, when creating a VM, you need to assign to it a [public IP address](../../vpc/concepts/address.md#public-addresses) in [{{ vpc-full-name }}](../../vpc/).

Using a public IP address is a paid service. For more information, see [{#T}](../../vpc/pricing.md).

## Security groups {#security-groups}

Security groups allow you to manage VM access to resources in {{ yandex-cloud }} or on the web.

For your VM instance to be able to exchange data with the backup provider servers, when creating it and connecting to {{ backup-name }}, select a security group with the following (or broader) rules:

{% list tabs %}

- Outgoing traffic

   | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
   --- | --- | --- | ---
   | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.204.0/24` |
   | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24` |
   | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.201.181.0/24` |
   | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.193.0/24` |
   | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.204.0/24` |
   | `7770-7800` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24` |
   | `8443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24` |
   | `44445` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `51.250.1.0/24` |

{% endlist %}

You can [add the rules](../../vpc/operations/security-group-add-rule.md) to an existing security group or [create](../../vpc/operations/security-group-create.md) a new group with the rules.
