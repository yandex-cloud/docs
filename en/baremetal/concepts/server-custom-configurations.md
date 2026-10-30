---
title: Custom {{ baremetal-full-name }} server configuration
description: Select hardware specs for your {{ baremetal-name }} server and find out how to build it and prepare it for operation.
---

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

After being ordered, a server with your custom configuration switches to the `ASSEMBLING` [status](./servers.md#server-status), which means it is being assembled, installed, and connected to a network in the data center. Then the server switches to the `PROVISIONING` status, which means it is being prepared for operation. It may take up to four calendar days in total to build and prepare such a server.

You will be notified when the preparation is complete and the server is in the `RUNNING` status, allowing you to use it.
