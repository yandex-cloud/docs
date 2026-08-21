---
title: Remotely Save
description: Remotely Save — плагин для Obsidian, который синхронизирует хранилище заметок с облачными хранилищами, совместимыми с Amazon S3 API, в том числе с {{ objstorage-name }}.
---

# Remotely Save

[Remotely Save](https://github.com/remotely-save/remotely-save) — плагин для [Obsidian](https://obsidian.md/), который синхронизирует хранилище заметок с облачными хранилищами, совместимыми с [Amazon S3 API](../../glossary/s3.md), в том числе с {{ objstorage-name }}.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare-with-bucket](../../_includes/aws-tools/aws-tools-prepare-with-bucket.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Установка {#installation}

1. В Obsidian откройте **Settings** → **Community plugins**.
1. Отключите **Safe mode**, если он включен.
1. Нажмите **Browse** и в строке поиска введите `Remotely Save`.
1. Нажмите **Install**, затем **Enable**.

## Настройка {#configuration}

1. В Obsidian откройте **Settings** → **Remotely Save**.
1. В поле **Choose a remote service** выберите **S3 or compatible**.
1. Укажите параметры подключения:
    * **Endpoint** — `https://{{ s3-storage-host }}`;
    * **Region** — `{{ region-id }}`;
    * **Access Key ID** — идентификатор статического ключа, [полученный ранее](#before-you-begin);
    * **Secret Access Key** — содержимое статического ключа, [полученное ранее](#before-you-begin);
    * **Bucket Name** — имя бакета, [созданного ранее](#before-you-begin).
1. Нажмите **Check** для проверки подключения.
1. После успешной проверки нажмите **Save settings**.

## Синхронизация {#sync}

Для запуска синхронизации нажмите на иконку плагина на боковой панели Obsidian или воспользуйтесь командой `Remotely Save: start sync` через палитру команд (`Ctrl+P` / `Cmd+P`).

{% note info %}

Remotely Save работает с {{ objstorage-name }} как с иерархической файловой системой. Ключи объектов, которые загружены через плагин, будут иметь вид пути к файлу, например `folder/subfolder/note.md`.

{% endnote %}

Подробнее о работе плагина читайте в [документации Remotely Save](https://github.com/remotely-save/remotely-save).
