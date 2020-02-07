# CORS

{{ objstorage-full-name }} поддерживает [кросс-доменные запросы](https://ru.wikipedia.org/wiki/Cross-origin_resource_sharing) к объектам в бакете.

Для управления конфигурацией CORS для каждого бакета можно применять:

- [Консоль управления](../operations/buckets/cors.md) Яндекс.Облака.
- [HTTP API, совместимый с Amazon S3](../s3/index.md).

    Таким образом, конфигурацией CORS можно управлять при помощи [инструментов](../tools/index.md), поддерживающих  HTTP API Amazon S3.

При управлении конфигурацией CORS с помощью HTTP API, совместимого с Amazon S3, задайте [ее в формате XML](../s3/api-ref/cors/xml-config.md). Различные инструменты могут требовать другие форматы конфигурации, смотрите пример для AWS CLI в разделе [{#T}](../operations/buckets/cors.md).
