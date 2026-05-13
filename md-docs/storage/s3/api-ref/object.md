# Все методы Object

Метод | Описание
----- | -----
[PutObject](object/upload.md) | Загружает объект в Object Storage.
[GetObject](object/get.md) | Выгружает объект из Object Storage.
[patch](object/patch.md) | [Частично изменяет](../../concepts/object-patch.md) объект.
[CopyObject](object/copy.md) | Копирует объект, хранящийся в Object Storage.
[HeadObject](object/getobjectmeta.md) | Выгружает метаданные объекта.
[DeleteObject](object/delete.md) | Удаляет объект.
[DeleteObjects](object/deletemultipleobjects.md) | Удаляет объекты по списку.
[options](object/options.md) | Проверяет возможность [CORS-запроса](../../concepts/cors.md) к объекту.
[SelectObjectContent](object/select.md) | Фильтрует и возвращает содержимое объекта на основе SQL-запроса.
[PutObjectTagging](object/putobjecttagging.md) | Добавляет [метки](../../concepts/tags.md) объекту.
[GetObjectTagging](object/getobjecttagging.md) | Возвращает метки объекта.
[DeleteObjectTagging](object/deleteobjecttagging.md) | Удаляет метки объекта.

#### См. также {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../concepts/pre-signed-urls.md#code-examples)