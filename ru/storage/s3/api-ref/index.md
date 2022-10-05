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

{% if product == "yandex-cloud" %}

{% if audience != "internal" %}

Метод | Описание
----- | -----
[create](bucket/create.md) | Создает бакет.
[getBucketEncryption](bucket/getbucketencryption.md) | Проверяет наличие шифрования у бакета.
[getMeta](bucket/getmeta.md) | Проверяет существование бакета и доступ к ней.
[listObjects](bucket/listobjects.md) | Возвращает список объектов в бакете.
[listBuckets](bucket/list.md) | Возвращает список бакетов.
[deleteBucket](bucket/delete.md) | Удаляет бакет.
[deleteBucketEncryption](bucket/deletebucketencryption.md) | Убирает шифрование бакета.
[putBucketEncryption](bucket/putbucketencryption.md) | Добавляет шифрование бакету.
[putBucketVersioning](bucket/putBucketVersioning.md) | Включает или приостанавливает версионирование бакета.
[getBucketVersioning](bucket/getBucketVersioning.md) | Возвращает состояние опции версионирования.
[putBucketLogging](bucket/putBucketLogging.md) | Включает и выключает механизм логирования действий с бакетом.
[getBucketLogging](bucket/getBucketLogging.md) | Возвращает настройки логирования действий с бакетом.
[listObjectVersions](bucket/listObjectVersions.md) | Возвращает метаданные обо всех версиях объектов в бакете.

{% else %}

Метод | Описание
----- | -----
[create](bucket/create.md) | Создает бакет.
[getMeta](bucket/getmeta.md) | Проверяет существование бакета и доступ к ней.
[listObjects](bucket/listobjects.md) | Возвращает список объектов в бакете.
[listBuckets](bucket/list.md) | Возвращает список бакетов.
[deleteBucket](bucket/delete.md) | Удаляет бакет.
[putBucketVersioning](bucket/putBucketVersioning.md) | Включает или приостанавливает версионирование бакета.
[getBucketVersioning](bucket/getBucketVersioning.md) | Возвращает состояние опции версионирования.
[putBucketLogging](bucket/putBucketLogging.md) | Включает и выключает механизм логирования действий с бакетом.
[getBucketLogging](bucket/getBucketLogging.md) | Возвращает настройки логирования действий с бакетом.
[listObjectVersions](bucket/listObjectVersions.md) | Возвращает метаданные обо всех версиях объектов в бакете.

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

Метод | Описание
----- | -----
[create](bucket/create.md) | Создает бакет.
[getMeta](bucket/getmeta.md) | Проверяет существование бакета и доступ к ней.
[listObjects](bucket/listobjects.md) | Возвращает список объектов в бакете.
[listBuckets](bucket/list.md) | Возвращает список бакетов.
[deleteBucket](bucket/delete.md) | Удаляет бакет.
[putBucketVersioning](bucket/putBucketVersioning.md) | Включает или приостанавливает версионирование бакета.
[getBucketVersioning](bucket/getBucketVersioning.md) | Возвращает состояние опции версионирования.
[listObjectVersions](bucket/listObjectVersions.md) | Возвращает метаданные обо всех версиях объектов в бакете.

{% endif %}

### Сервис Object {#object-service}

Метод | Описание
----- | -----
[upload](object/upload.md) | Загружает объект в {{ objstorage-name }}.
[get](object/get.md) | Выгружает объект из {{ objstorage-name }}.
[copy](object/copy.md) | Копирует объект, хранящийся в {{ objstorage-name }}.
[getObjectMeta](object/getobjectmeta.md) | Выгружает метаданные объекта.
[delete](object/delete.md) | Удаляет объект.
[deleteMultipleObjects](object/deletemultipleobjects.md) | Удаляет объекты по списку.
[options](object/options.md) | Проверяет возможность CORS запроса к объекту.
[selectObjectContent](object/select.md) | Фильтрует и возвращает содержимое объекта на основе SQL-запроса.

### Сервис Multipart upload {#multipart-upload-service}

Метод | Описание
----- | -----
[startUpload](multipart/startupload.md) | Инициализирует составную загрузку.
[uploadPart](multipart/uploadpart.md) | Загружает часть объекта.
[copyPart](multipart/copypart.md) | Копирует часть объекта.
[listParts](multipart/listparts.md) | Выдает список загруженных частей.
[abortUpload](multipart/abortupload.md) | Прерывает составную загрузку.
[completeUpload](multipart/completeupload.md) | Завершает составную загрузку.
[listUploads](multipart/listuploads.md) | Выдает список незавершенных загрузок.

### Сервис Static Website Hosting {#static-website-hosting-service}

Метод | Описание
----- | -----
[upload](hosting/upload.md) | Загружает конфигурацию бакета для хостинга статических сайтов в {{ objstorage-name }}.
[get](hosting/get.md) | Возвращает конфигурацию бакета для хостинга статических сайтов из {{ objstorage-name }}.
[delete](hosting/delete.md) | Удаляет конфигурацию бакета для хостинга статических сайтов.

### Сервис CORS {#cors-service}

Метод | Описание
----- | -----
[upload](cors/upload.md) | Загружает конфигурацию CORS для бакета.
[get](cors/get.md) | Возвращает конфигурацию CORS для бакета.
[delete](cors/delete.md) | Удаляет конфигурацию CORS для бакета.

### Сервис Lifecycles {#lifecycles-service}

Метод | Описание
----- | -----
[upload](lifecycles/upload.md) | Загружает конфигурацию жизненного цикла объектов в {{ objstorage-name }}.
[get](lifecycles/get.md) | Возвращает конфигурацию жизненного цикла объектов из {{ objstorage-name }}.
[delete](lifecycles/delete.md) | Удаляет конфигурацию жизненного цикла объектов из {{ objstorage-name }}.

### Сервис ACL {#acl-service}

Метод | Описание
----- | -----
[objectGetAcl](acl/objectget.md) | Возвращает список управления доступом для объекта.
[objectPutAcl](acl/objectput.md) | Загружает список управления доступом для объекта.
[bucketGetAcl](acl/bucketget.md) | Возвращает список управления доступом для бакета.
[bucketPutAcl](acl/bucketput.md) | Загружает список управления доступом для бакета.

### Сервис Bucket Policy {#bucket-policy}

Метод | Описание
----- | -----
[GetBucketPolicy](policy/get.md) | Возвращает политику доступа для заданного бакета.
[PutBucketPolicy](policy/put.md) | Применяет политику доступа к заданному бакету.
[DeleteBucketPolicy](policy/delete.md) | Удаляет политику доступа заданного бакета.

## См. также {#see-also}
* [{#T}](../../s3/index.md)
* [{#T}](../../tools/index.md)
