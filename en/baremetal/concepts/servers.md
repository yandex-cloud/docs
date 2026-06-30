# Servers

A {{ baremetal-name }} server is a physical server connected to the [network](./network.md) via two or more 1 Gbps, 10 Gbps, or 25 Gbps [network interfaces](#network-interfaces). Its hardware and network resources are physically isolated and can be accessed only by their lessee.

The server can be provided to the user in one of the [stock configurations](./server-configurations.md), a [custom configuration](./server-custom-configurations.md) built as per the user's [specification](../operations/servers/custom-server-lease.md), or an [on-request configuration](./server-individual-configurations.md) with individual hardware properties.

{% include [bios-settings-warning](../../_includes/baremetal/bios-settings-warning.md) %}

{% include [bmc-settings-change-warning](../../_includes/baremetal/bmc-settings-change-warning.md) %}

## Renting servers {#server-lease}

You can rent a stock configuration server for one day, one month, three months, six months, or one year. You can view rentable configurations in each [pool](#server-pools) when ordering a server in the [management console]({{ link-console-main }}).

You can rent a [custom-configured](./server-custom-configurations.md) server for one month, six months, or one year.

The terms and conditions of renting an [on-request configuration](./server-individual-configurations.md) are determined on a case-by-case basis.

{% note warning %}

You cannot stop renting a server during the selected rent period. The server is billable for the entire paid period, whether it is on or off. You can [cancel](../operations/servers/server-lease-cancel.md) automatic rent renewal; in this case, your server will run until the end of the paid period and then be deleted.

{% endnote %}

## Server access {#server-access}

You can manage a server using the [KVM console](../operations/servers/server-kvm.md), which is available from the [management console]({{ link-console-main }}).

## Server pools {#server-pools}

Pools are infrastructurally separate data center modules servers physically reside in. Pools are distributed across [availability zones](../../overview/concepts/geo-scope.md) located in [regions](../../overview/concepts/region.md). Currently, {{ baremetal-full-name }} is only available in the Russia region.

| Region        | Availability zone | Pools                               |
|---------------|------------------|------------------------------------|
| `{{ region-id }}` | `{{ region-id }}-m`  | `{{ region-id }}-m3`<br>`{{ region-id }}-m4` |

## Redundant power supply for servers {#server-power-supply}

When leasing a sever, you can select your configurations based on redundant power supply type:

* Servers with one power supply unit (`1 PSU`).
* Servers with two or more power supply units (`2+ PSU`).
* [Open Compute Project (OCP)](https://en.wikipedia.org/wiki/Open_Compute_Project) servers. These servers share a redundant power bus between all servers in the same rack instead of using individual power supply units.

## Server network interfaces {#network-interfaces}

Any {{ baremetal-name }} server [configuration](./server-configurations.md) includes at least two [network interfaces](https://en.wikipedia.org/wiki/Network_interface_controller) which can have the following connection options:

* Only to [private](./private-network.md#private-subnet) subnets (`PRIVATE`).
* Only to [public](./public-network.md) subnets (`PUBLIC`).
* Both to private and public subnets (`PUBLIC,PRIVATE`).

In each {{ baremetal-name }} server:
* One of the network interfaces is always capable of connecting to public subnets.
* One of the network interfaces is always capable of connecting to private subnets.

If a server network interface supports connection both to private and public networks, you can switch between these network types for that interface. For more on changing network type for a network interface, see [{#T}](../operations/servers/switch-network-type.md).

{% include [switch-iface-network-type-ddos-warn](../../_includes/baremetal/switch-iface-network-type-ddos-warn.md) %}

A server can have more than two network interfaces:
* In configurations with 10 Gbps and 25 Gbp NICs, in addition to the primary (high-speed) network interfaces, server diagnostic tools may display two more (inactive) network interfaces.

    These inactive interfaces belong to the integrated NICs of the server motherboard. They are not connected to any networks and do not require any configuration.
* In configurations with the [MC-LAG](./mc-lag.md) network connection redundancy, the server uses not one but two network interfaces at once to connect to each of the networks.

    Network interfaces connected to the same network are combined into aggregation groups at the OS level, which increases the network connection speed and ensures fault tolerance.

You can [attach](../operations/servers/set-up-tagged-vlan.md) several [private subnets](./private-network.md#private-subnet) to the server's network interface (or MC-LAG aggregation group) connected to a [private network](./private-network.md) at the same time. For more on adding additional private subnets, see [{#T}](../operations/servers/set-up-tagged-vlan.md).

## Server statuses {#server-status}

A server can have one of the following statuses:

* `PROVISIONING`: Server is being prepared to be issued to the user. You get your stock configuration server within anywhere from 30 seconds to several minutes. A custom-configured server takes up to four calendar days to be built and started.
* `RUNNING`: Rented server is fully available to the user. In this status, the server's power supply can be turned on or off.
* `STARTING`: Server is being powered up.
* `STOPPING`: Server is being powered down.
* `RESTARTING`: Server is rebooting.
* `REINSTALLING`: Server operating system is being reinstalled.
* `UPDATING`: Server or network settings are being updated.
* `QUARANTINING`: Server is being [quarantined](#quarantine).
* `QUARANTINED`: Server is quarantined. Users cannot access quarantined servers over the network or through a KVM console.
* `RETURNING_FROM_QUARANTINE`: Server is returning from quarantine, with access being restored over the network and through a KVM console.
* `DELETING`: Server deletion is in progress. It may take several hours to completely delete the server and wipe all disks.
* `ERROR`: Error has occurred, the KVM console is unavailable. Contact [support]({{ link-console-support }}).

## Quarantine {#quarantine}

Quarantine: A transition state before server rent is fully terminated. In this state, the server is still listed in the user's directory. Users cannot access quarantined servers over the network or through a KVM console, but the server retains all user data and settings. The quarantine period is 72 hours. Following this period, the settings and data get completely deleted from the server, and the server itself gets removed from the user's directory.

At any time during the quarantine period, you can restore the server for further use. For more information, see [support]({{ link-console-support }}).

{% note info %}

Servers with the `QUARANTINING`, `QUARANTINED`, `RETURNING_FROM_QUARANTINE`, or `DELETING` status are counted towards the [total quota](./limits.md) for the number of servers.

Servers with the `QUARANTINING`, `QUARANTINED`, `RETURNING_FROM_QUARANTINE`, or `DELETING` status are not billable.

If a server is restored for further use during the quarantine period, its quarantine time will be included into the paid rent period. 

{% endnote %}

#### See also {#see-also}

* [{#T}](../../backup/tutorials/backup-baremetal.md)
