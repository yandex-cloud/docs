# Servers

A {{ baremetal-name }} server is a physical server fully [configured](./server-configurations.md) for use. It is connected to a [network](./network.md) over two network interfaces with a throughput of 1 or 10 Gbit/s. The server's hardware and network resources are physically isolated and can be accessed only by the user leasing the server. The server is leased out without access to BIOS settings.

## Server lease {#server-lease}

You can lease a server for 1, 3, 6 months or 1 year. You can view the configurations available for lease in each pool when ordering a server in the management console. 

## Server access {#server-access}

You can manage a server using the KVM console, which is available from the [management console]({{ link-console-main }}).

## Server pools {#server-pools}

Pools are infrastructurally separate data center modules physically hosting the servers. Pools are distributed across [availability zones](../../overview/concepts/geo-scope.md) located in [regions](../../overview/concepts/region.md). Currently, {{ baremetal-full-name }} is only available in the Russia region.

| Region        | Availability zone | Pools                               |
|---------------|------------------|------------------------------------|
| `{{ region-id }}` | `{{ region-id }}-m`  | `{{ region-id }}-m3`<br>`{{ region-id }}-m4` |

#### See also {#see-also}

* [{#T}](../../backup/tutorials/backup-baremetal.md)