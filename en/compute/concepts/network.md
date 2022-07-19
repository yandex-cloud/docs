# Network on a VM

When creating a VM, you should specify settings for the network interface connected to it: select the [subnet](../../vpc/concepts/network.md#subnet) to connect the VM to, configure [internal](#internal-ip) and [public IP addresses](#public-ip), and add the necessary [security groups](../../vpc/concepts/security-groups.md). This allows the VM to interact with other services on the intranet and internet.

{% include [security-groups-note](../_includes_service/security-groups-note.md) %}

When the network interface is connected, the VM will be assigned the internal IP address in the subnet and the [internal FQDN](#hostname). The public IP address will only be assigned if this was set when creating the VM.

You can find out the IP addresses, FQDN and other information in the management console (go to the **Network** section on the virtual machine's page). This data can be used to connect to the VM.

On VMs created from public Linux images, the IP address and hostname (FQDN) are not automatically written to the `/etc/hosts` file. This can affect the execution of the `sudo` command.

You can change the network interface settings on stopped VMs: assign a public IP address, change the subnet, select other security groups, or configure the DNS settings.

## Internal IP address {#internal-ip}

You can specify the internal IP address at which the VM will be accessible after being created. If no internal IP address is specified, it will be assigned automatically.

{% note info %}

Only IPv4 addresses are currently supported. Yandex Compute Cloud VMs and DB hosts provide access to and from the internet via public IP addresses only.

{% endnote %}

The internal IP address can be used to access a VM from another VM. You can use the internal IP address only to connect to the VMs that belong to the same [cloud network](../../vpc/concepts/network.md#network).

The internal IP address cannot be changed.

## Public IP address {#public-ip}

You can get a public IP address to access a VM from the internet.

A public IP address is assigned automatically and cannot be chosen. The address is allocated from the {{ yandex-cloud }} address pool.

{% include notitle [public-ip-reset](../../_includes/public-ip-reset.md) %}

The VM's public IP address is mapped to its internal IP address via NAT. Therefore, all requests to the VM from the external IP address are sent to the internal IP address. For more information about NAT, see [RFC 3022](https://www.ietf.org/rfc/rfc3022.txt).

## Hostname and internal FQDN {#hostname}

When creating a VM, it's assigned a hostname and internal FQDN that can be used to access a certain VM from another VM within the same [cloud network](../../vpc/concepts/network.md).

Once the VM is created, you can't change its hostname and internal FQDN.

The assigned FQDN depends on the set hostname `(CreateInstanceSpec.hostname)`. The hostname must be unique in your virtual network.

1. The `hostname` parameter can't be specified in the management console for a new VM. The user-defined VM name is used as the hostname:

   * If you leave the **Name** field empty when creating a VM, it will be assigned an internal FQDN like `<VM ID>.auto.internal`.
   * If you enter a name for the VM in the **Name** field, it will be assigned an internal FQDN like `<VM name>.<region>.internal`.

1. When using the CLI, API, and {{ TF }}, FQDNs are created as follows:

   * If you don't specify any `hostname`, the VM will be assigned a unique FQDN like `<VM ID>.auto.internal`.
   * If the `hostname` is specified and contains no "`.`", it's treated as an FQDN prefix. The VM will be assigned an internal FQDN like `<hostname>.<region>.internal`.
   * If the `hostname` is set and contains a dot "`.`" in the middle or at the end, it's treated as the FQDN. The internal FQDN assigned to the VM is the same as the `hostname`. FQDNs can't start with a dot "`.`" or contain dots "`.`" only.

### Examples {#examples}

| The set hostname | FQDN of the VM |
:--- | :---
| `<not specified>` | `<VM ID>.auto.internal` |
| `breathtaking` | `breathtaking.{{ region-id }}.internal` |
| `this-is-sparta` | `this-is-sparta.{{ region-id }}.internal` |
| `hello.world` or `hello.world.` | `hello.world` |
| `breathtaking.` | `breathtaking` |
| <span style="color: red">`.why`</span> | <span style="color: red">error (FQDN starts with ".")</span> |
| <span style="color: red">`.`</span> | <span style="color: red">error (FQDN contains dots "." only)</span> |


## MAC Address {#mac-address}

After the network interface is connected to a VM, it will be assigned the MAC address of the device.

You can find out the MAC address from inside the VM or in the resource information using the {{ yandex-cloud }} API.
