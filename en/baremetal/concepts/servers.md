# Servers

A {{ baremetal-name }} server is a physical server with a ready-made [configuration](./server-configurations.md), connected to the network by two network interfaces with a throughput of 1 or 10 Gbit/s. The server's hardware and networking resources are physically isolated and can be accessed only by the leaser. The server is leased out without access to BIOS settings.

## Server lease {#server-lease}

You can lease a server for 1, 3, 6 months or 1 year. You can view the configurations available for lease in each pool when ordering a server in the management console. 

## Server access {#server-access}

You can manage a server using the KVM console, which is available from the [management console]({{ link-console-main }}).

## Server pools {#server-pools}

Pools are infrastructurally separate data center modules physically hosting the servers. Pools are distributed among [availability zones](../../overview/concepts/geo-scope.md) residing in [regions](../../overview/concepts/region.md). Currently, {{ baremetal-full-name }} is only available in the Russia region.

| Region        | Availability zone | Pools                               |
|---------------|------------------|------------------------------------|
| `ru-central1` | `ru-central1-m`  | `ru-central-m3`<br>`ru-central-m4` |