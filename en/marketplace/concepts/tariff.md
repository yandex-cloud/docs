---
title: "Service plans in {{ marketplace-full-name }}"
---

# Service plan

A _service plan_ is the cost of using a software product for {{ marketplace-short-name }} users. A service plan must include:
* Product asking price, which is the amount the publisher would like to receive for his or her product, without VAT.
* Fee in the amount of 20% of the product asking price that is charged by {{ yandex-cloud }}.
* VAT.

If payment is at the end of a billing cycle, {{ yandex-cloud }} will deduct the fee and VAT from the rate if your legal entity does not pay VAT.

Different service plans are available for different types of products.

{% include [types](../../_includes/marketplace/types-of-charge.md) %}

The table below demonstrates compatibility between different product types and service plans.

|   | Free | BYOL | PAYG (core per hour, instance per hour, RAM per hour) | PAYG (other pricing system) | Subscription |
|-----|-----|-----|-----|-----|-----|
| {{ compute-name }} | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| {{ managed-k8s-name }} | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| {{ cloud-apps-name }} | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| SaaS | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |