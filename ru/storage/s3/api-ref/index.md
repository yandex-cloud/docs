---
title: Какие методы S3 API доступны для управления {{ objstorage-full-name }}
description: Из статьи вы узнаете, какие методы S3 API доступны для управления {{ objstorage-name }}.
---

# Все сервисы и методы

{{ objstorage-name }} HTTP API предоставляет следующие сервисы:

Сервис | Описание
-------|---------
[Bucket](bucket.md) | Управляет бакетами.
[Object](object.md) | Управляет объектами.
[Multipart upload](multipart.md) | Управляет загрузкой больших объектов.
[Static Website Hosting](hosting.md) | Управляет конфигурациями бакетов для статического веб-хостинга.
[CORS](cors.md) | Управляет конфигурациями CORS для бакетов.
[Lifecycles](lifecycles.md) | Управляет конфигурациям жизненных циклов для объектов в бакетах.
[ACL](acl.md) | Управляет списками управления доступом.
[Bucket Policy](policy.md) | Управляет политиками доступа бакета.

## Поддерживаемые методы {#operations-list}

### Сервис Bucket {#bucket-service}

#|
|| **Метод** | **Описание** ||
|| [CreateBucket](bucket/create.md) | Создает бакет. ||
|| [HeadBucket](bucket/getmeta.md) | Проверяет существование бакета и доступ к нему. ||
|| [ListObjects](bucket/listobjects.md) | Возвращает список объектов в бакете. ||
|| [ListBuckets](bucket/list.md) | Возвращает список бакетов. ||
|| [DeleteBucket](bucket/delete.md) | Удаляет бакет. ||


|| [GetBucketEncryption](bucket/getbucketencryption.md) | Проверяет наличие шифрования у бакета. ||
|| [DeleteBucketEncryption](bucket/deletebucketencryption.md) | Убирает шифрование бакета. ||
|| [PutBucketEncryption](bucket/putbucketencryption.md) | Добавляет шифрование бакету. ||


|| [PutBucketVersioning](bucket/putBucketVersioning.md) | Включает или приостанавливает версионирование бакета. ||
|| [GetBucketVersioning](bucket/getBucketVersioning.md) | Возвращает состояние опции версионирования. ||
|| [PutBucketLogging](bucket/putBucketLogging.md) | Включает и выключает механизм логирования действий с бакетом.


||
|| [GetBucketLogging](bucket/getBucketLogging.md) | Возвращает настройки логирования действий с бакетом.


||
|| [ListObjectVersions](bucket/listObjectVersions.md) | Возвращает метаданные обо всех версиях объектов в бакете. ||
|| [PutObjectLockConfiguration](bucket/putobjectlockconfiguration.md) | Настраивает механизм [блокировок версий объектов](../../concepts/object-lock.md) в [версионируемом](../../concepts/versioning.md) бакете. ||
|| [GetObjectLockConfiguration](bucket/getobjectlockconfiguration.md) | Возвращает настройки механизма блокировок. ||
|| [PutBucketTagging](bucket/putbuckettagging.md) | Добавляет [метки](../../concepts/tags.md) бакету. ||
|| [GetBucketTagging](bucket/getbuckettagging.md) | Возвращает метки бакета. ||
|| [DeleteBucketTagging](bucket/deletebuckettagging.md) | Удаляет метки бакета. ||
|#

### Сервис Object {#object-service}

Метод | Описание
----- | -----
[PutObject](object/upload.md) | Загружает объект в {{ objstorage-name }}.
[GetObject](object/get.md) | Выгружает объект из {{ objstorage-name }}.
[patch](object/patch.md) | [Частично изменяет](../../concepts/object-patch.md) объект.
[CopyObject](object/copy.md) | Копирует объект, хранящийся в {{ objstorage-name }}.
[HeadObject](object/getobjectmeta.md) | Выгружает метаданные объекта.
[DeleteObject](object/delete.md) | Удаляет объект.
[DeleteObjects](object/deletemultipleobjects.md) | Удаляет объекты по списку.
[options](object/options.md) | Проверяет возможность CORS запроса к объекту.
[SelectObjectContent](object/select.md) | Фильтрует и возвращает содержимое объекта на основе SQL-запроса.
[PutObjectRetention](object/putobjectretention.md) | Устанавливает на версию объекта временную [блокировку](../../concepts/object-lock.md) либо настраивает или снимает уже установленную блокировку.
[PutObjectLegalHold](object/putobjectlegalhold.md) | Устанавливает на версию объекта бессрочную блокировку или снимает ее.
[GetObjectRetention](object/getobjectretention.md) | Возвращает настройки временной блокировки, установленной на версию объекта.
[GetObjectLegalHold](object/getobjectlegalhold.md) | Возвращает настройки бессрочной блокировки, установленной на версию объекта.
[PutObjectTagging](object/putobjecttagging.md) | Добавляет [метки](../../concepts/tags.md) объекту.
[GetObjectTagging](object/getobjecttagging.md) | Возвращает метки объекта.
[DeleteObjectTagging](object/deleteobjecttagging.md) | Удаляет метки объекта.

