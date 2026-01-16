## Custom {{ baremetal-name }} server configuration {#custom}

If looking for particular server hardware specifications, you can build a custom [server configuration](../operations/servers/custom-server-lease.md) by selecting the following: 

* CPU type
* Type and size of RAM
* Type, number, and capacity of storage drives
* Network interface speed and [MC-LAG](./mc-lag.md) support
* [Redundant power supply](./servers.md#server-power-supply) availability

Use the management console to select components and order your configuration. For more information on how to lease a custom configuration server, see [{#T}](../operations/servers/custom-server-lease.md).

{{ yandex-cloud }} guarantees that the components for your configuration are in stock. After you place the order, we start building your server. It may take up to four calendar days to build and start a custom configuration server. You will be notified when the build is complete and the server is in the `RUNNING` [status](./servers.md#server-status), so you can start using it.
