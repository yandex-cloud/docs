# Управление потреблением проектов

Существует несколько способов контролировать расходы на вычисления. В биллинге вы можете [настроить уведомления](../../../billing/operations/budgets.md) о превышении установленного бюджета для сервиса {{ ml-platform-name }}. Бюджет не влияет на потребление: {{ ml-platform-name }} продолжит работу, даже если бюджет будет превышен. 

Также вы можете настроить пороги потребления для проекта в {{ ml-platform-name }}. После превышения порога потребления все вычисления в проекте останавливаются. Пороги потребления для проекта задаются в [тарифицирующих юнитах](../../pricing.md#unit).

Вы можете задать:

* Баланс проекта `unit_balance` — общее количество юнитов, доступных для проекта. Каждое исполнение ячейки будет уменьшать баланс проекта на то количество юнитов, которое необходимо для выполнения одной секунды вычислений выбранной [конфигурации](../../concepts/configurations.md). Ячейки можно запустить до тех пор, пока баланс проекта положительный. Если во время вычислений в одной из ячеек баланс проекта станет меньше или равен нулю, все запущенные вычисления будут остановлены с предупреждением, что баланса проекта недостаточно.
   
* Ограничение на количество юнитов в час `max_units_per_hour`, которое может использовать проект. Если [цена за час](../../pricing.md) для выбранной конфигурации при запуске вычислений превышает `max_units_per_hour`, ячейка не запустится. Если в процессе вычислений в ячейке текущее потребление проекта за час превысит `max_units_per_hour`, все ячейки с вычислениями будут остановлены.

* Ограничение на количество юнитов `max_units_per_execution`, доступных для одного вычисления. Если в процессе вычислений ячейка превысит установленное ограничение `max_units_per_execution`, она будет остановлена.

Ограничения независимы и могут быть назначены проекту одновременно.  

Чтобы посмотреть ограничения проекта, необходима роль `{{ roles-datasphere-user }}`. Для установки ограничений проекта понадобится роль `{{ roles-datasphere-admin }}`. Подробнее о ролях и управлении доступом в {{ ml-platform-name }} читайте в разделе [{#T}](../../security/index.md).

## Установить баланс проекта

Для управления балансом проекта используйте методы API [GetUniteBalance](../../api-ref/grpc/project_service#GetUnitBalance) и [SetUniteBalance](../../api-ref/grpc/project_service#SetUnitBalance).

### Примеры запросов {#examples-balance}

{% include [datasphere-api-auth](../../../_includes/datasphere/datasphere-api-auth.md) %}

Получить баланс проекта:

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM-token>" \
        -d '{"project_id": "<project_id>"}' \
        {{ ds-api-addr }} \
        yandex.cloud.datasphere.v1.ProjectService/GetUnitBalance
```

Установить баланс проекта: 

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM-token>" \
        -d '{"project_id": "<project_id>", "unit_balance":60}' \
        {{ ds-api-addr }} \
        yandex.cloud.datasphere.v1.ProjectService/SetUnitBalance
```

## Установить ограничения на количество юнитов {#limits}

Для настройки ограничений проекта используйте поле [Limits](../../api-ref/grpc/project_service#Limits) методов API группы ProjectService. 

### Примеры запросов {#examples-limits}

Установить ограничение на размер вычислений в час:

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM-token>" \
        -d '{"project_id": "<project_id>", "limits": {"max_units_per_hour": "210"}}' \
        {{ ds-api-addr }} \
        yandex.cloud.datasphere.v1.ProjectService/Update 
```

Удалить установленные ограничения:

```bash
grpcurl -rpc-header Authorization: Bearer <IAM-token>" \
        -d '{"project_id": "<project_id>", "limits": {}}' \
        {{ ds-api-addr }} \
        yandex.cloud.datasphere.v1.ProjectService/Update 
```