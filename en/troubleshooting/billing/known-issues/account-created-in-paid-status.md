# Billing account was created in the "Paid" status after registration



## Issue description {#issue-description}

* The billing account was created under paid usage after registration.

## Solution {#issue-resolution}

You cannot switch from paid usage to trial period.
**Upon first registration** in Yandex Cloud, an initial grant is always credited to the billing account.
On the **Grants** tab in the **Billing** section, you will see two parts for grant allocation:

* Part 1: ₽1,000 from the total grant amount. It can be used to pay for services of Yandex Compute Cloud, Yandex Cloud Marketplace tools, and technical support.

* Part 2: ₽3,000 from the total grant amount. It can be used to pay for the services of other Yandex Cloud services.

To learn more about the initial grant, see [here](../../../getting-started/usage-grant.md).
The grant will be prioritized over your own funds on the balance. This way, you can try out Yandex Cloud services without spending your own money.
The only difference is that you will need to keep a closer eye on cloud usage to avoid outstanding amounts. For this, get yourself familiar with the [resource billing rules](../../../billing/pricing.md).

For convenience in tracking resource usage, you can use the [Budget section](../../../billing/concepts/budget.md) in the billing account management interface.

In the Budget section, you can set up who will receive notifications and at what threshold. To learn more, [see the documentation](../../../billing/operations/budgets.md).
You can also set up several thresholds and define different notification recipients for each of them.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help resolve the issue, and if an initial grant was not credited to your account **upon first registration**, [create a request for technical support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:

1. Billing account ID.
   The billing account ID has the format: `d2nXXXXXXXXXXXXXXXXX`. You can find it on the [page with your billing account details](https://console.cloud.yandex.ru/billing/accounts).

2. Problem description.