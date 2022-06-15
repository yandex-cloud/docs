# Setting up consumption limits for a folder

{{ ml-platform-name }} allows you to set consumption limits for projects in your folder. For more information about the types of limits, see [{#T}](../../concepts/budget.md).

{% include [datasphere-api-auth](../../../_includes/datasphere/datasphere-api-auth.md) %}

{% list tabs %}

- API

   To manage limits for all folder projects, use the [Get](../../api-ref/grpc/folder_budget_service#Get) and [Set](../../api-ref/grpc/folder_budget_service#Set) API methods.

   View folder limits:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM token>" \
       -d '{"folder_id": "<folder_id>"}' \
       datasphere.{{ api-host }}:443 \
       yandex.cloud.datasphere.v1.FolderBudgetService/Get
   ```

   Set limits for the folder:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM token>" \
       -d '{"folder_id": "<folder_id>", "set_mask": {"paths": ["unit_balance"]}, "unit_balance":10}' \
       datasphere.{{ api-host }}:443 \
       yandex.cloud.datasphere.v1.FolderBudgetService/Set
   ```

   Delete folder limits:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM token>" \
       -d '{"folder_id": "<folder_id>", "set_mask": {"paths": ["unit_balance"]}}' \
       datasphere.{{ api-host }}:443 \
       yandex.cloud.datasphere.v1.FolderBudgetService/Set
   ```

   Delete all limits for the folder:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM token>" \
       -d '{"folder_id": "<folder_id>"}' \
       datasphere.{{ api-host }}:443 \
       yandex.cloud.datasphere.v1.FolderBudgetService/Set
   ```

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/budget.md)
* [{#T}](custom-limits.md)