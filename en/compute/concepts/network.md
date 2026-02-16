# VM network interfaces

A virtual machine can have [one or more](./limits.md) network interfaces. When creating a VM, you need to configure at least one of its network interfaces by selecting the [subnet](../../vpc/concepts/network.md#subnet) to connect your VM to, configuring [internal](#internal-ip) and [public IP addresses](#public-ip), and adding the required [security groups](../../vpc/concepts/security-groups.md). This will allow the VM to connect to other services on the intranet and internet.

After the network interface is connected, the VM will be assigned an internal IP address in the subnet. A public IP address will be assigned only if you specified it in the network interface settings.

You can find out the IP addresses, FQDNs, and other information in the management console by going to the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section on the virtual machine page. This data can be used to connect to the VM.

On VMs created from public Linux images, the IP address and host name (FQDN) are not automatically written to the `/etc/hosts` file. This may affect the `sudo` command.

You can change the network interface settings on stopped VMs by assigning a public IP address, changing the subnet, selecting other security groups, or configuring the DNS settings.

You can also [add](../operations/vm-control/attach-network-interface.md) more network interfaces and [delete](../operations/vm-control/attach-network-interface.md) them from both stopped and running VMs. However, to avoid [VM routing](../../vpc/concepts/routing.md#rt-vm) issues, we recommended adding and removing network interfaces on stopped VMs.

{% include [add-network-interface-hotplug-preview-note](../../_includes/compute/add-network-interface-hotplug-preview-note.md) %}

If the network interfaces you added are inactive or you can no longer [connect](../operations/vm-connect/ssh.md) to your VM, see [Troubleshooting](../qa/troubleshooting.md).

### Recommendations {#best-practices}

For stable network operation on a VM, follow these recommendations:

* To maintain [network connectivity](../../vpc/concepts/routing.md#rt-vpc), add network interfaces to stopped VMs.
* Assign a public IP address to a single VM's network interface only.

## Internal IP address {#internal-ip}

For each network interface of a VM, you can specify an internal IP address that will be assigned to that interface. If the internal IP address is not specified, it will be assigned automatically from the IP address range of the relevant subnet.

{% note info %}

Currently, only IPv4 addresses are supported. {{ compute-full-name }} VMs and DB hosts provide access to and from the internet via public IP addresses only.

{% endnote %}

An internal IP address can be used to access a VM from another VM. You can use an internal IP address only to connect to the VMs that belong to the same [cloud network](../../vpc/concepts/network.md#network).

You can [change](../operations/vm-control/internal-ip-update.md) the internal IP address of a network interface after you create a VM.

## Public IP address {#public-ip}

To access your virtual machine from the internet, you can get a public IP address.

The public IP address can be assigned automatically from the {{ yandex-cloud }} address pool or selected from a list of [reserved](../../vpc/operations/get-static-ip.md) public IP addresses.

{% include notitle [public-ip-reset](../../_includes/public-ip-reset.md) %}

The public IP address of the VM's network interface is mapped to its internal IP address through NAT. Therefore, all requests to the VM from the external IP address of its network interface are sent to the internal IP address of that interface. For more information about NAT, see [RFC 3022](https://www.ietf.org/rfc/rfc3022.txt).

## Host name and internal FQDN {#hostname}

When creating a VM, it is assigned a host name and internal FQDN that can be used to access one VM from another within the same [cloud network](../../vpc/concepts/network.md). You can get the FQDN together with [information about the VM](../operations/vm-info/get-info.md).

Once the VM is created, you cannot change its host name and internal FQDN.

The assigned FQDN depends on the specified `(CreateInstanceSpec.hostname)`. The host name must be unique in your virtual network.

1. You cannot specify the `hostname` parameter in the management console for a new VM. Instead, the user-defined VM name is used:

	* If you leave the **{{ ui-key.yacloud.common.name }}** field empty when creating a VM, this internal FQDN will be assigned: `<VM_ID>.auto.internal`.
	* If you enter a VM name in the **{{ ui-key.yacloud.common.name }}** field, this internal FQDN will be assigned: `<VM_name>.<region>.internal`.

1. When using the CLI, API, and {{ TF }}, FQDNs are created as follows:

	* If you do not specify a `hostname`, the VM will get a unique FQDN in this format: `<VM_ID>.auto.internal`.
	* If a `hostname` is specified and does not contain the `.` symbol, it is treated as an FQDN prefix. The VM will get an internal FQDN in this format: `<hostname>.<region>.internal`.
	* If a `hostname` is specified and contains the `.` symbol in the middle or at the end, it is treated as an FQDN. The VM will get an internal FQDN that will be the same as `hostname`. You cannot specify an FQDN beginning with or containing only a period (`.`).

### Examples {#examples}

Specified host name | VM FQDN
:--- | :---
`<not_specified>` | `<VM_ID>.auto.internal`
`breathtaking` | `breathtaking.{{ region-id }}.internal`
`this-is-sparta` | `this-is-sparta.{{ region-id }}.internal`
`hello.world` or `hello.world.` | `hello.world`
`breathtaking.` | `breathtaking`
<span style="color: red">`.why`</span> | <span style="color: red">error (FQDN starts with ".")</span>
<span style="color: red">`.`</span> | <span style="color: red">error (FQDN contains dots "." only)</span>


## MAC address {#mac-address}

Once the network interface is connected to a VM, it will be assigned the device MAC address.

You can find out the MAC address from a VM or in the resource information using the {{ yandex-cloud }} API.

## Use cases {#examples}

* [{#T}](../tutorials/bastion.md)
* [{#T}](../tutorials/route-switcher.md)
* [{#T}](../tutorials/backup-and-archive-to-sftp.md)
* [{#T}](../tutorials/bind-domain-vm/index.md)
* [{#T}](../tutorials/rds-gw.md)