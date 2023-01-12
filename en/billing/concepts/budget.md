# Budget

A _budget_ is a way to {% if product == "yandex-cloud" %}control{% endif %}{% if product == "cloud-il" %}estimate{% endif %} resource spending in {{ yandex-cloud }}.

You use a budget to configure who will get notifications and for which threshold. You can set multiple thresholds and define different notification recipients for each one.

{% note info %}

Reaching a pre-set threshold does not affect subsequent resource utilization.

{% endnote %}


{% if product == "yandex-cloud" %}

## Budget types {#budget-type}

You can use different budget types to track the use of funds by resources or your personal account balance.


### Usage budgets {#consumption-budget}

In usage budgets, you set a spending limit for certain resources relative to a time period. When the amount of resources used exceeds the established threshold, users are notified.

There are two types of usage budgets available:
* _Usage cost_: Keeps track of the cost of resources without applying any discounts.
* _Amount payable_: Keeps track of resource costs applying discounts and active promo codes.

Budgets keep usage totals over the entire tracking period. A budget created in the middle of a month, for instance, will still keep track of all the monthly costs for the specified resources. You can set the tracking period to be a month, a quarter, or a year. As each subsequent tracking period begins, the budget will reset automatically. You can also set a custom tracking period by specifying the start and end dates. This type of budget will not reset after it ends.


### Balance budget {#balance-budget}

_The Account balance_ budget type keeps track of your personal account balance and verifies it against an established threshold. Users are notified when a personal account balance falls below the threshold value.

{% endif %}

{% if product == "cloud-il" %}

In usage budgets, you set a spending limit for certain resources relative to a time period. When the amount of resources used exceeds the established threshold, users are notified.

There are two types of usage budgets available:
* _Usage cost_: Keeps track of the cost of resources without applying any discounts.
* _Amount payable_: Keeps track of resource costs applying discounts and active promo codes.

Budgets keep usage totals over the entire tracking period. A budget created in the middle of a month, for instance, will still keep track of all the monthly costs for the specified resources. You can set the tracking period to be a month, a quarter, or a year. As each subsequent tracking period begins, the budget will reset automatically. You can also set a custom tracking period by specifying the start and end dates. This type of budget will not reset after it ends.

{% endif %}

##### See also {#see-also}

* [{#T}](../operations/budgets.md).
{% if product == "yandex-cloud" %}* [{#T}](../tutorials/serverless-trigger-budget-vm.md).{% endif %}