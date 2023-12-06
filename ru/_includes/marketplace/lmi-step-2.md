Периодическая проверка того, что подписка активна.

Получить актуальную информацию о подписке можно с помощью метода REST API [list](../../marketplace/license-manager/api-ref/Instance/list.md) для ресурса [Instance](../../marketplace/license-manager/api-ref/Instance/index.md) или вызова gRPC API [InstanceService/List](../../marketplace/license-manager/api-ref/grpc/instance_service.md#List).

{% note info %}

Учитывайте, что пользователь может отвязать один ресурс от подписки и привязать к ней другой. Ваш код должен корректно обрабатывать такие случаи.

{% endnote %}