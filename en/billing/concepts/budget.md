# Budget

A _budget_ is a way to control resource spending in {{ yandex-cloud }}.

You use a budget to configure who will get notifications and for which threshold. You can set multiple thresholds and define different notification recipients for each one.

{% note info %}

Reaching a pre-set threshold does not affect subsequent resource utilization.

{% endnote %}



## Budget types {#budget-type}

You can use different budget types to track the use of funds by resources or your personal account balance.


### Usage budgets {#consumption-budget}

In usage budgets, you set a spending limit for given resources over the calculation period. Users get notified as soon as consumption exceeds the specified threshold.

The following types of usage budgets are available:
* _{{ ui-key.yacloud.billing.account.budgets.label_type-cost }}_: Keeps track of the cost of resources without applying any discounts.
* _{{ ui-key.yacloud.billing.account.budgets.label_type-expense }}_: Keeps track of the cost of resources with discounts and active promo codes applied. This type is set by default when creating a billing account.

Budgets keep usage totals over the entire tracking period. A budget created in the middle of a month, for instance, will still keep track of all the monthly costs for the specified resources. You can set the tracking period to be a month, a quarter, or a year. As each subsequent tracking period begins, the budget will reset automatically. You can also set a custom tracking period by specifying the start and end dates. This type of budget will not reset after it ends.


### Balance budget {#balance-budget}

The _{{ ui-key.yacloud.billing.account.budgets.label_type-balance }}_ budget type keeps track of your personal account balance and checks it against a specified threshold. Users get notified when a personal account balance falls below the threshold value.



##### See also {#see-also}

* [{#T}](../operations/budgets.md).
* [{#T}](../tutorials/serverless-trigger-budget-vm.md).