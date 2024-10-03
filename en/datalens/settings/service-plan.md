---
title: "Configuring a {{ datalens-full-name }} service plan"
description: "From this article, you will learn how to configure a service plan for {{ datalens-short-name }} by choosing a plan and adding a billing account."
---

# Configuring a {{ datalens-short-name }} service plan

There are two [service plans](../pricing.md#service-plans) for {{ datalens-short-name }}: _Community_, which is free, and _Business_, for which you need to add a [billing account](../../billing/concepts/billing-account.md) for your organization.

To [see](#info) which service plan you are currently on, refer to {{ datalens-short-name }} settings. You can also [switch to another plan](#change-service-plan) or [add a billing account](#add-billing-account) from the same place.

## Viewing the service plan and billing account {#info}

To view details on your current service plan and billing account:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![sliders](../../_assets/console-icons/sliders.svg) **Service settings**. You will see the details on your current service plan and billing account at the top of the screen.

## Changing your service plan {#change-service-plan}

{% note info %}

* You can switch to the _Business_ plan at any time. The price for the first month is calculated in proportion to the remaining number of days of the month.
* You can only switch to the _Community_ plan starting the next month. Until then, you can [cancel](#cancel-change-service-plan) the scheduled switch.

{% endnote %}

To switch to a different service plan:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![sliders](../../_assets/console-icons/sliders.svg) **Service settings**.
1. At the top of the screen, click **Change plan**.
1. Select a service plan and click **Switch**. If you do not have a billing account yet, you will see the sign-up form. For more information, see [{#T}](#add-billing-account).
1. Click **Confirm**.

## Adding a billing account {#add-billing-account}

{% note info  %}

To link a billing account, the user needs to following [roles](../security/roles.md#service-roles):

* `billing.accounts.editor` or higher for a billing account.
* `{{ roles-datalens-admin }}` for an organization with {{ datalens-short-name }} or roles including the `{{ roles-datalens-admin }}` permissions, such as `{{ roles-admin }}` or `{{ roles-organization-owner }}`.

{% endnote %}

To add a billing account:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![sliders](../../_assets/console-icons/sliders.svg) **Service settings**.
1. At the top of the screen, click **Change plan**.
1. If you do not have a billing account linked to your [organization](../concepts/organizations.md), click **Add**. If you already have one, click **Change account**.
1. Select a billing account or create a new one:

   1. Click **Create account**.
   1. Specify general details:

      * **Account name**: It will be displayed in the list of your billing accounts and will help you select the right one.
      * **Country**: Select the country the [payer](../../billing/concepts/glossary.md#payer) is a resident of.
      * **Payer**: Select from the list of available payers.
      * **Account type**: Select an individual or legal entity. For a legal entity, select the payment method: `Credit/debit card` or `Wire transfer`.

      Click **Next**.

   1. Enter the payer details, depending on the type of account:

      * Individual: full name and postal address.
      * Legal entity: short name and full name of the organization, postal code, physical and legal address, TIN, and KPP.

      Click **Next**.

   1. Add a credit or debit card to your account (skip this step if the payer is a legal entity with `wire transfer` as payment method):

      * Click **Add card**.
      * Specify your card details: 16-digit number, expiration date, and CVV (you can find it on the back side of your card).
      * Click **Link**.
      * Select a card.

      If the payer is a legal entity, check the following box: **I confirm that I can use this corporate card**.

      Click **Next**.

   1. Provide contact details:

      * Enter your email address and click **Get code**. Confirm your email address.
      * Enter your phone number and click **Get code**. Confirm your phone number.

   1. Click **Create**.

1. Click **Link**.

## How to cancel switching to a different service plan {#cancel-change-service-plan}

To cancel switching to a different service plan:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![sliders](../../_assets/console-icons/sliders.svg) **Service settings**.
1. Next to the message on the scheduled date, click **Cancel**.
1. Click **Yes**. This will cancel your switching to another plan.

#### See also {#see-also}

* [Pricing questions](../qa/pricing.md)
