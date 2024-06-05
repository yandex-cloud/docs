---
title: "{{ yandex-cloud }} {{ support-center-name }}"
description: "This guide will help you get started with the {{ yandex-cloud }} {{ support-center-name }}: find troubleshooting recommendations, create or view support tickets, or change your service plan."
---

# Working with {{ support-center-name }}

{{ support-center-name }} will help you troubleshoot {{ yandex-cloud }} issues and create or view support tickets. You can also change your service plan in {{ support-center-name }}.

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if you are not signed up yet.
1. Open the {{ support-center-name }} [home page]({{ link-console-support }}).
1. Select the [organization](../organization/quickstart.md) to work with {{ support-center-name }} in or [create a new one](../organization/operations/enable-org).

If you are using the support center from your own organization, open the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page and make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status.

## Troubleshooting {#search-for-solution}

To find answers to questions about {{ yandex-cloud }}, do the following in {{ support-center-name }}:

1. Open the {{ support-center-name }} [home page]({{ link-console-support }}).
1. Go to **{{ ui-key.support-center.common.tickets }}**.
1. Check out the answers to FAQs using quick search buttons.
1. If you did not find your question in the FAQ list:
   1. In the **{{ ui-key.support-center.search.common.value_search-input-placeholder }}** window, provide a brief description of your issue, e.g., `How to restore access to a billing account`. {{ yandex-cloud }} {{ support-center-name }} will take your query to the technical support knowledge base and return all relevant articles.
   1. If no suitable article is found, a notification window will appear under the search bar. In this window, click **{{ ui-key.support-center.search.common.action_search-in-documentation }}** to find the answer to your question in the {{ yandex-cloud }} documentation.

## Creating a ticket {#create-request}

If you [searched for a way to resolve your issue](#finding-solution) in the support knowledge base and did not find anything in the {{ yandex-cloud }} documentation, create a ticket for support:

1. Open the {{ support-center-name }} [home page]({{ link-console-support }}).
1. Go to **{{ ui-key.support-center.common.tickets }}**.
1. Click **{{ ui-key.support-center.tickets.common.action_create-ticket }}**.
1. Fill out the following fields in the **{{ ui-key.support-center.ticket.create.title_create-ticket-page }}** form that opens:
   * **{{ ui-key.support-center.ticket.create.field_ticket-type }}**: Select the ticket type that describes your issue best.
   * **{{ ui-key.support-center.ticket.create.field_service }}**: Specify the service you have an issue with.
   * **{{ ui-key.support-center.ticket.create.field_subject }}**: Enter the subject of your ticket.
   * **{{ ui-key.support-center.ticket.create.field_message }}**: Provide a detailed description of the issue. For best results, specify the resource ID and the event date and time.
   * **{{ ui-key.support-center.ticket.create.field_attachments }}**: Optionally, attach screenshots or other files that may help describe your ticket in better detail.
   * **{{ ui-key.support-center.ticket.create.field_access-type }}**: Select who will be able to see your ticket.
1. Click **{{ ui-key.support-center.ticket.create.action_create-ticket }}**.

## Viewing tickets {#view-requests}

You can view all submitted tickets you have access to on the {{ support-center-name }} [home page]({{ link-console-support }}) under **{{ ui-key.support-center.tickets.list.title_ticket_table }}**.

To quickly find the ticket you need, use filters and sorting by:
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