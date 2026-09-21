---
title: How to send a product access request in {{ marketplace-full-name }}
description: In this article, you will learn how to send a product access request in {{ marketplace-full-name }}.
---

# Requesting product access

To start using certain products in {{ marketplace-name }}, you must submit an access request and wait for it to be approved first. This requirement is due to our security standards.

Only users with the `marketplace.productAccessRequests.editor` role for the organization can submit access requests. For more information on assigning a role for an organization, see [{#T}](../../../iam/operations/roles/grant.md#organization).

## Sending a request {#sending}

### On the {{ marketplace-name }} website {#marketplace}

1. On the [{{ marketplace-name }}](/marketplace) homepage, select the product you want to access.
1. Click **{{ ui-key.yacloud.marketplace-v2.button_request-access }}**.
1. {% include [access-request-steps](../../../_includes/marketplace/access-request-steps.md) %}

### On the **Available products** page in the management console {#console}

1. Log in to the [management console]({{ link-console-main }}).
1. [Navigate]({{ link-console-main }}/link/marketplace) to {{ marketplace-short-name }}.
1. Select the product you want to access.
1. Click **{{ ui-key.yacloud.marketplace-v2.button_request-access-from-publisher }}**.
1. {% include [access-request-steps](../../../_includes/marketplace/access-request-steps.md) %}

## Publisher chat {#publisher-chat}

The publisher may need to check some additional info with you before giving you access to the product. All questions will be displayed in the request. To answer the publisher or ask a question of your own:

1. Log in to the [management console]({{ link-console-main }}).
1. [Navigate]({{ link-console-main }}/link/marketplace) to {{ marketplace-short-name }}.
1. In the left-hand panel, click **{{ ui-key.yacloud.marketplace-v2.label_product-access-request }}**.
1. Select the request and enter your message in the **{{ ui-key.yacloud.marketplace-v2.title_product-request-messages }}** field.
1. Click **{{ ui-key.yacloud.marketplace-v2.action_send-msg }}**.

You will be able to start using the product as soon as your request status changes to `{{ ui-key.yacloud.marketplace-v2.label_product-access-request-status-approved }}`.
