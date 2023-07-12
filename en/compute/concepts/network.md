# VM networking

When creating a VM, you need to specify its network interface settings by selecting the [subnet](../../vpc/concepts/network.md#subnet) to connect the VM to, configuring an [internal](#internal-ip) and [public IP address](#public-ip), and adding the required [security groups](../../vpc/concepts/security-groups.md). This will allow the VM to connect to other services on the intranet and internet.

{% include [security-groups-note-vm](../../_includes/vpc/security-groups-note-vm.md) %}

Once the network interface is connected, the VM will be assigned an internal IP address in the subnet and an [internal FQDN](#hostname). A public IP address will only be assigned in case it was specified when creating the VM.

You can find out the IP addresses, FQDNs, and other information in the management console by going to the **Network** section on the virtual machine page. This data can be used to connect to the VM.

On VMs created from public Linux images, the IP address and hostname (FQDN) are not automatically written to the `/etc/hosts` file. This may affect running the `sudo` command.

You can change the network interface settings on stopped VMs by assigning a public IP address, changing the subnet, selecting other security groups, or configuring the DNS settings.

## Internal IP address {#internal-ip}

You can specify the internal IP address at which the VM will be accessible after being created. If do not specify any internal IP, it will be assigned automatically.

{% note info %}

Currently, only IPv4 addresses are supported. {{ compute-full-name }} VMs and DB hosts provide access to and from the internet via public IP addresses only.

{% endnote %}

An internal IP address can be used to access a VM from another VM. You can use an internal IP address only to connect to the VMs that belong to the same [cloud network](../../vpc/concepts/network.md#network).

You cannot change an internal IP address.

## Public IP address {#public-ip}

You can get a public IP address to access a VM from the internet.

A public IP address is assigned automatically and cannot be chosen. The address is allocated from the {{ yandex-cloud }} address pool.

{% include notitle [public-ip-reset](../../_includes/public-ip-reset.md) %}

The VM's public IP address is mapped to its internal IP address through NAT. This means all requests to the VM from an external IP address are sent to an internal IP address. For more information about NAT, see [RFC 3022](https://www.ietf.org/rfc/rfc3022.txt).

## Host name and internal FQDN {#hostname}

When creating a VM, it is assigned a host name and internal FQDN that can be used to access a certain VM from another VM within the same [cloud network](../../vpc/concepts/network.md).

Once the VM is created, you cannot change its host name and internal FQDN.

The assigned FQDN depends on the specified host name `(CreateInstanceSpec.hostname)`. The host name must be unique in your virtual network.

1. You cannot specify the `hostname` parameter in the management console for a new VM. Instead, the user-defined VM name is used:

	* If you leave the **Name** field blank when creating a VM, it will be assigned an internal FQDN in the `<VM ID>.auto.internal` format.
   * If you provide a VM name in the **Name** field, it will be assigned an internal FQDN in the `<VM name>.<region>.internal` format.

1. When using the CLI, API, and {{ TF }}, FQDNs are created as follows:

   * If you do not specify any `hostname`, the VM will be assigned a unique FQDN in the `<VM ID>.auto.internal` format.
   * If the `hostname` is specified and contains no periods (`.`), it is treated as an FQDN prefix. The VM will be assigned an internal FQDN in the `<hostname>.<region>.internal` format.
   * If the `hostname` is specified and contains a period (`.`) in the middle or at the end, it is treated as an FQDN. The internal FQDN assigned to the VM is the same as the `hostname`. FQDNs cannot start with a period (`.`) or only contain periods (`.`).

### Examples {#examples}

| Specified host name | VM FQDN |
:--- | :---
| `<not specified>` | `<VM ID>.auto.internal` |
| `breathtaking` | `breathtaking.{{ region-id }}.internal` |
| `this-is-sparta` | `this-is-sparta.{{ region-id }}.internal` |
| `hello.world` or `hello.world.` | `hello.world` |
| `breathtaking.` | `breathtaking` |
| <span style="color: red">`.why`</span> | <span style="color: red">error (FQDN starts with ".")</span> |
| <span style="color: red">`.`</span> | <span style="color: red">error (FQDN contains dots "." only)</span> |


## MAC address {#mac-address}

Once the network interface is connected to a VM, it will be assigned the device MAC address.

You can find out the MAC address from a VM or in the resource information using the {{ yandex-cloud }} API.
