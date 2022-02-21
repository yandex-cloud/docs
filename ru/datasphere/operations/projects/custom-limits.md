# Настроить ограничения вычислений для проекта

{{ ml-platform-name }} позволяет задавать ограничения на потребление отдельных проектов. Подробнее о типах ограничений см. [{#T}](../../concepts/budget.md).

{% include [datasphere-api-auth](../../../_includes/datasphere/datasphere-api-auth.md) %}

## Настроить баланс проекта {#project-balance}

{% list tabs %}

- API

  Для управления балансом проекта используйте методы API [GetUniteBalance](../../api-ref/grpc/project_service#GetUnitBalance) и [SetUniteBalance](../../api-ref/grpc/project_service#SetUnitBalance).

  Получить баланс проекта:
  
  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
          -d '{"project_id": "<project_id>"}' \
          {{ ds-api-addr }} \
          yandex.cloud.datasphere.v1.ProjectService/GetUnitBalance
  ```
  
  Установить баланс проекта:
  
  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
          -d '{"project_id": "<project_id>", "unit_balance": 60}' \
          {{ ds-api-addr }} \
          yandex.cloud.datasphere.v1.ProjectService/SetUnitBalance
  ```

{% endlist %}

## Установить ограничения на количество юнитов {#limits}

{% list tabs %}

- API

  Для настройки ограничений проекта используйте поле [Limits](../../api-ref/grpc/project_service#Limits) методов API группы ProjectService.

  Установить ограничение на размер вычислений в час:
  
  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
          -d '{"project_id": "<project_id>", "limits": {"max_units_per_hour": 210}}' \
          {{ ds-api-addr }} \
          yandex.cloud.datasphere.v1.ProjectService/Update 
  ```
  
  Удалить установленные ограничения:
  
  ```bash
  grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
          -d '{"project_id": "<project_id>", "limits": {}}' \
          {{ ds-api-addr }} \
          yandex.cloud.datasphere.v1.ProjectService/Update 
  ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/budget.md)
* [{#T}](set-ds-budget.md)