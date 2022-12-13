---
sourcePath: en/_api-ref-grpc/logging/api-ref/grpc/index.md
---
# Cloud Logging Service: gRPC reference
This API reference is organized by resource. Actions are performed by sending HTTP requests to resource URLs or making RPC calls. For more information about API architecture, see [API Concepts](/docs/api-design-guide/).

See the interface definitions of Yandex.Cloud API on [GitHub](https://github.com/yandex-cloud/cloudapi).

Service | Description
--- | ---
[LogGroupService](./log_group_service.md) | A set of methods for managing log groups.
[LogIngestionService](./log_ingestion_service.md) | A set of methods for writing to log groups. To make a request use `ingester.logging.yandexcloud.net`.
[LogReadingService](./log_reading_service.md) | A set of methods for reading from log groups. To make a request use `reader.logging.yandexcloud.net`.
[OperationService](./operation_service.md) | A set of methods for managing operations for asynchronous API requests.
