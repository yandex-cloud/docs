---
title: How to create a deal as part of a scheduled procurement
description: Follow this guide to create a deal as part of a scheduled procurement.
---

# Creating a deal as part of a scheduled procurement

To create a [deal as part of a scheduled procurement](../../program/var-tools.md#tender) in the Partner portal:

{% list tabs group=instructions %}

- Partner portal {#partner}

  1. Go to the [partner portal]({{ link-cloud-partners }}).
  1. In the left-hand panel, select ![icon](../../../_assets/console-icons/briefcase.svg) **Deals**.
  1. In the top-right corner, click **Create deal**.
  1. In the window that opens:
     1. In the **Name** field, enter a name for your deal.
     1. In the **Type** list, select **Scheduled deal**.
     1. In the **Products** list, select the {{ yandex-cloud }} or Yandex 360 products your customer consumes.

        {% note warning %}

        Once a deal has been created, you cannot change products from {{ yandex-cloud }} to Yandex 360 and back.

        {% endnote %}

     1. In the **Account** list, select the customer's account. If there is no account yet, click ![image](../../../_assets/console-icons/plus.svg) and follow [this guide](../create-account.md) to create one.
     1. In the **Subaccount** list, select the customer's subaccount. If there is no subaccount yet, click ![image](../../../_assets/console-icons/plus.svg) and follow [this guide](../pin-client.md#client-entry) to create one. 
     1. In the **Amount** field, specify the target consumption of the deal.
     1. Select **Consumption type**: monthly or one-time.
     1. Specify the **Closing period** of the deal. You can specify it accurate to the month or day.
     1. Optionally, add a **Description** of the deal.

  1. Click **Create**. Your deal as part of a scheduled procurement will appear on the page featuring the deals list.

{% endlist %}
