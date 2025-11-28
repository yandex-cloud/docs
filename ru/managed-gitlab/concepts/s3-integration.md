---
title: Интеграция с хранилищем {{ objstorage-full-name }} в {{ mgl-full-name }}
description: Из статьи вы узнаете об интеграции с S3-хранилищем {{ objstorage-full-name }} в {{ mgl-full-name }}.
---

# Интеграция с хранилищем {{ objstorage-full-name }}

{{ GL }} поддерживает использование S3-хранилища для хранения различных типов данных. Интеграция с S3-хранилищем позволяет уменьшить объем данных на дисках [инстанса](index.md#instance) и предотвратить их переполнение. Подробнее о хранении данных см. в [документации {{ GL }}](https://docs.gitlab.com/administration/object_storage/).

В {{ mgl-name }} можно [включить интеграцию с {{ objstorage-name }}](../operations/objstorage-integration.md), совместимым с S3, через [консоль управления]({{ link-console-main }}). При этом {{ mgl-name }} управляет созданием, использованием и масштабированием хранилища.

Вы можете выбрать типы данных, которые будут храниться в {{ objstorage-name }}:

{% include [s3-object-type](../../_includes/managed-gitlab/s3-object-type.md) %}

Миграция файлов из больших репозиториев в {{ objstorage-name }} может занять более суток.

{% include [objstorage-disable-note](../../_includes/managed-gitlab/objstorage-disable-note.md) %}