---
title: "Какие методы S3 API доступны для управления объектами в бакете {{ objstorage-full-name }}"
description: "Из статьи вы узнаете, какие методы S3 API доступны для управления объектами в бакете."
---

# Все методы Object

Метод | Описание
----- | -----
[upload](object/upload.md) | Загружает объект в {{ objstorage-name }}.
[get](object/get.md) | Выгружает объект из {{ objstorage-name }}.
[patch](object/patch.md) | [Частично изменяет](../../concepts/object-patch.md) объект.
[copy](object/copy.md) | Копирует объект, хранящийся в {{ objstorage-name }}.
[getObjectMeta](object/getobjectmeta.md) | Выгружает метаданные объекта.
[delete](object/delete.md) | Удаляет объект.
[deleteMultipleObjects](object/deletemultipleobjects.md) | Удаляет объекты по списку.
[options](object/options.md) | Проверяет возможность [CORS-запроса](../../concepts/cors.md) к объекту.
[selectObjectContent](object/select.md) | Фильтрует и возвращает содержимое объекта на основе SQL-запроса.
[putObjectTagging](object/putobjecttagging.md) | Добавляет [метки](../../concepts/tags.md) объекту.
[getObjectTagging](object/getobjecttagging.md) | Возвращает метки объекта.
[deleteObjectTagging](object/deleteobjecttagging.md) | Удаляет метки объекта.

{% include [the-s3-api-see-also-include](../../../_includes/storage/the-s3-api-see-also-include.md) %}