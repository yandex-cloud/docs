# Pricing policy

All employees can use {{ tracker-name }} for free in [<q>Read only</q>](enable-tracker.md#readonly) mode. Grant them [full access](enable-tracker.md#access) to {{ tracker-name }} so that your employees can use all of its features.

{% note tip %}

If you activate {{ tracker-full-name }} before {{ promo-end-date }}, 2021, you get free access to all {{ tracker-name }} features for one month.

{% endnote %}

## Pricing {#sec_price}

The cost of using {{ tracker-name }} is based on the number of users with full access to the platform. You don't have to pay for {{ tracker-name }} if you have a small team. You can subscribe up to 5 employees to {{ tracker-name }} for free.

For large companies, the cost of using {{ tracker-name }} is [calculated on a progressive scale](#sec_calculate). For the first 100 users, full access to {{ tracker-name }} costs ₽258 per month. If 100 employees are already subscribed to {{ tracker-name }}, the subscription fee for the next 150 users will be lower: ₽222 per month. If more than 250 employees are subscribed, the monthly fee for new users is ₽185.

| Number of subscribed users | Price per new user per month * |
| ----- | ----- |
| up to 5 | 0 ₽ |
| 6–100 | 258 ₽ |
| 101–250 | 222 ₽ |
| 250+ | 185 ₽ |

\* Includes VAT. Reduced rates may apply when using promo codes.

{% note info %}

If you want to provide access to {{ tracker-name }} for more than 500 users, [contact us]({{ link-console-support }}) to discuss individual business terms.

{% endnote %}

## {{ tracker-name }} cost calculation {#sec_calculate}

How the monthly {{ tracker-name }} subscription fee is calculated:

- The monthly fee is based on the maximum number of users who simultaneously had access to {{ tracker-name }} during the month.

    {% note tip %}

    If you want to add new users to {{ tracker-name }} while simultaneously revoking access for those who no longer use {{ tracker-name }}, we recommend revoking access for old users first and then adding new users. This will give you the lowest number of users with simultaneous access to {{ tracker-name }}.

    {% endnote %}

<!-- - If you accidentally granted access to {{ tracker-name }} to a user or team that won't use {{ tracker-name }}, you can revoke their access within 30 minutes. In this case, the users in question will not be considered when calculating the monthly subscription fee.
-->
- For large companies, the monthly fee is calculated on a progressive scale:

    - The subscription fee for the first 100 users is ₽258.

    - The subscription fee for next 150 users is ₽222.

    - After 250 users the fee is ₽185.

> For example, let's say the number of employees who had full access to {{ tracker-name }} in January changed like this:
>
>- 245 employees had full Tacker access for 14 days.
>
>- The next 7 days saw 270 employees with access to Tracker.
>
>- Finally, during the last 10 days there were 260 employees with access to Tracker.
>
>During the month, the maximum number of users with access to {{ tracker-name }} at the same time was 270.
>
>This means that the following formula will be used to calculate the subscription fee for 270 users:
>
>```
>100 × 258 ₽ + 150 × 222 ₽ + 20 × 185 ₽ =  62800 ₽
>```

[Contact support](troubleshooting.md)

