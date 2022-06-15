# Настроить ограничения вычислений для каталога 

{{ ml-platform-name }} позволяет задавать ограничения на потребление проектов в каталоге. Подробнее о типах ограничений см. [{#T}](../../concepts/budget.md).

{% include [datasphere-api-auth](../../../_includes/datasphere/datasphere-api-auth.md) %}

{% list tabs %}

- API

  Для управления ограничениями для всех проектов каталога используйте методы API [Get](../../api-ref/grpc/folder_budget_service#Get) и [Set](../../api-ref/grpc/folder_budget_service#Set).

  Посмотреть ограничения каталога:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \ 
      -d '{"folder_id": "<folder_id>"}' \ 
      datasphere.{{ api-host }}:443 \ 
      yandex.cloud.datasphere.v1.FolderBudgetService/Get
  ```

  Задать ограничения для каталога:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \ 
      -d '{"folder_id": "<folder_id>", "set_mask": {"paths": ["unit_balance"]}, "unit_balance":10}' \ 
      datasphere.{{ api-host }}:443 \ 
      yandex.cloud.datasphere.v1.FolderBudgetService/Set
  ```

  Удалить ограничения каталога:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \ 
      -d '{"folder_id": "<folder_id>", "set_mask": {"paths": ["unit_balance"]}}' \ 
      datasphere.{{ api-host }}:443 \ 
      yandex.cloud.datasphere.v1.FolderBudgetService/Set
  ```

  Удалить все ограничения каталога:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \ 
      -d '{"folder_id": "<folder_id>"}' \ 
      datasphere.{{ api-host }}:443 \ 
      yandex.cloud.datasphere.v1.FolderBudgetService/Set
  ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/budget.md)
* [{#T}](custom-limits.md)