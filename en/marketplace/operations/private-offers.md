---
title: Creating a private offer in {{ marketplace-name }}
description: In this article, you will learn how to create and activate a private offer in a {{ marketplace-name }} partner dashboard.
---

# Private offers

At first, create the following:
* [Product version](create-new-version.md) with a `Subscription` pricing plan in its settings. You can only create a private offer for a product that has an active version with a `Subscription` pricing plan.
* `Subscription` [pricing plan](create-tariff.md) you need to specify in your private offer's settings. You can use the same plan as in the product version's settings.

You need the `marketplace.privateOffers.publisher` role to use private offers.

## Creating a private offer {#create}

1. Log in to the [{{ marketplace-short-name }} partner dashboard]({{ link-cloud-partners }}).
1. Select the product for which you want to create a private offer.
1. Navigate to the **Private offers** tab.
1. Click **Create offer**.
1. Optionally, specify the ID of the billing account for which you want to create a private offer. In this case, only the user who has the view permission for this billing account will be able to accept your offer. In any other case, any user can accept your offer by following a link. You can create a link to your offer after its [activation](#activate).
1. Enter a name for your private offer in Russian and English.
1. Optionally, provide a description for your private offer in Russian and English.
1. Specify a `Subscription` [pricing plan](../concepts/tariff.md).

    {% note warning %}

    You cannot specify a pricing plan already provided in the settings of another offer that has the same validity period as your current offer.

    {% endnote %}

1. Select one or multiple subscription templates and specify the cost of a subscription set for your private offer.
1. Specify the terms:

    * **Start date**: Date when the private offer comes into effect. If the field is blank, a private offer comes into effect in 40 minutes after the user accepts it.
    * **End date**: Date when the private offer expires. After the private offer has expired, the user will switch to the subscription they selected when accepting the private offer.
    * **Accept until**: Date until which the user should accept the private offer.

       {% note info %}

       If the user does not accept the private offer until this date, you will have to create a new offer for this user to accept. You cannot accept the offer past the date specified in the **Accept until** field.

       {% endnote %}

1. Click **Save draft**.

## Activating an offer {#activate}

1. Log in to the [{{ marketplace-short-name }} partner dashboard]({{ link-cloud-partners }}).
1. Select the product for which you created the private offer.
1. Navigate to the **Private offers** tab.
1. Select the private offer with the `Draft` status.
1. Make sure you specified correct settings for your private offer. You cannot edit an active offer.
1. In the top-right corner, click **Activate**. In the window that opens, confirm the operation.

## Getting a link to an offer {#get-link}

1. Log in to the [{{ marketplace-short-name }} partner dashboard]({{ link-cloud-partners }}).
1. Select the product for which you created the private offer.
1. Navigate to the **Private offers** tab.
1. Select the private offer with the `Active` status.
1. Create a link to your private offer and send it to the user. If you specified the billing account ID in the offer settings, only the user who has the view permission for this billing account will be able to accept your offer. In any other case, any user can accept your offer by following a link.

    You can change the link to your private offer by clicking **Re-generate**. In this case, the old link will become inactive.

## Copying an offer {#copy}

You can create a new private offer for a product based on an existing offer.

1. Log in to the [{{ marketplace-short-name }} partner dashboard]({{ link-cloud-partners }}).
1. Select the product for which you want to create a new offer based on an existing one.
1. Navigate to the **Private offers** tab.
1. In the row with the private offer to copy, click ![image](../../_assets/console-icons/ellipsis.svg) → **Create copy**. You can copy an offer with any status.
1. Change the private offer's settings if you need and click **Save draft**.
