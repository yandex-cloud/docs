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

## Поддерживаемые методы {#operations-list}

### Сервис Bucket

Метод | Описание
----- | -----
[create](bucket/create.md) | Создает бакет.
[getMeta](bucket/getmeta.md) | Проверяет существование бакета и доступ к ней.
[listObjects](bucket/listobjects.md) | Возвращает список объектов в бакете.
[listBuckets](bucket/list.md) | Возвращает список бакетов.
[deleteBucket](bucket/delete.md) | Удаляет бакет.

### Сервис Object

Метод | Описание
----- | -----
[upload](object/upload.md) | Загружает объект в {{ objstorage-name }}.
[get](object/get.md) | Выгружает объект из {{ objstorage-name }}.
[copy](object/copy.md) | Копирует объект, хранящийся в {{ objstorage-name }}.
[getObjectMeta](object/getobjectmeta.md) | Выгружает метаданные объекта.
[delete](object/delete.md) | Удаляет объект.
[deleteMultipleObjecs](object/deletemultipleobjects.md) | Удаляет объекты по списку.
[options](object/options.md) | Проверяет возможность CORS запроса к объекту.

### Сервис Multipart upload

Метод | Описание
----- | -----
[startUpload](multipart/startupload.md) | Инициализирует составную загрузку.
[uploadPart](multipart/uploadpart.md) | Загружает часть объекта.
[copyPart](multipart/copypart.md) | Копирует часть объекта.
[listParts](multipart/listparts.md) | Выдает список загруженных частей.
[abortUpload](multipart/abortupload.md) | Прерывает составную загрузку.
[completeUpload](multipart/completeupload.md) | Завершает составную загрузку.
[listUploads](multipart/listuploads.md) | Выдает список незавершенных загрузок.

### Сервис Static Website Hosting

Метод | Описание
----- | -----
[upload](hosting/upload.md) | Загружает конфигурацию бакета для хостинга статических сайтов в {{ objstorage-name }}.
[get](hosting/get.md) | Возвращает конфигурацию бакета для хостинга статических сайтов из {{ objstorage-name }}.
[delete](hosting/delete.md) | Удаляет конфигурацию бакета для хостинга статических сайтов.

### Сервис CORS

Метод | Описание
----- | -----
[upload](cors/upload.md) | Загружает конфигурацию CORS для бакета.
[get](cors/get.md) | Возвращает конфигурацию CORS для бакета.
[delete](cors/delete.md) | Удаляет конфигурацию CORS для бакета.

### Сервис Lifecycles

Метод | Описание
----- | -----
[upload](lifecycles/upload.md) | Загружает конфигурацию жизненного цикла объектов в {{ objstorage-name }}.
[get](lifecycles/get.md) | Возвращает конфигурацию жизненного цикла объектов из {{ objstorage-name }}.
[delete](lifecycles/delete.md) | Удаляет конфигурацию жизненного цикла объектов из {{ objstorage-name }}.

### Сервис ACL

Метод | Описание
----- | -----
[objectGetAcl](acl/objectget.md) | Возвращает список управления доступом для объекта.
[objectPutAcl](acl/objectput.md) | Загружает список управления доступом для объекта.
[bucketGetAcl](acl/bucketget.md) | Возвращает список управления доступом для бакета.
[bucketPutAcl](acl/bucketput.md) | Загружает список управления доступом для бакета.


## См. также
- [{#T}](../../s3/index.md)
- [{#T}](../../instruments/index.md)
