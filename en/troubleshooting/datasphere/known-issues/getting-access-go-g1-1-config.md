# Getting access to GPU g1.1 and higher configurations in {{ ml-platform-name }}



## Case description {#issue-description}

When attempting to use GPU g1.1 or higher configurations in {{ ml-platform-name }}, you get this error message:

```
Access Denied: Spec g1.1 is not available for your cloud. Please contact your administrator or Support
```

## Solution {#issue-resolution}

Access to the g1.1 configuration for {{ ml-platform-name }} becomes available after switching to paid usage and topping up your account balance with at least ₽500. To learn more, see [**Limits**](../../../datasphere/concepts/limits.md) in the {{ ml-platform-name }} section.

GPU is a high-demand resource, and we want all our users to fully test their use cases in {{ yandex-cloud }}; this is why you have to make a deposit to use it.

{% note info %}

After switching to paid usage, any active grants will be applied first towards payment for resources. We will only start debiting your account after your grant is used up or has expired. To learn more, see [**Billing cycle**](../../../billing/payment/billing-cycle-individual.md) in the {{ billing-name }} section.

{% endnote %}

To use the g1.1 platform, top up the balance of your account with the required amount, and then do the following:

1. Stop computations and exit the project through **File** → **Stop IDE executions**.
1. Log in to the project again using the [management console]({{ link-console-main }}).

To learn how resources are charged within projects, see [{{ ml-platform-name }} pricing policy](../../../datasphere/pricing.md).

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. {{ ml-platform-name }} community ID.
1. Type of GPU configuration you need to get access to.
1. How you prefer to use this GPU configuration in your {{ ml-platform-name }} project.