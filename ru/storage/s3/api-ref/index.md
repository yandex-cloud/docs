---
title: Какие методы S3 API доступны для управления {{ objstorage-full-name }}
description: Из статьи вы узнаете, какие методы S3 API доступны для управления {{ objstorage-name }}.
---

# Все сервисы и методы

{{ objstorage-name }} HTTP API предоставляет следующие сервисы:

#|
|| **Сервис** | **Описание** ||
|| [Bucket](bucket.md) | Управляет бакетами. ||
|| [Object](object.md) | Управляет объектами. ||
|| [Multipart upload](multipart.md) | Управляет загрузкой больших объектов. ||
|| [Static Website Hosting](hosting.md) | Управляет конфигурациями бакетов для статического веб-хостинга. ||
|| [CORS](cors.md) | Управляет конфигурациями CORS для бакетов. ||
|| [Lifecycles](lifecycles.md) | Управляет конфигурациям жизненных циклов для объектов в бакетах. ||
|| [ACL](acl.md) | Управляет списками управления доступом. ||
|| [Bucket Policy](policy.md) | Управляет политиками доступа бакета. ||
|#

## Поддерживаемые методы {#operations-list}

### Сервис Bucket {#bucket-service}

{% include [bucket-methods-table](../../../_includes/storage/s3-api-ref/bucket-methods-table.md) %}

### Сервис Object {#object-service}

{% include [object-methods-table](../../../_includes/storage/s3-api-ref/object-methods-table.md) %}

### Сервис Multipart upload {#multipart-upload-service}

{% include [multipart-methods-table](../../../_includes/storage/s3-api-ref/multipart-methods-table.md) %}

### Сервис Static Website Hosting {#static-website-hosting-service}

{% include [hosting-methods-table](../../../_includes/storage/s3-api-ref/hosting-methods-table.md) %}

### Сервис CORS {#cors-service}

{% include [cors-methods-table](../../../_includes/storage/s3-api-ref/cors-methods-table.md) %}

### Сервис Lifecycles {#lifecycles-service}

{% include [lifecycles-methods-table](../../../_includes/storage/s3-api-ref/lifecycles-methods-table.md) %}

### Сервис ACL {#acl-service}

{% include [acl-methods-table](../../../_includes/storage/s3-api-ref/acl-methods-table.md) %}

### Сервис Bucket Policy {#bucket-policy}

{% include [policy-methods-table](../../../_includes/storage/s3-api-ref/policy-methods-table.md) %}

## Полезные ссылки {#see-also}

* [{#T}](../../s3/s3-api-quickstart.md)
* [{#T}](../../s3/index.md)
* [{#T}](../../tools/index.md)
* [Отладка запросов с помощью утилиты AWS CLI](../signing-requests.md#debugging)
* [Пример отправки подписанного запроса с помощью утилиты curl](../../api-ref/authentication.md#s3-api-example)
* [Пример кода для генерации подписи](../../concepts/pre-signed-urls.md#code-examples)