---
title: Загрузка образа диска в облако
description: Эта инструкция описывает, как загрузить файл образа диска в хранилище {{ objstorage-name }} с ОС Linux, а также создать из него образ и виртуальную машину в сервисе {{ compute-name }}.
keywords:
  - загрузка образа
  - загрузка образа диска
  - загрузка в облако
  - образ диска
  - образ ОС Linux
---

# Загрузить свой образ диска в {{ yandex-cloud }}

Эта инструкция описывает, как загрузить в [{{ objstorage-full-name }}](../../../storage/) файл образа с операционной системой Linux, а также создать из него [образ](../../concepts/image.md) и [виртуальную машину](../../concepts/vm.md) в сервисе {{ compute-name }}.

Поддерживаются известные системы [виртуализации](../../../glossary/virtualization.md).

{% note warning %}

В {{ compute-name }} создать образ можно только из файла, загруженного в {{ objstorage-name }}. Также вы можете мигрировать ВМ с помощью [Хайстекс Акура](../../../tutorials/infrastructure-management/hystax-migration.md).

{% endnote %}

## Подготовьте файл с образом {#prepare-file}

{% include [image-create-requirements](../../../_includes/compute/image-create-requirements.md) %}

{% include [available-image-format](../../../_includes/compute/available-image-format.md) %}

Инструкции по настройке см. в разделе [{#T}](custom-image.md).

## Загрузите файл образа в {{ objstorage-name }} {#upload-file}

{% include [image-file-upload-to-bucket](../../../_includes/compute/image-file-upload-to-bucket.md) %}

## Создайте образ в {{ compute-name }} {#create-image}

{% include [create-own-image-from-bucket](../../../_includes/compute/create-own-image-from-bucket.md) %}

## Удалите образ из {{ objstorage-name }} {#delete-image}

Если образ был успешно создан, вы можете [удалить файл образа](../../../storage/operations/objects/delete.md) из сервиса {{ objstorage-name }}. Также можно [удалить бакет](../../../storage/operations/buckets/delete.md), если в нем не осталось объектов.

## Создайте ВМ из подготовленного образа {#create-vm-from-user-image}

Вы можете создать виртуальную машину с дисками, из подготовленного заранее образа.

{% include notitle [Как создать ВМ из своего образа](../../operations/vm-create/create-from-user-image.md#create-vm-from-image) %}

О стоимости использования {{ objstorage-name }} читайте в разделе [{#T}](../../../storage/pricing.md).