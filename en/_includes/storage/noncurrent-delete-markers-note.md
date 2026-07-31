{% note warning %}

Non-current delete markers (`NoncurrentDeleteMarkers`) are an extension of {{ objstorage-name }} and are supported only by the [{{ yandex-cloud }} CLI](../../storage/operations/buckets/lifecycles.md#cli_1), [{{ yandex-cloud }} REST](../../storage/api-ref/Bucket/update.md#yandex.cloud.storage.v1.LifecycleRule.NoncurrentDeleteMarkers), and [{{ yandex-cloud }} gRPC](../../storage/api-ref/grpc/Bucket/update.md#yandex.cloud.storage.v1.LifecycleRule.NoncurrentDeleteMarkers). When using third-party tools, such as the AWS CLI, you may encounter errors when viewing or editing the lifecycle configuration.

{% endnote %}