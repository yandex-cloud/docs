# Setting up consumption limits for a project

{% include [link-on-new-ui-datasphere-in-old-ui](../../../_includes/datasphere/datasphere-old-note.md) %}

{{ ml-platform-name }} allows you to set consumption limits for individual projects. For more information about the types of limits, see [{#T}](../../concepts/budget.md).

{% include [datasphere-api-auth](../../../_includes/datasphere/datasphere-api-auth.md) %}

## Setting up a project balance {#project-balance}

{% list tabs %}

- API

   Project balance management is carried out using the [GetUniteBalance](../../api-ref/grpc/project_service#GetUnitBalance) and [SetUniteBalance](../../api-ref/grpc/project_service#SetUnitBalance) API methods.

   Getting a project's balance:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM token>" \
           -d '{"project_id": "<project_id>"}' \
           {{ ds-api-addr }} \
           yandex.cloud.datasphere.v1.ProjectService/GetUnitBalance
   ```

   Setting a project's balance:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM token>" \
           -d '{"project_id": "<project_id>", "unit_balance": 60}' \
           {{ ds-api-addr }} \
           yandex.cloud.datasphere.v1.ProjectService/SetUnitBalance
   ```

{% endlist %}

## Setting limits on the number of units {#limits}

{% list tabs %}

- API

   To set limits for a project, use the [Limits](../../api-ref/grpc/project_service#Limits) field of the ProjectService group API methods.

   Setting a limit on the size of computations per hour:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM token>" \
           -d '{"project_id": "<project_id>", "limits": {"max_units_per_hour": 210}}' \
           {{ ds-api-addr }} \
           yandex.cloud.datasphere.v1.ProjectService/Update
   ```

   Removing the set limits:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM token>" \
           -d '{"project_id": "<project_id>", "limits": {}}' \
           {{ ds-api-addr }} \
           yandex.cloud.datasphere.v1.ProjectService/Update
   ```

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/budget.md)
* [{#T}](set-ds-budget.md)