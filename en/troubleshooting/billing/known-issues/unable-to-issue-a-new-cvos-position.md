# You are unable to purchase a committed volume of services for {{ compute-short-name }}



## Issue description {#case-description}

When trying to purchase a [committed volume of services (CVoS)](../../../billing/concepts/cvos.md) for {{ compute-short-name }}, you get this error message: 
```
Could not purchase CVoS. To purchase a CVoS, contact Sales.
```

## Solution {#case-resolution}

{{ compute-short-name }} has a limit on resource commitments available per purchase.

A single {{ compute-short-name }} commitment may include:

* vCPU: Up to 20 cores
* RAM: Up to 40 GB

To bypass this limit, you can split {{ yandex-cloud }} resources you need into several purchases.

{% note info %}

The number of purchases is unlimited, so you can split a larger commitment into any number of small purchases you are comfortable with.

{% endnote %}
