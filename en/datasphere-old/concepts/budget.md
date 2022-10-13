{% if product == "yandex-cloud" %}

# Cost management

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

There are several ways to control computing costs.

1. Billing enables you to [set up notifications](../../billing/operations/budgets.md) about exceeding the budget set for {{ ml-platform-name }}. The budget does not affect consumption: {{ ml-platform-name }} will continue running even if the budget is exceeded.
1. You can set up consumption thresholds for a folder or project in {{ ml-platform-name }}. Once the consumption threshold is exceeded, all computations in the given project or all projects in the folder stop. Consumption thresholds for a project or folder are set in [billing units](../pricing.md#unit).

{% endif %}

{% if product == "cloud-il" %}

# The limit on resources used

You can set up consumption thresholds for a folder or project in {{ ml-platform-name }}. Once the consumption threshold is exceeded, all computations in the given project or all projects in the folder stop. Consumption thresholds for a project or folder are set in billing units.

{% endif %}

As consumption thresholds, you can use:

* Balance (`unit_balance`): The total number of units available for the project or folder. Each execution of a cell will reduce the balance by the number of units that is needed to perform one second of computations in the selected [configuration](../concepts/configurations.md). You can run cells as long as the balance is positive. If the balance drops below or equals zero during computations in one of the cells, all running computations are stopped and a warning saying that the project balance is insufficient is shown.

* Limit on the number of units per project per hour: `max_units_per_hour`. If the [price per hour](../pricing.md) for the selected configuration exceeds `max_units_per_hour`, the cell won't start. If the current  project consumption per hour exceeds the `max_units_per_hour` during computations in a cell, all cells with active computations are stopped.

* Limit on the number of units available per computation: `max_units_per_execution`. If during computations a cell exceeds the set `max_units_per_execution` limit, it is stopped.

The limits are independent and can be assigned to a project or folder simultaneously.

You'll need the following roles to manage costs:
* View project limits: the `{{ roles-datasphere-user }}` role.
* Set project limits: the `{{ roles-datasphere-admin }}` role.
* View folder limits: the `{{ roles-viewer }}` role.
* Set folder limits: the `{{ roles-admin }}` cloud administrator role.

Learn more about {{ ml-platform-name }} roles and access controls in [{#T}](../security/index.md).

#### See also {#see-also}

* [{#T}](../operations/projects/custom-limits.md)
* [{#T}](../operations/projects/set-ds-budget.md)
