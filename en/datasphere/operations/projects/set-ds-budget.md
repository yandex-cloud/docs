# Setting up consumption limits for a folder

{{ ml-platform-name }} allows you to set consumption limits for projects in your folder. For more information about the types of limits, see [{#T}](../../concepts/budget.md).

{% include [datasphere-api-auth](../../../_includes/datasphere/datasphere-api-auth.md) %}

{% list tabs %}

- API

  To manage limits for all projects in your folder, use the API methods [Get](../../api-ref/grpc/folder_budget_service#Get) and [Set](../../api-ref/grpc/folder_budget_service#Set).

  Viewing limits for the folder:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM token>" \ 
      -d '{"folder_id": "<folder_id>"}' \ 
      datasphere.api.cloud.yandex.net:443 \ 
      yandex.cloud.datasphere.v1.FolderBudgetService/Get
  ```

  Setting limits for the folder:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM token>" \ 
      -d '{"folder_id": "<folder_id>", "set_mask": {"paths": ["unit_balance"]}, "unit_balance":10}' \ 
      datasphere.api.cloud.yandex.net:443 \ 
      yandex.cloud.datasphere.v1.FolderBudgetService/Set
  ```

  Deleting limits for the folder:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM token>" \ 
      -d '{"folder_id": "<folder_id>", "set_mask": {"paths": ["unit_balance"]}}' \ 
      datasphere.api.cloud.yandex.net:443 \ 
      yandex.cloud.datasphere.v1.FolderBudgetService/Set
  ```

  Deleting all limits for the folder:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM token>" \ 
      -d '{"folder_id": "<folder_id>"}' \ 
      datasphere.api.cloud.yandex.net:443 \ 
      yandex.cloud.datasphere.v1.FolderBudgetService/Set
  ```

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/budget.md)
* [{#T}](custom-limits.md)