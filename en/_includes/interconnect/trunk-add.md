## Setting up a trunk {#trunk-create}

This tutorial describes steps to set up a trunk.

### Getting started {#trunk-prep}

* See the [documentation](../../interconnect/concepts/overview.md) to learn how the service works.
* Contact your {{ yandex-cloud }} manager to agree on the service activation rate ([traffic package](../../interconnect/concepts/bandwidth.md)).
* Select a [point of presence](../../interconnect/concepts/pops.md) for connecting a [trunk](../../interconnect/concepts/trunk.md).

{% note tip %}

To ensure fault tolerance, connect trunks in two points of presence.

{% endnote %}

* Select the type of an [optical transceiver](../../interconnect/concepts/transceivers.md) to enable a cross connect to the {{ yandex-cloud }} equipment in the [point of presence](../../interconnect/concepts/pops.md). A port of the selected type will be reserved for you on the {{ yandex-cloud }} equipment side. For installation on your equipment, purchase the transceiver of the selected type on your own.
* If a {{ yandex-cloud }} solution architect is working with you, discuss and agree with them how to set up the {{ interconnect-full-name }} service.

### Contacting support to set up a new trunk {#trunk-ticket}

Create a [new support request]({{ link-console-support }}/create-ticket) to reserve a port on the {{ yandex-cloud }} equipment and set up a trunk.

{% note warning %}

The trunk attribute values in the request below are given for indicative purposes only. Each customer should have their own attribute values.

{% endnote %}

Write a support request as follows:

```s
Subject: [CIC] Creating a new trunk.

Request text:
Please set up a new Cloud Interconnect connection (trunk) with the following parameters:

client: My Business Ltd.
cloud-id: b1g8dn6s3v2eiid9dbci
folder-id: b1g28j9359gic3p2gca2
point of presence: M9
transceiver type: 10GBASE-LR
traffic package: 200mbps

We will provide information for setting up a private connection later in a separate ticket.
```

Where:

* `client` is the company name.
* `cloud-id` is the [ID of the cloud](../../resource-manager/concepts/resources-hierarchy#cloud), the resources of which {{ interconnect-name }} will connect to.
* `folder-id` is the [ID of the folder](../../resource-manager/concepts/resources-hierarchy#folder) to send {{ interconnect-name }} monitoring metrics to.
* `point of presence` is the [code of the point of presence](../../interconnect/concepts/pops.md).
* `transceiver type` is the [type of transceiver](../../interconnect/concepts/transceivers.md) to enable a cross connect.
* `traffic package` is the [bandwidth](../../interconnect/concepts/bandwidth.md) in Mbps referring to the traffic package selected by the customer.

{% note warning %}

If you need a fault-tolerant {{ interconnect-name }} connection to set up in multiple points of presence, create a separate support request for each connection.

{% endnote %}


### Support team's response to the customer's request {#trunk-ticket-resp}

Once the requested trunk is set up, the support team will send you information about the created trunk.

Here is how a response from the support team may look like:

```s
trunk_id: euus5dfgchu23b81d472
pop: M9
rack: 10th floor, room 30-1, row 11, space 10
unit: 36
port: 18
```

Where:

* `trunk_id` is the ID of the created {{ interconnect-name }} trunk.
* `pop` is the [code of the point of presence](../../interconnect/concepts/pops.md) where the {{ interconnect-name }} trunk is created.
* `rack` is the location of the {{ yandex-cloud }} equipment in the point of presence.
* `unit` is a number from 1 to 45. Indicates the equipment location in the {{ yandex-cloud }} rack.
* `port` is a number from 1 to 48. Specifies the port number on the equipment to enable the cross connect for.


### How to write an agreement letter for a point of presence {#letter}

{% note warning %}

No agreement letter is required for the `STD` point of presence.

{% endnote %}

* Download the [agreement letter form](../../interconnect/concepts/pops.md#letter) for the desired point of presence in `.docx` format.
* In the form, specify your company data and equipment location in the point of presence (highlighted in yellow).
* Using the information received from the support team, set the `unit` and `port` parameter values in the form (highlighted in green).
* Attach the completed form to the open support request.
* Within two business days, you will receive the agreement letter in PDF format signed by {{ yandex-cloud }} as an attachment to the open support request.

### Setting up a cross connect in a point of presence {#trunk-cross}

Request and set up a cross connect between your equipment and {{ yandex-cloud }} in the desired point of presence using the agreement letter you received.

A cross connect to a port of the {{ yandex-cloud }} equipment is enabled by the technical staff of the point of presence or by the customer without involving the {{ yandex-cloud }} technical staff.

{% note warning %}

If required, the technical staff of the point of presence may request additional approval from Yandex duty engineers to enable the customer's equipment cross connect to the {{ yandex-cloud }} equipment port.

{% endnote %}

### Monitoring the trunk status {#trunk-check}

Use the [monitoring](../../interconnect/concepts/monitoring.md#trunk-mon) service to track when the trunk's physical port on the {{ yandex-cloud }} equipment switches to the running status. If there are any issues, contact support so that they may run diagnostics and troubleshooting.

{% note alert %}

Private and public connections can only be set up after the trunk's physical port changes to the running status.

{% endnote %}

