# Network on a VM

When creating a VM, you need to specify settings for the network interface connected to it: select the [subnet](../../vpc/concepts/network.md#subnet) to connect the VM to and configure its [internal](#internal-ip) and [public](#public-ip) IP addresses. This allows the VM to interact with other services on the intranet and internet.

After the network interface is connected, the VM will be assigned the internal IP address in the subnet and [FQDN](#hostname). The public IP address will only be assigned if this was set when creating the VM.

You can find out the IP addresses, FQDN and other information in the management console (go to the **Network** section on the virtual machine's page). This data can be used to connect to the VM.

On VMs created from public Linux images, the IP address and hostname (FQDN) are not automatically written to the `/etc/hosts` file. This can affect the execution of the `sudo` command.

You can change the network interface settings on the stopped VMs: assign a public IP address, change the subnet, or configure the DNS settings.

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

## Hostname and FQDN {#hostname}

When creating a VM, it is assigned a hostname and FQDN. You can use the FQDN to access a VM from another VM within the same cloud network.

You can specify a VM's hostname when creating it. Based on the hostname and region, the fully qualified domain name (FQDN) will be generated in the following format:

```
<hostname>.ru-central1.internal
```

For example, if you specified the hostname `myinstance`, the FQDN will be like this:

```
myinstance.ru-central1.internal
```

{% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

If no hostname is specified, the VM's ID will be used as its hostname. In this case, the region is omitted, because the VM's ID is unique within the entire {{ yandex-cloud }}.

```
<ID>.auto.internal
```

## MAC Address {#mac-address}

After the network interface is connected to a VM, it will be assigned the MAC address of the device.

You can find out the MAC address from inside the VM or in the resource information using the {{ yandex-cloud }} API.

