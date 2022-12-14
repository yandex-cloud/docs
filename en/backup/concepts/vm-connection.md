# Connecting {{ compute-name }} instances to {{ backup-name }}

If you want to back up your [{{ compute-full-name }} instance](../../compute/concepts/vm.md) in the {{ backup-full-name }} service, you need to connect it to this service and set it up properly.

You can connect your instance to {{ backup-name }} at [creation](../../compute/operations/vm-create/create-linux-vm.md) by selecting an appropriate option. The option shows up only if a [supported operating system](#os) is installed on the VM. For more information about the connection, see the [instructions](../operations/create-vm.md).

For the connection to work correctly, when creating an instance, you need to assign to it a [service account](#sa) with the `backup.editor` role, a [public IP address](#public-ip-address), and a [security group](#security-groups) with relevant rules (if this functionality is enabled for your cloud).

Once you have connected your instance to {{ backup-name }} and set it up, you need to link it to a [backup policy](policy.md).


## Supported operating systems {#os}

{{ backup-name }} supports backup for instances running Ubuntu OS versions 20.04 or lower.

The OS must be installed from a public image (a {{ marketplace-name }} product). When creating an instance, you can select the OS directly or use an [image](../../compute/concepts/image.md) or [disk snapshot](../../compute/concepts/snapshot.md) from a different instance, if the OS was installed on it from a public image as well.

Ubuntu 22.04 and CentOS 7 will be supported by {{ backup-name }} later.

## Service accounts {#sa}

[Service account](../../iam/concepts/users/service-accounts.md) is a special account on behalf of which VM backups are created and uploaded to a {{ backup-name }} storage.

When you create a VM for which you want to set up backups in {{ backup-name }}, you need to link to it a service account with the [`backup.editor` role](../security/index.md).

You can [assign the role](../../iam/operations/sa/assign-role-for-sa.md) to an existing service account or [create](../../iam/operations/sa/create.md) a service account with relevant roles.


## Public IP address {#public-ip-address}

The VM instance connected to {{ backup-name }} must exchange data with the [backup provider](index.md#providers) server. For this, when creating a VM, you need to assign to it a [public IP address](../../vpc/concepts/address.md#public-addresses) in {{ vpc-full-name }}.

Using a public IP address is a paid service. For more information, see [{#T}](../../vpc/pricing.md).


## Security groups {#security-groups}

{% include [security-groups-note](../../application-load-balancer/_includes_service/security-groups-note.md) %}

Security groups let you manage VM access to resources in {{ yandex-cloud }} or on the internet.

For your VM instance to be able to exchange data with the backup provider servers, when creating it and connecting to {{ backup-name }}, you need to select a security group that allows outgoing TCP traffic to the IP range `193.32.199.0/24` on ports  `443`, `7770-7800`, `43234`, and `45284`. For this, you need to create the following (or <q>broader</q>) rules in the group:

{% list tabs %}

- Outgoing traffic

   | Port range | Protocol | Destination type | Purpose |
   | --- | --- | --- | --- |
   | 443 | TCP | CIDR | 193.32.199.0/24 |
   | 7770-7800 | TCP | CIDR | 193.32.199.0/24 |
   | 43234 | TCP | CIDR | 193.32.199.0/24 |
   | 45284 | TCP | CIDR | 193.32.199.0/24 |

{% endlist %}

You can [add the rules](../../vpc/operations/security-group-add-rule.md) to an existing security group or [create](../../vpc/operations/security-group-create.md) a new group with the rules.
