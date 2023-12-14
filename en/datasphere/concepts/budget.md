---
title: "How to manage your computing costs in {{ ml-platform-full-name }}"
description: "In this tutorial, you will learn how to control your spending in {{ ml-platform-name }} and what consumption thresholds the service has."
---

# Cost management

You can manage your computing costs in a few ways:

1. {{ billing-name }} enables you to [set up notifications](../../billing/operations/budgets.md) about exceeding the budget set for {{ ml-platform-name }}. The budget does not affect consumption: {{ ml-platform-name }} will continue running even if the budget is exceeded.
1. In {{ ml-platform-name }}, you can [set up consumption thresholds](../operations/projects/restrictions.md) for a project. Once the consumption threshold is exceeded, all computations in the project are stopped. Project consumption thresholds are set in [billing units](../pricing.md#unit).

As consumption thresholds, you can use:

* Project balance, which is the total number of units available for the project. Each cell execution will reduce the balance by the number of units that is needed to perform one second of computations in the selected [configuration](../concepts/configurations.md). You can run cells as long as the balance is positive. If the balance drops to zero or lower during computations in one of the cells, all running computations will stop and a warning will appear, saying that the project balance is insufficient.

* Limit on the number of units per project, per hour. If the [price per hour](../pricing.md) for the selected configuration exceeds this value, the cell will not start. If the current project consumption per hour exceeds the set limit during computations in a cell, all cells with active computations will be stopped.

* Limit on the number of units available per computation. If a cell exceeds the set limit during computations, it will be stopped.

You will need the following roles to manage costs:

* `{{ roles-datasphere-project-editor }}` to view project limits.
* `{{ roles-datasphere-project-admin }}` to set project limits.

You can learn more about {{ ml-platform-name }} roles and access management in [{#T}](../security/index.md).