### Сервис Multipart upload {#multipart-upload-service}

Метод | Описание
----- | -----
[CreateMultipartUpload](multipart/startupload.md) | Инициализирует составную загрузку.
[UploadPart](multipart/uploadpart.md) | Загружает часть объекта.
[UploadPartCopy](multipart/copypart.md) | Копирует часть объекта.
[ListParts](multipart/listparts.md) | Выдает список загруженных частей.
[AbortMultipartUpload](multipart/abortupload.md) | Прерывает составную загрузку.
[CompleteMultipartUpload](multipart/completeupload.md) | Завершает составную загрузку.
[ListMultipartUploads](multipart/listuploads.md) | Выдает список незавершенных загрузок.

### Сервис Static Website Hosting {#static-website-hosting-service}

Метод | Описание
----- | -----
[PutBucketWebsite](hosting/upload.md) | Загружает конфигурацию бакета для хостинга статических сайтов в {{ objstorage-name }}.
[GetBucketWebsite](hosting/get.md) | Возвращает конфигурацию бакета для хостинга статических сайтов из {{ objstorage-name }}.
[DeleteBucketWebsite](hosting/delete.md) | Удаляет конфигурацию бакета для хостинга статических сайтов.

### Сервис CORS {#cors-service}

Метод | Описание
----- | -----
[PutBucketCors](cors/upload.md) | Загружает конфигурацию CORS для бакета.
[GetBucketCors](cors/get.md) | Возвращает конфигурацию CORS для бакета.
[DeleteBucketCors](cors/delete.md) | Удаляет конфигурацию CORS для бакета.

### Сервис Lifecycles {#lifecycles-service}

Метод | Описание
----- | -----
[PutBucketLifecycleConfiguration](lifecycles/upload.md) | Загружает конфигурацию жизненного цикла объектов в {{ objstorage-name }}.
[GetBucketLifecycleConfiguration](lifecycles/get.md) | Возвращает конфигурацию жизненного цикла объектов из {{ objstorage-name }}.
[DeleteBucketLifecycle](lifecycles/delete.md) | Удаляет конфигурацию жизненного цикла объектов из {{ objstorage-name }}.

### Сервис ACL {#acl-service}

Метод | Описание
----- | -----
[GetObjectAcl](acl/objectget.md) | Возвращает список управления доступом для объекта.
[PutObjectAcl](acl/objectput.md) | Загружает список управления доступом для объекта.
[GetBucketAcl](acl/bucketget.md) | Возвращает список управления доступом для бакета.
[PutBucketAcl](acl/bucketput.md) | Загружает список управления доступом для бакета.

### Сервис Bucket Policy {#bucket-policy}

Метод | Описание
----- | -----
[GetBucketPolicy](policy/get.md) | Возвращает политику доступа для заданного бакета.
[PutBucketPolicy](policy/put.md) | Применяет политику доступа к заданному бакету.
[DeleteBucketPolicy](policy/delete.md) | Удаляет политику доступа заданного бакета.

## Полезные ссылки {#see-also}

* [{#T}](../../s3/s3-api-quickstart.md)
* [{#T}](../../s3/index.md)
* [{#T}](../../tools/index.md)
* [Отладка запросов с помощью утилиты AWS CLI](../signing-requests.md#debugging)
* [Пример отправки подписанного запроса с помощью утилиты curl](../../api-ref/authentication.md#s3-api-example)
* [Пример кода для генерации подписи](../../concepts/pre-signed-urls.md#code-examples)