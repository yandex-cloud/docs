---
title: How to create a trunk in {{ interconnect-name }}
description: Follow this guide to create a trunk in {{ interconnect-name }}.
---

# Creating a trunk

## Creating a direct trunk {#direct}

### Getting started {#direct-before-you-begin}

Before creating a trunk:

1. Select a [point of presence](../concepts/pops.md). For fault tolerance, we recommend setting up trunks at two points of presence.
1. Select [connection capacity](../concepts/capacity.md).
1. Select [optical transceiver type](../concepts/transceivers.md). Your hardware must have a compatible transceiver installed.
1. If you have no equipment at the selected point of presence, arrange with your telecom provider to establish connectivity up to that point.

{% list tabs group=instructions %}

- Via support {#support}

  Create a [support ticket]({{ link-console-support }}) to reserve a port on {{ yandex-cloud }} hardware and create a trunk.



  Where:

  * `client`: Your company name.
  * `folder-id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) the trunk will be created in.
  * `point of presence`: [Point of presence code](../concepts/pops.md).
  * `transceiver type`: [Type of a cross connect transceiver](../concepts/transceivers.md).
  * `connection capacity`: [Connection capacity](../concepts/capacity.md).

  Once the trunk is created, support will communicate to you its ID and allocated port details.

{% endlist %}

### Set up a physical connection {#direct-physical-connection}

After you create a trunk:

1. [Get information](trunk-get-info.md) about the new trunk and save the trunk ID, point of presence, and port details.



The cross-connect to {{ yandex-cloud }} equipment must be made by the technical staff at the point of presence. Monitor the status of the physical connection using [monitoring](../concepts/monitoring.md#trunk-mon). Private and public connections can be created after the physical port becomes operational.

#### What's next {#direct-next}

In your new trunk, you can:

* [Create a private connection](priv-con-create.md)
* [Create a public connection](pub-con-create.md)




