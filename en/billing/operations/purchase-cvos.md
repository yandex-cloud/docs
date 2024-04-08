---
title: "How to purchase a committed volume of services (CVoS)"
description: "Follow this guide to purchase a committed volume of services (CVoS)."
---

# Purchasing a committed volume of services (CVoS)

{% include [cvos-term](../_includes/cvos-term.md) %}

## Purchasing a committed volume of services (CVoS) {#enable}

{% list tabs group=instructions %}

- {{ billing-name }} interface {#billing}

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
   1. Make sure your billing account consumption type is `{{ ui-key.yacloud.billing.account.overview.usage-type_label_paid }}`. For more information about activating the paid version, see [{#T}](activate-commercial.md).
   1. Make sure the user managing the billing account has the `billing.accounts.owner`, `editor`, or `admin` role. For more information about roles, see [{#T}](../security/index.md).
   1. In the left-hand panel, select ![image](../../_assets/console-icons/sack.svg) **{{ ui-key.yacloud.billing.account.switch_offers }}**.
   1. Review the offers:
      1. Select a service and click the section with the new offer.
      1. Choose a platform.
      1. Use the service cost calculator: set the amount of resources and compare the cost when committing to 6 months and 1 year. Select the appropriate option.
   1. Check the terms of the selected agreement.
   1. Read the agreement. If you agree to the terms, check **By clicking _Purchase commitment_, I have read and accept the Terms**.
   1. Click **{{ ui-key.yacloud.billing.cud.purchase.button_purchase }}**.

{% endlist %}

After purchasing the CVoS and starting from its start date, the discount on the use of services is applied automatically. For more information, see [{#T}](../concepts/cvos.md).
