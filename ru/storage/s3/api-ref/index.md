# Все сервисы и методы

[!KEYREF objstorage-name] HTTP API предоставляет следующие сервисы:

Сервис | Описание
-------|---------
[Bucket](bucket.md) | Управляет бакетами.
[Object](object.md) | Управляет объектами.
[Multipart upload](multipart.md) | Управляет загрузкой больших объектов.
[Static Website Hosting](hosting.md) | Управляет конфигурациями бакетов для статического веб-хостинга.
[CORS](cors.md) | Управляет конфигурациями CORS для бакетов.
[Lifecycles](lifecycles.md) | Управляет конфигурациям жизненных циклов для объектов в бакетах.

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
[upload](object/upload.md) | Загружает объект в [!KEYREF objstorage-name].
[get](object/get.md) | Выгружает объект из [!KEYREF objstorage-name].
[copy](object/copy.md) | Копирует объект, хранящийся в [!KEYREF objstorage-name].
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
[upload](hosting/upload.md) | Загружает конфигурацию бакета для хостинга статических сайтов в [!KEYREF objstorage-name].
[get](hosting/get.md) | Возвращает конфигурацию бакета для хостинга статических сайтов  из [!KEYREF objstorage-name].
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
[upload](lifecycles/upload.md) | Загружает конфигурацию жизненного цикла объектов в [!KEYREF objstorage-name].
[get](lifecycles/get.md) | Возвращает конфигурацию жизненного цикла объектов из [!KEYREF objstorage-name].
[delete](lifecycles/delete.md) | Удаляет конфигурацию жизненного цикла объектов из [!KEYREF objstorage-name].


## См. также
- [[!TITLE]](../../s3/index.md)
- [[!TITLE]](../../instruments/index.md)

