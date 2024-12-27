# Servers

A {{ baremetal-name }} server is a physical server fully [configured](./server-configurations.md) for use. It is connected to a [network](./network.md) over two network interfaces with a throughput of 1 or 10 Gbit/s. The server's hardware and network resources are physically isolated and can be accessed only by the user leasing the server. The server is leased out without access to BIOS settings.

## Server lease {#server-lease}

You can lease a server for 1, 3, 6 months or 1 year. You can view the configurations available for lease in each pool when ordering a server in the management console. 

## Server access {#server-access}

You can manage a server using the KVM console, which is available from the [management console]({{ link-console-main }}).

## Server pools {#server-pools}

Pools are infrastructurally separate data center modules servers physically reside in. Pools are distributed across [availability zones](../../overview/concepts/geo-scope.md) located in [regions](../../overview/concepts/region.md). Currently, {{ baremetal-full-name }} is only available in the Russia region.

| Region        | Availability zone | Pools                               |
|---------------|------------------|------------------------------------|
| `{{ region-id }}` | `{{ region-id }}-m`  | `{{ region-id }}-m3`<br>`{{ region-id }}-m4` |

## Server statuses {#server-status}

A server can have one of the following statuses:

* `PROVISIONING`: Server is being prepared to be leased out to a user.
* `RUNNING`: Server is leased out and fully available to a user. In this status, the server's power supply can be turned on or off.
* `STARTING`: Server is being powered up.
* `STOPPING`: Server is being powered down.
* `RESTARTING`: Server is rebooting.
* `REINSTALLING`: Server operating system is being reinstalled.
* `UPDATING`: Server or network settings are being updated.
* `QUARANTINING`: Server is being [quarantined](#quarantine).
* `QUARANTINED`: Server is quarantined. Users cannot access quarantined servers over the network or through a KVM console.
* `RETURNING_FROM_QUARANTINE`: Server is returning from quarantine, with access being restored over the network and through a KVM console.
* `ERROR`: There is an error. Contact [support]({{ link-console-support }}).

## Quarantine {#quarantine}

Quarantine: A transition state before server lease is fully terminated. In this state, the server is still listed in the user's directory. Users cannot access quarantined servers over the network or through a KVM console, but the server retains all user data and settings. The quarantine period is 72 hours. Following this period, the settings and data get completely deleted from the server, and the server itself gets removed from the user's directory.

#### See also {#see-also}

* [{#T}](../../backup/tutorials/backup-baremetal.md)