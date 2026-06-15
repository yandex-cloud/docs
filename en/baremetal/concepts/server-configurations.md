# Stock server configurations

You can order a server in one of the stock configurations. For example, by selecting a configuration with preferred CPU, RAM, number of [disks](./disks/disk-types.md), type and number of network interfaces. Alternatively, you can choose a server specifically tailored for a particular task, such as servers with a powerful processor for high-performance computing or servers for data storage with many large disks.

For more information on how to rent a stock configuration server, see [{#T}](../operations/servers/server-lease.md).

If there are no suitable stock configurations, you can design a [custom one](../operations/servers/custom-server-lease.md) from available parts or [contact us](https://yandex.cloud/en/services/baremetal#contact-form) for a [on-request configuration](server-individual-configurations.md).

## Configuration components {#components}

You can view rentable configurations in each pool when ordering a server in the [management console]({{ link-console-main }}) or via the [{{ yandex-cloud }} CLI](../../cli/cli-ref/baremetal/cli-ref/configuration/get.md) and [API](../api-ref/Configuration/get.md).

Configuration information includes the following details:

* Configuration name, e.g., `LA-i107-S-1/10G`.
* Configuration ID in standard {{ yandex-cloud }} [format](../../api-design-guide/concepts/resources-identification.md). The ID is available only when retrieving the configuration using the {{ yandex-cloud }} CLI and API.
* Amount of RAM.
* CPU data.
* Storage device data.
* [Network interface](./servers.md#network-interfaces) data. Including the ability to connect network interfaces to different types of subnets:

    * To [private](./private-network.md#private-subnet) subnets (`PRIVATE`).
    * To [public](./public-network.md) subnets (`PUBLIC`).

In {{ baremetal-full-name }}, you can lease stock server configurations if there is free capacity in the required pools. You can view the list of stock configurations [here](https://yandex.cloud/en/services/baremetal).
