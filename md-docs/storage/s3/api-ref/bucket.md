[Документация Yandex Cloud](../../../index.md) > [Yandex Object Storage](../../index.md) > Справочник API > [AWS S3 REST](../index.md) > [REST](index.md) > Bucket > Все методы

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

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../concepts/pre-signed-urls.md#code-examples)