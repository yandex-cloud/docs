---
title: "Pricing policy for {{ tracker-full-name }}"
description: "The cost of using {{ tracker-name }} is based on the number of users with full access to the service. You don't have to pay anything for {{ tracker-name }} if you only have a small team since {{ tracker-name }} is free of charge for up to five employees."
---

# Pricing for {{ tracker-full-name }}

{% note tip %}

You don't have to pay anything for {{ tracker-name }} if you only have a small team since {{ tracker-name }} is free of charge for up to five employees.

{% endnote %}

By default, all company employees can use {{ tracker-full-name }} for free in [<q>Read only</q>](access.md#readonly) mode. Grant [full access](access.md) to {{ tracker-name }} so that your employees can use all of its features.

The cost of using {{ tracker-name }} is based on the number of users with [full access to the service](access.md). The monthly fee [is debited from the billing account](pay-the-bill.md#charge) linked to {{ tracker-name }}.

You can find the FAQ for payments in [{#T}](payment.md).

## Pricing {#sec_price}




{% include [usd-after-30June.md](../_pricing/tracker/usd-after-30June.md) %}

{% include [usd.md](../_pricing/tracker/usd.md) %}


{% note info %}

If you want to provide access to {{ tracker-name }} for more than 500 users, [contact us]({{ link-500-users }}) to discuss individual business terms.

{% endnote %}

To check your billing account balance or view your payment history, click ![](../_assets/tracker/tracker-burger.png) → **Billing** on the top panel in {{ tracker-name }}.

## Cost calculation {#sec_calculate}

How the monthly {{ tracker-name }} subscription fee is calculated:

* {% include [first-month-tarification.md](../_includes/tracker/first-month-tarification.md) %}

* The monthly fee is based on the maximum number of users who simultaneously had access to {{ tracker-name }} during the month.

   {% note tip %}

   If you want to add new users to {{ tracker-name }} while simultaneously revoking access to {{ tracker-name }} for other users, we recommend revoking access for old users first and then adding new users. This will give you the lowest number of users with simultaneous access to {{ tracker-name }}.

   {% endnote %}

* For large companies, the monthly fee is calculated on a progressive scale.

> For example, the following pricing was in effect in July:
>
> * For the first 100 users: $3.520000 per user per month.
>
> * For the next 150 users: $3.200000 per user per month.
>
> * For all users over 250: $2.880000 per user per month.
>
> In July, the number of employees with full access to {{ tracker-name }} varied as follows:
>
> * There were 245 employees for 14 days.
>
> * There were 270 employees for 7 days.
>
> * There were 260 employees for 10 days.
>
> During the month, the maximum number of users with access to {{ tracker-name }} at the same time was 270.
>
> The following formula will be used to calculate the subscription fee for 270 users:
>
> 
>
> 
>
> >
> ```
> 100 × $3.520000 + 150 × $3.200000 + 20 × $2.880000
> ```
>
> 