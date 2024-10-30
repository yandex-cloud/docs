---
title: Какие методы S3 API доступны для управления бакетом {{ objstorage-full-name }}
description: Из статьи вы узнаете, какие методы S3 API доступны для управления бакетом.
---

# Все методы Bucket

#|
|| **Метод** | **Описание** ||
|| [create](bucket/create.md) | Создает бакет. ||
|| [getMeta](bucket/getmeta.md) | Проверяет существование бакета и доступ к нему. ||
|| [listObjects](bucket/listobjects.md) | Возвращает список объектов в бакете. ||
|| [listBuckets](bucket/list.md) | Возвращает список бакетов. ||
|| [deleteBucket](bucket/delete.md) | Удаляет бакет. ||


|| [getBucketEncryption](bucket/getbucketencryption.md) | Проверяет наличие шифрования у бакета. ||
|| [deleteBucketEncryption](bucket/deletebucketencryption.md) | Убирает шифрование бакета. ||
|| [putBucketEncryption](bucket/putbucketencryption.md) | Добавляет шифрование бакету. ||


|| [putBucketVersioning](bucket/putBucketVersioning.md) | Включает или приостанавливает версионирование бакета. ||
|| [getBucketVersioning](bucket/getBucketVersioning.md) | Возвращает состояние опции версионирования. ||
|| [putBucketLogging](bucket/putBucketLogging.md) | Включает и выключает механизм логирования действий с бакетом.


||
|| [getBucketLogging](bucket/getBucketLogging.md) | Возвращает настройки логирования действий с бакетом.


||
|| [listObjectVersions](bucket/listObjectVersions.md) | Возвращает метаданные обо всех версиях объектов в бакете. ||
|| [putObjectLockConfiguration](bucket/putobjectlockconfiguration.md) | Настраивает механизм [блокировок версий объектов](../../concepts/object-lock.md) в [версионируемом](../../concepts/versioning.md) бакете. ||
|| [getObjectLockConfiguration](bucket/getobjectlockconfiguration.md) | Возвращает настройки механизма блокировок. ||
|| [putBucketTagging](bucket/putbuckettagging.md) | Добавляет [метки](../../concepts/tags.md) бакету. ||
|| [getBucketTagging](bucket/getbuckettagging.md) | Возвращает метки бакета. ||
|| [deleteBucketTagging](bucket/deletebuckettagging.md) | Удаляет метки бакета. ||
|#

{% include [the-s3-api-see-also-include](../../../_includes/storage/the-s3-api-see-also-include.md) %}