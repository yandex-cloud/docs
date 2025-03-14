## Setting up a direct trunk {#trunk-create}

In this tutorial, we will set up a direct trunk.

### Getting started {#trunk-prep}

* See our [guides](../../interconnect/concepts/index.md) to learn how this service works.
* Contact your {{ yandex-cloud }} manager to choose your pricing plan and [connection capacity](../../interconnect/pricing.md).
* Select a [point of presence](../../interconnect/concepts/pops.md) for the [trunk](../../interconnect/concepts/trunk.md).
  
  {% note warning %}
  
  To ensure fault tolerance, we recommend setting up trunk links at two points of presence.
  
  {% endnote %}

* Select the type of an [optical transceiver](../../interconnect/concepts/transceivers.md) for {{ yandex-cloud }} equipment cross-connection in the [point of presence](../../interconnect/concepts/pops.md). We will reserve a compatible transceiver port for you on the {{ yandex-cloud }} endpoint. You will need to buy a compatible transceiver to install on your endpoint.
* If you work with a {{ yandex-cloud }} solution architect, discuss with them and agree on a {{ interconnect-full-name }} service setup plan.

### Contacting support for a new partner trunk {#trunk-ticket}

Create a [new support ticket]({{ link-console-support }}) to reserve a port on the {{ yandex-cloud }} equipment and set up a trunk.

Follow this request format:

```s
Subject: [CIC] Creating a new trunk.

Request text:
Please set up a new Cloud Interconnect trunk
with the following parameters:

client: My Business LLC 
folder-id: b1g28j9359gi********
point of presence: M9
transceiver type: 10GBASE-LR
connection capacity: 250mbps

I will send the private connection details later in a separate ticket.
```

Where:

* `client`: Company name.
* `folder-id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) that will receive {{ interconnect-name }} monitoring metrics.
* `point of presence`: [Point of presence code](../../interconnect/concepts/pops.md).
* `transceiver type`: [Type of a cross connect transceiver](../../interconnect/concepts/transceivers.md).
* `connection capacity`: [Bandwidth](../../interconnect/pricing.md) in Mbps.

{% note warning %}

If you need to set up a fault-tolerant {{ interconnect-name }} architecture with trunk links in more than one point of presence, create a separate support ticket for each link.

{% endnote %}


### Support team's response to the your ticket {#trunk-ticket-resp}

Once the trunk setup has been completed, the support team will send you the following information.

Support response example:

```s
trunk_id: euus5dfgchu2********
pop: M9
rack: 10th floor, room 30-1, row 11, space 10
unit: 36
port: 18
```

Where: 

* `trunk_id`: New {{ interconnect-name }} trunk ID.
* `pop`: [Point of presence](../../interconnect/concepts/pops.md) code.
* `rack`: {{ yandex-cloud }} equipment location at the point of presence.
* `unit`: Number between 1 and 45 that shows where your equipment is located in the {{ yandex-cloud }} rack.
* `port`: Number between 1 and 48 specifying the port number for cross connection.

### How to write an agreement letter for a point of presence {#letter}

{% note warning %}

No agreement letter is required for the `STD` point of presence.

{% endnote %}

* Download the [agreement letter form](../../interconnect/concepts/pops.md#letter) for the relevant point of presence in `.docx` format.
* In the form, fill in the highlighted yellow fields, providing information about your company and your equipment location in the point of presence.
* Using the information provided by the support team, fill in the `unit` and `port` highlighted green fields.
* Attach the completed form to your open support ticket.
* Within two business days, you will receive the letter of authorization in PDF format signed by {{ yandex-cloud }} as an attachment to your open support ticket.

### Setting up a cross connect in a point of presence {#trunk-cross}

Using the signed agreement letter you received, request setting up an interconnect between your equipment and {{ yandex-cloud }} infrastructure at the point of presence.

{% note alert %}

A cross connection, linking your equipment to a {{ yandex-cloud }} port, is performed by the **point of presence personnel**, with no {{ yandex-cloud }} engineers involved.

In certain cases, before performing cross connection, the point of presence personnel may request additional approval from {{ yandex-cloud }} engineers.

{% endnote %}


### Monitoring the trunk status {#trunk-check}

Use the [monitoring](../../interconnect/concepts/monitoring.md#trunk-mon) service to track when the physical port of the trunk on the {{ yandex-cloud }} endpoint transitions to the operational state. If there are any issues, contact support for diagnostics and troubleshooting.

{% note alert %}

A private or public connection can only be established after the physical port of the trunk becomes operational.

{% endnote %}

