## Setting up a direct trunk {#trunk-create}

In this tutorial, we will set up a direct trunk.

### Getting started {#trunk-prep}

* See our [guides](../../interconnect/concepts/index.md) to learn how this service works.
* Select a [point of presence](../../interconnect/concepts/pops.md) for the [trunk](../../interconnect/concepts/trunk.md).


* Select the type of an [optical transceiver](../../interconnect/concepts/transceivers.md) for {{ yandex-cloud }} equipment cross-connection in the [point of presence](../../interconnect/concepts/pops.md). We will reserve a compatible transceiver port for you on the {{ yandex-cloud }} endpoint. You will need to buy a compatible transceiver to install on your endpoint.
* Select the [connection capacity](../../interconnect/concepts/capacity.md).
* If you work with a {{ yandex-cloud }} solution architect, discuss with them and agree on a {{ interconnect-full-name }} service setup plan.

### Contacting support for a new partner trunk {#trunk-ticket}

Create a [new support ticket]({{ link-console-support }}) to reserve a port on the {{ yandex-cloud }} equipment and set up a trunk.

Follow this request format:




Where:

* `client`: Company name.
* `folder-id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) that will receive {{ interconnect-name }} monitoring metrics.
* `point of presence`: [Point of presence code](../../interconnect/concepts/pops.md).
* `transceiver type`: [Type of a cross connect transceiver](../../interconnect/concepts/transceivers.md).
* `connection capacity`: [Bandwidth](../../interconnect/pricing.md) in Mbps.


### Support team's response to the your ticket {#trunk-ticket-resp}

Once the trunk setup has been completed, the support team will send you the following information.

Support response example:



Where: 

* `trunk_id`: New {{ interconnect-name }} trunk ID.
* `pop`: [Point of presence](../../interconnect/concepts/pops.md) code.
* `rack`: {{ yandex-cloud }} equipment location at the point of presence.
* `unit`: Number between 1 and 45 that shows where your equipment is located in the {{ yandex-cloud }} rack.
* `port`: Number between 1 and 48 specifying the port number for cross connection.


### Monitoring the trunk status {#trunk-check}

Use the [monitoring](../../interconnect/concepts/monitoring.md#trunk-mon) service to track when the physical port of the trunk on the {{ yandex-cloud }} endpoint transitions to the operational state. If there are any issues, contact support for diagnostics and troubleshooting.

{% note alert %}

A private or public connection can only be established after the physical port of the trunk becomes operational.

{% endnote %}

