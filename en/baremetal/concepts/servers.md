# Servers

A {{ baremetal-name }} server is a fully [configured](./server-configurations.md) physical server connected to the [network](./network.md) via two 1 Gbps or 10 Gbps network interfaces. Its hardware and network resources are physically isolated and can be accessed only by the user leasing the server.

{% include [bios-settings-warning](../../_includes/baremetal/bios-settings-warning.md) %}

## Server lease {#server-lease}

You can lease a server for one day, one month, three months, six months, or one year. You can view the configurations available for lease in each pool when ordering a server in the management console. 

## Server access {#server-access}

You can manage a server using the KVM console, which is available from the [management console]({{ link-console-main }}).

## Server pools {#server-pools}

Pools are infrastructurally separate data center modules servers physically reside in. Pools are distributed across [availability zones](../../overview/concepts/geo-scope.md) located in [regions](../../overview/concepts/region.md). Currently, {{ baremetal-full-name }} is only available in the Russia region.

| Region        | Availability zone | Pools                               |
|---------------|------------------|------------------------------------|
| `{{ region-id }}` | `{{ region-id }}-m` | `{{ region-id }}-m3`<br>`{{ region-id }}-m4` |

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
* `ERROR`: Error has occurred, the KVM console is unavailable. Contact [technical support]({{ link-console-support }}).

## Quarantine {#quarantine}

Quarantine: A transition state before server lease is fully terminated. In this state, the server is still listed in the user's directory. Users cannot access quarantined servers over the network or through a KVM console, but the server retains all user data and settings. The quarantine period is 72 hours. Following this period, the settings and data get completely deleted from the server, and the server itself gets removed from the user's directory.

At any time during the quarantine period, you can restore the server for further use. To restore the server, contact [support]({{ link-console-support }}).

{% note info %}

A quarantined server does consume the server number [quota](./limits.md) but is [free of charge](../pricing.md).

If a server is not restored for further use during the quarantine period, its quarantine time will be included into the paid lease term. 

{% endnote %}

#### See also {#see-also}

* [{#T}](../../backup/tutorials/backup-baremetal.md)
