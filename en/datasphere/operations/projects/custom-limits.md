# Project consumption management

There are several ways to control computing costs. Billing lets you [set up notifications](../../../billing/operations/budgets.md) about exceeding the budget set for {{ ml-platform-name }}. The budget does not affect consumption: {{ ml-platform-name }} will continue running even if the budget is exceeded.

You can also set up project consumption thresholds in {{ ml-platform-name }}. Once the consumption threshold is exceeded, all computations in the project are stopped. Project consumption thresholds are set in [billing units](../../pricing.md#unit).

You can set the following:

* Project balance (`unit_balance`): the total number of units available for the project. Each execution of a cell will reduce the project balance by the number of units that is needed to perform computations of the selected [configuration](../../concepts/configurations.md) per second. You can run cells as long as the project balance is positive. If the project balance drops below or equals zero during computations in one of the cells, all running computations are stopped and a warning saying that the project balance is insufficient is shown.

* Limit on the number of units per project per hour (`max_units_per_hour`). If the [cost per hour](../../pricing.md) for the selected configuration exceeds the `max_units_per_hour` when running computations, a cell won't start. If the current  project consumption per hour exceeds the `max_units_per_hour` during computations in a cell, all cells with active computations are stopped.

* Limit on the number of units available per computation (`max_units_per_execution`). If during computations a cell exceeds the set `max_units_per_execution` limit, it is stopped.

The limits are independent and can be assigned to a project simultaneously.

To view a project's limits, you need the `{{ roles-datasphere-user }}` role. To set a project's limits, you need the `{{ roles-datasphere-admin }}` role. For more information about roles and access management in {{ ml-platform-name }}, see [{#T}](../../security/index.md).

## Setting a project's balance

Project balance management is carried out using the [GetUniteBalance](../../api-ref/grpc/project_service#GetUnitBalance) and [SetUniteBalance](../../api-ref/grpc/project_service#SetUnitBalance) API methods.

### Request examples {#examples-balance}

{% include [datasphere-api-auth](../../../_includes/datasphere/datasphere-api-auth.md) %}

Getting a project's balance:

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM-token>" \
        -d '{"project_id": "<project_id>"}' \
        {{ ds-api-addr }} \
        yandex.cloud.datasphere.v1.ProjectService/GetUnitBalance
```

Setting a project's balance:

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM-token>" \
        -d '{"project_id": "<project_id>", "unit_balance":60}' \
        {{ ds-api-addr }} \
        yandex.cloud.datasphere.v1.ProjectService/SetUnitBalance
```

## Setting limits on the number of units {#limits}

To set limits for a project, use the [Limits](../../api-ref/grpc/project_service#Limits) field of the ProjectService group API methods.

### Request examples {#examples-limits}

Setting a limit on the size of computations per hour:

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM-token>" \
        -d '{"project_id": "<project_id>", "limits": {"max_units_per_hour": "210"}}' \
        {{ ds-api-addr }} \
        yandex.cloud.datasphere.v1.ProjectService/Update 
```

Removing the set limits:

```bash
grpcurl -rpc-header Authorization: Bearer <IAM-token>" \
        -d '{"project_id": "<project_id>", "limits": {}}' \
        {{ ds-api-addr }} \
        yandex.cloud.datasphere.v1.ProjectService/Update 
```