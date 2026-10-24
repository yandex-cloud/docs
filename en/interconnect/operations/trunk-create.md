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

## Creating a partner trunk {#partner}

### Getting started {#partner-before-you-begin}

1. Select a partner from the [list](../concepts/partners.md#list).
1. Make sure the partner can provide connectivity at the required [point of presence](../concepts/pops.md) with the required [capacity](../concepts/capacity.md). For fault tolerance, we recommend setting up connections at two points of presence.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create the connection.
  1. [Navigate]({{ link-console-main }}/link/interconnect) to **{{ interconnect-name }}**.
  1. In the left-hand panel, select ![pipeline](../../_assets/console-icons/pipeline.svg) **{{ ui-key.yacloud.interconnect.trunk-connection.trunk-connections_kBGNL }}**.
  1. Click the button to create a support ticket.

      If the folder already contains trunks, click the contact support link in the information block above the list of trunks.

      The **{{ ui-key.support-center.ticket.create.title_create-ticket-page }}** form will open with the **{{ interconnect-name }}** service and the trunk creation topic selected automatically.

  1. In the ticket text, ask to create a partner trunk. Specify:

      * Your company name.
      * [ID of the folder](../../resource-manager/operations/folder/get-id.md) where you want to create the connection.
      * Partner name from the [list of partners](../concepts/partners.md#list).
      * Point of presence code from the [list of partners](../concepts/partners.md#list).
      * [Connection capacity](../concepts/capacity.md).

  1. Click **{{ ui-key.support-center.ticket.create.action_create-ticket }}**.

  Once the trunk is created, support will communicate its ID and service key to you and send the connection parameters to the partner.

{% endlist %}

### Activate the connection with the partner {#partner-activate}

After support notifies the partner about the new trunk:

1. [Get information](trunk-get-info.md) about the connection and save its `service_key`.
1. Contact the partner to arrange connection activation on their side. Provide the service key to the partner.
1. Wait for confirmation from the partner and complete connectivity setup between the partner's equipment and your equipment.

Metrics for partner trunks are not provided. Metrics for the private and public connections created within them are available in [{{ monitoring-full-name }}](../concepts/monitoring.md#private-metrics).

#### What's next {#partner-next}

In your new trunk, you can:

* [Create a private connection](priv-con-create.md)
* [Create a public connection](pub-con-create.md)




