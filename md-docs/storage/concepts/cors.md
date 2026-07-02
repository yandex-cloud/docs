[Документация Yandex Cloud](../../index.md) > [Yandex Object Storage](../index.md) > [Концепции](index.md) > CORS

# CORS в Object Storage

Yandex Object Storage поддерживает [кросс-доменные запросы](../../glossary/cors.md) к объектам в бакете.

Для управления конфигурацией CORS для каждого бакета можно применять:

- [Консоль управления](../operations/buckets/cors.md) Yandex Cloud.
- [HTTP API, совместимый с Amazon S3](../s3/index.md).

    Таким образом, конфигурацией CORS можно управлять при помощи [инструментов](../tools/index.md), поддерживающих  HTTP API Amazon S3.

При управлении конфигурацией CORS с помощью HTTP API, совместимого с Amazon S3, задайте [ее в формате XML](../s3/api-ref/cors/xml-config.md). Различные инструменты могут требовать другие форматы конфигурации, смотрите пример для AWS CLI в разделе [Настройка CORS](../operations/buckets/cors.md).