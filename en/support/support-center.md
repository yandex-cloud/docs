---
title: '{{ yandex-cloud }} {{ support-center-name }}'
description: 'This guide will help you get started with the {{ yandex-cloud }} {{ support-center-name }}: find troubleshooting recommendations, create or view support tickets, or change your service plan.'
---

# Working with {{ support-center-name }}

{{ support-center-name }} will help you troubleshoot {{ yandex-cloud }} issues, create and view support tickets. You can also change your service plan in {{ support-center-name }}.

{% note info %}

Only a {{ yandex-cloud }} [user](../overview/roles-and-resources.md#users) can create a request in the support center. For more information, see [{#T}](./overview.md).

{% endnote %}

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.
1. Open the {{ support-center-name }} [home page]({{ link-console-support }}).
1. Select the [organization](../organization/quickstart.md) to work with {{ support-center-name }} in or [create a new one](../organization/operations/enable-org).

If accessing the support center from your own organization, check the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page to make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status.

## Troubleshooting {#search-for-solution}

To find answers to questions about {{ yandex-cloud }}, do the following in {{ support-center-name }}:

1. Open the {{ support-center-name }} [home page]({{ link-console-support }}).
1. Navigate to **{{ ui-key.support-center.common.tickets }}**.
1. Check out the answers to FAQ using quick search buttons.
1. If you did not find your question in the FAQ list:
   1. In the **{{ ui-key.support-center.search.common.value_search-input-placeholder }}** window, provide a brief description of your issue, e.g., `How to restore access to a billing account`. The {{ yandex-cloud }}{{ support-center-name }} will take your query to the support knowledge base and return all relevant articles.
   1. If no suitable article is found, a notification window will appear under the search bar. In this window, click **{{ ui-key.support-center.search.common.action_search-in-documentation }}** to find the answer to your question in the {{ yandex-cloud }} documentation or **{{ ui-key.support-center.tickets.common.action_create-ticket }}** to create a ticket.

## Creating a ticket {#create-request}

If you [searched for a way to resolve your issue](#finding-solution) in the support knowledge base and did not find anything relevant in the {{ yandex-cloud }} documentation, create a support ticket.

You can create a support ticket either on the {{ support-center-name }} [home page]({{ link-console-support }}) by clicking **{{ ui-key.support-center.tickets.common.action_create-ticket }}** or from the left-hand panel on any management console page by clicking ![image](../_assets/console-icons/circle-question.svg) **Support center** -> **{{ ui-key.support-center.tickets.common.action_create-ticket }}**.

In the **{{ ui-key.support-center.ticket.create.title_create-ticket-page }}** form that opens, proceed as follows:

1. Select the ticket format: **{{ ui-key.support-center.tickets.common.label_ticket-type-question }}**, **{{ ui-key.support-center.tickets.common.label_ticket-type-incident }}**, or **Quotas**.
1. For the **Business** or **Premium** plan, select the **Issue** priority:

   * **Medium** (default): This issue is not a blocker.
   * **High**: This issue is not a blocker but needs close attention.
   * **Critical**: This issue is a blocker and requires prompt action.

1. Fill in the form fields:

   * **{{ ui-key.support-center.ticket.create.field_service }}**: Specify the services related to your ticket. You can specify a maximum of three services.
   * **{{ ui-key.support-center.ticket.create.field_subject }}**: Enter the subject of your ticket. The system will automatically search through the knowledge base as you type.

1. If no relevant solutions are found for your ticket subject, click **Continue** and fill out the fields as follows:

   * Provide a detailed description of the situation. For best results, specify the resource ID and the event date and time.
   * If you need to attach screenshots or other relevant files, click **Attach files** or just drag and drop them into the ticket text field.
   * To attach a screenshot of your current browser tab (without the ticket creation window), use the **Add screenshot** option.
   * Select the ticket access level: **Available to everyone in the organization** or **Available only to me**.
   * **Cloud**: Select the cloud whose resources are relevant to the ticket.
   * **Resources**: Add the name, ID, or link to the resources related to your issue. You can select them with a link to the appropriate console section. If you enter the resources manually, they will be saved without a link.

1. Click **{{ ui-key.support-center.ticket.create.action_create-ticket }}**.

This will open a form with the ticket ID and a QR code for configuring push notifications in the {{ yandex-cloud }} mobile app.

## Viewing tickets {#view-requests}

To monitor your ticket status, click ![image](../_assets/console-icons/bell.svg) **{{ ui-key.yacloud.component.navigation-menu.label_notifications }}** in the left-hand panel. To quickly navigate to the ticket you need, follow the link in the notification.

You can view all submitted tickets you have access to on the {{ support-center-name }} [home page]({{ link-console-support }}) under **{{ ui-key.support-center.tickets.list.title_ticket_table }}**. 

To quickly find the ticket you need, use filters and sorting by:
* Ticket subject or ID
* Ticket reporter
* Ticket status
* Service specified in the ticket
* Response status
* Ticket type 

To clear the ticket filters, click **{{ ui-key.support-center.tickets.filters.action_reset-filters }}**.

## Changing your service plan {#change-pricing}

{% include [change-tariff](../_includes/support/change-pricing.md) %}

## Changing a billing account for the current service plan {#change-ba}

{% include [change-ba](../_includes/support/change-ba.md) %}