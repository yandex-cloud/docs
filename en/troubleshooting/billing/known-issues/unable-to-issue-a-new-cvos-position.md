# You are unable to add a Committed Volume of Services (CVoS) for Compute Cloud

## Issue description {#case-description}
When trying to create a [Committed Volume of Services](../../../billing/concepts/cvos.md) (CVoS) for Compute Cloud, you get the error message: `Couldn't purchase commitment. To reserve resources, contact Sales.`

### Diagnostics
Compute Cloud has a restriction on resource commitments available per purchase.

Per each CVoS purchase in Compute Cloud, you can currently commit to:
* vCPU: no more than 20 cores
* RAM: no more than 40 GB

## Solution {#case-resolution}

To bypass this limit, you can split your required Yandex Cloud resources into several purchases.

{% note info %}

The number of purchases is unlimited, so you can split a larger commitment into several purchases.

{% endnote %}
