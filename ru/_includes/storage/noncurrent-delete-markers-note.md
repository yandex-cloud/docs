{% note warning %}

Неактивные маркеры удаления `NoncurrentDeleteMarkers` являются расширением {{ objstorage-name }} и поддерживаются только инструментами [{{ yandex-cloud }} CLI](../../storage/operations/buckets/lifecycles.md#cli), [{{ yandex-cloud }} REST](../../storage/api-ref/Bucket/update.md#yandex.cloud.storage.v1.LifecycleRule.NoncurrentDeleteMarkers) и [{{ yandex-cloud }} gRPC](../../storage/api-ref/grpc/Bucket/update.md#yandex.cloud.storage.v1.LifecycleRule.NoncurrentDeleteMarkers). При использовании сторонних инструментов, например AWS CLI, могут возникать ошибки во время просмотра или редактирования конфигурации жизненных циклов.

{% endnote %}