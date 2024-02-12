---
title: "{{ yandex-cloud }} {{ support-center-name }}"
description: "This guide will help you get started with the {{ yandex-cloud }} {{ support-center-name }}: find troubleshooting recommendations, create or view support tickets, or change your service plan."
---

# Working with {{ support-center-name }}

{{ support-center-name }} will help you troubleshoot {{ yandex-cloud }} issues and create or view support tickets. You can also change your service plan in {{ support-center-name }}.

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or create an account if you do not have one yet.
1. Open the {{ support-center-name }} [home page]({{ link-console-support }}).
1. Select the [organization](../organization/quickstart.md) to work with {{ support-center-name }} in or [create a new one](../organization/operations/enable-org).

If you are using the support center from your own organization, open the [**{{ ui-key.yacloud.billing.label_service }}**]({{ link-console-billing }}) page and make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status.

## Troubleshooting {#search-for-solution}

To find answers to questions about {{ yandex-cloud }}, do the following in {{ support-center-name }}:

1. Open the {{ support-center-name }} [home page]({{ link-console-support }}).
1. Go to **Requests**.
1. Check out the answers to FAQs using quick search buttons.
1. If you did not find your question in the FAQ list:
   1. In the **Describe your issue** window, provide a brief description of your issue, e.g., `How to restore access to a billing account`. The {{ yandex-cloud }} {{ support-center-name }} will search information for your query in the support knowledge base and show all relevant articles.
   1. If no suitable article is found, a window with a corresponding message will appear under the search bar. In this window, click **Search in documentation** to find the answer to your question in the {{ yandex-cloud }} documentation.

## Creating a request {#create-request}

If a [search for a way to resolve your issue](#finding-solution) in the support knowledge base and the {{ yandex-cloud }} documentation produced no results, create a support request:

1. Open the {{ support-center-name }} [home page]({{ link-console-support }}).
1. Go to **Requests**.
1. Click **Create request**.
1. Fill out the following fields in the **New request** form that opens:
   * **Type**: Select the request type that is most appropriate for troubleshooting your issue.
   * **Service**: Select the service you encountered the issue in.
   * **Subject**: Enter a subject for your request.
   * **Message**: Provide a detailed description of the issue. It is advisable to specify the resource ID and the event date and time.
   * **Attachments**: Optionally attach any screenshots or other files that will help describe your request in more detail.
   * **Access**: Choose who will be able to see your request.
1. Click **Create request**.

## Viewing requests {#view-requests}

You can see all submitted requests you have access to on the {{ support-center-name }} [home page]({{ link-console-support }}) under **Requests**.

To quickly find the request you need, use filters and sorting by:
* Request author
* Request status
* Service specified in the request
* Response status
* Request type

If you want to reset the request filtering settings, click **Reset filters**.

## Changing your service plan {#change-pricing}

{% include [change-tariff](../_includes/support/change-pricing.md) %}

## Changing a billing account for the current service plan {#change-ba}

{% include [change-ba](../_includes/support/change-ba.md) %}