---
title: Registering a deal
description: Follow this guide to register a deal.
---

# Registering a deal


You can register a deal as part of a scheduled procurement just like a regular deal. When filling out your application, put `Yes` in the **Deal is part of a procurement under 44-FZ/223-FZ** field under **Application data**.


To register a deal:

{% list tabs group=instructions %}

- Partner portal {#partner}

  1. Log in to the [partner portal]({{ link-cloud-partners }}).
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/wrench.svg) **Partner tools**.
  1. Click the **Partner deal / project application form** link.
  1. Fill out the form. Under **Application data**, in the **Request type** field, select `New customer`.
  1. Click **Submit** and wait for the application to be approved; this may take up to 20 business days.

     {% note info %}

     After your application is approved, you will have 60 days to create a [subaccount](../terms.md#sub-account) and a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) for your customer.

     {% endnote %}

  1. Create a customer record on the partner portal:

     1. Log in to the [partner portal]({{ link-cloud-partners }}).
     1. In the top-right corner, click **Add customer**.
     1. Complete the **New customers** form with your customer's information.
     1. Click **Add**. On the partner portal, a new customer record with the `Acceptance required` status will appear in the list of customers.

        After the [partnership is verified](./pin-client.md#confirm-partnership), a subaccount will be created for the customer. The target consumption amount is calculated from the date of subaccount creation.

  1. Follow [this guide](./pin-cloud.md) to create a new cloud for your customer.

{% endlist %}