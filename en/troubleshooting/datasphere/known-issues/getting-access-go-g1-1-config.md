# Getting access to the GPU g1.1 and higher configurations in DataSphere



## Issue description {#issue-description}

When attempting to use the GPU g1.1 or higher configurations in DataSphere, you see this error message:

* `Access Denied: Spec g1.1 is not available for your cloud. Please contact your administrator or Support`

## Solution {#issue-resolution}

Access to the g1.1 configuration for DataSphere is available after switching to a paid plan and topping up your account with an amount of 500 rubles or more. We mention this in the [Limits section of the DataSphere documentation](../../../datasphere/concepts/limits.md).
GPUs are highly demanded resources. We want all users to be able to fully test their scenarios in Yandex Cloud, so we ask you to top up the balance.

Please note that after switching to paid usage, active grants will be used to pay for resources in the first place. We will only start debiting your account after the grant is used up or has expired. To learn more about this, see the [Billing cycle section in the Yandex Cloud Billing documentation](../../../billing/payment/billing-cycle-individual.md).

To use the g1.1 platform, top up the balance of your account with the required amount, then do the following:

1. Stop computations and exit the project using **File** → **Stop IDE executions**.
2. Log in to the project again from the Yandex Cloud console.

The rules for charging for resources within projects are provided in the [relevant section of the DataSphere documentation](../../../datasphere/pricing.md).

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:

1. DataSphere community ID
2. Desired GPU configuration type that you need access to
3. Detailed scenario of using the GPU configuration in your DataSphere project.
