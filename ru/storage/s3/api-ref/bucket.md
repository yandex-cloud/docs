---
title: Какие методы S3 API доступны для управления бакетом {{ objstorage-full-name }}
description: Из статьи вы узнаете, какие методы S3 API доступны для управления бакетом.
---

# Все методы Bucket

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

{% include [the-s3-api-see-also-include](../../../_includes/storage/the-s3-api-see-also-include.md) %}