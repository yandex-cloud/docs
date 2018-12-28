# Все сервисы и методы

[!KEYREF objstorage-name] HTTP API предоставляет следующие сервисы:

Сервис | Описание
-------|---------
[Bucket](bucket.md) | Управляет корзинами.
[Object](object.md) | Управляет объектами.
[Multipart upload](multipart.md) | Управляет загрузкой больших объектов.
[Static Website Hosting](hosting.md) | Управляет конфигурациями корзин для статического веб-хостинга.
[CORS](cors.md) | Управляет CORS конфигурациями для корзин.

## Поддерживаемые методы {#operations-list}

### Сервис Bucket 

Метод | Описание
----- | -----
[create](bucket/create.md) | Создает корзину.
[getMeta](bucket/getmeta.md) | Проверяет существование корзины и доступ к ней.
[listObjects](bucket/listobjects.md) | Возвращает список объектов в корзине.
[listBuckets](bucket/list.md) | Возвращает список корзин.
[deleteBucket](bucket/delete.md) | Удаляет корзину.

### Сервис Object

Метод | Описание
----- | -----
[upload](object/upload.md) | Загружает объект в [!KEYREF objstorage-name].
[get](object/get.md) | Выгружает объект из [!KEYREF objstorage-name].
[getObjectMeta](object/getobjectmeta.md) | Выгружает метаданные объекта.
[delete](object/delete.md) | Удаляет объект.
[deleteMultipleObjecs](object/deletemultipleobjects.md) | Удаляет объекты по списку.
[options](object/options.md) | Проверяет возможность CORS запроса к объекту.

### Сервис Multipart upload

Метод | Описание
----- | -----
[startUpload](multipart/startupload.md) | Инициализирует составную загрузку.
[uploadPart](multipart/uploadpart.md) | Загружает часть объекта.
[listParts](multipart/listparts.md) | Выдает список загруженных частей.
[abortUpload](multipart/abortupload.md) | Прерывает составную загрузку.
[completeUpload](multipart/completeupload.md) | Завершает составную загрузку.
[listUploads](multipart/listuploads.md) | Выдает список незавершенных загрузок.

### Сервис Static Website Hosting

Метод | Описание
----- | -----
[upload](hosting/upload.md) | Загружает конфигурацию корзины для хостинга статических сайтов в [!KEYREF objstorage-name].
[get](hosting/get.md) | Возвращает конфигурацию корзины для хостинга статических сайтов  из [!KEYREF objstorage-name].
[delete](hosting/delete.md) | Удаляет конфигурацию корзины для хостинга статических сайтов.

### Сервис CORS

Метод | Описание
----- | -----
[upload](cors/upload.md) | Загружает конфигурацию CORS для корзины.
[get](cors/get.md) | Возвращает конфигурацию CORS для корзины.
[delete](cors/delete.md) | Удаляет конфигурацию CORS для корзины.

## См. также
- [[!TITLE]](../../s3/index.md)
- [[!TITLE]](../../instruments/index.md)

