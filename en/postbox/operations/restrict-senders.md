---
title: Limiting the list of senders in {{ postbox-full-name }}
description: Follow this guide to set up the list of permitted senders.
---

# Limiting the list of senders in {{ postbox-name }}

You can limit the list of senders when or after [creating](create-address.md) an address. To limit the list of senders for an existing address:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the address.
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. On the right of the row with the address you want to limit the list of senders for, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
    1. Enable **{{ ui-key.yacloud.postbox.label_restrict-senders }}**.
    1. Set up the list of senders:
       * To add a sender, specify their name without the domain in the **{{ ui-key.yacloud.postbox.label_allowed-senders }}** field and click **{{ ui-key.yacloud.postbox.add-allowed-sender }}**.
       * To delete a sender, click ![image](../../_assets/console-icons/trash-bin.svg) on the right of the row.
    1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}