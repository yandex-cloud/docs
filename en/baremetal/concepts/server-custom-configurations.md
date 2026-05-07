# Custom {{ baremetal-name }} server configuration {#custom}

If looking for particular server hardware specifications, you can build a custom [server configuration](../operations/servers/custom-server-lease.md) by selecting the following:

* CPU type
* Type and size of RAM
* Type, number, and capacity of storage drives
* Network interface speed and [MC-LAG](./mc-lag.md) support
* [Redundant power supply](./servers.md#server-power-supply) availability

{{ yandex-cloud }} guarantees that the components for your configuration are in stock. Use the management console to select components and order your configuration. For more information on how to rent a custom configuration server, see [{#T}](../operations/servers/custom-server-lease.md).

## Configuration templates {#templates}

As a starting point for your server configuration, you can use a _template_ that is based on one of the [stock configurations](./server-configurations.md) available in {{ baremetal-full-name }}. You are free to customize the hardware specs of a template when creating your own configuration.

## Building a server {#assembly}

After you place the order, we start building a server based on your selected configuration. It may take up to four calendar days to build and start such a server. Once the build is complete and the server enters the `RUNNING` [status](./servers.md#server-status), you will get a notification and can start using the server.
