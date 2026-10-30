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

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trunk.
  1. [Navigate]({{ link-console-main }}/link/interconnect) to **{{ interconnect-name }}**.
  1. In the left-hand panel, select ![pipeline](../../_assets/console-icons/pipeline.svg) **{{ ui-key.yacloud.interconnect.trunk-connection.trunk-connections_kBGNL }}**.
  1. Click **{{ ui-key.yacloud.interconnect.trunk-connection.TrunkConnectionListScreen.create-support-request_dF6Pd }}**.

      If the folder has trunks already, click the **Contact** link in the info section above the trunk list.

      This will open the **{{ ui-key.support-center.ticket.create.title_create-ticket-page }}** form. It has **{{ interconnect-name }}** and the **{{ ui-key.yacloud.interconnect.trunk-connection.TrunkConnectionListScreen.support-form-topic_8nwBe }}** subject preselected for you.

  1. Write a request to allocate a port on the {{ yandex-cloud }} hardware and create a direct trunk. Specify the following:

      * Your company name.
      * [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create a trunk in.
      * [Point of presence code](../concepts/pops.md).
      * [Transceiver type](../concepts/transceivers.md) for cross-connection.
      * [Connection capacity](../concepts/capacity.md).

  1. Click **{{ ui-key.support-center.ticket.create.action_create-ticket }}**.

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




