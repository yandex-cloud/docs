# Cost management

There are several ways to control computing costs:

1. {{ billing-name }} enables you to [set up notifications](../../billing/operations/budgets.md) about exceeding the budget set for {{ ml-platform-name }}. The budget does not affect consumption: {{ ml-platform-name }} will continue running even if the budget is exceeded.
1. In {{ ml-platform-name }}, you can [set up consumption thresholds](../operations/projects/restrictions.md) for a project. Once the consumption threshold is exceeded, all computations in the project are stopped. Project consumption thresholds are set in [billing units](../pricing.md#unit).

As consumption thresholds, you can use:

* Project balance: The total number of units available for the project. Each execution of a cell will reduce the balance by the number of units that is needed to perform one second of computations in the selected [configuration](../concepts/configurations.md). You can run cells as long as the balance is positive. If the balance drops to zero or lower during computations in one of the cells, all running computations will stop and a warning will appear, saying that the project balance is insufficient.

* Limit on the number of units per project per hour. If the [price per hour](../pricing.md) for the selected configuration exceeds this value, a cell won't start. If the current project consumption per hour exceeds the set limit during computations in a cell, all cells with active computations are stopped.

* Limit on the number of units available per computation. If a cell exceeds the set limit during computations, it is stopped.

You'll need the following roles to manage costs:

* View project limits: the `{{ roles-datasphere-project-editor }}` role.
* Set project limits: the `{{ roles-datasphere-project-admin }}` role.

Learn more about {{ ml-platform-name }} roles and access controls in [{#T}](../security/index.md).
