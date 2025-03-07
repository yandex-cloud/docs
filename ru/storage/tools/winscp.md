---
title: Что такое WinSCP?
description: WinSCP — это графический клиент к сетевым хранилищам для Windows. WinSCP работает с {{ objstorage-name }} как с иерархической файловой системой.
keywords:
  - winscp
  - win scp
  - что такое winscp
---

# WinSCP

[WinSCP](https://winscp.net/eng/docs/lang:ru) — это графический клиент для работы с облачными хранилищами, в том числе совместимыми с [Amazon S3 API](../../glossary/s3.md), на Windows.

{% note info %}

Для работы с {{ objstorage-name }} используйте версию не ниже 5.14.

{% endnote %}

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare-with-bucket](../../_includes/aws-tools/aws-tools-prepare-with-bucket.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Установка {#installation}

[Скачайте](https://winscp.net/eng/download.php) дистрибутив WinSCP и запустите его.

## Подключение {#connection}

1. Запустите WinSCP.
1. На вкладке **Sessions** выберите **New Session...**.
1. В блоке **Sessions** укажите следующие параметры:
    * **File protocol** — **Amazon S3**;
    * **Host name** — `{{ s3-storage-host }}`;
    * **Port number** — `443`;
    * **Access key ID** — идентификатор статического ключа, [полученный ранее](#before-you-begin);
    * **Secret access key** — содержимое статического ключа, [полученное ранее](#before-you-begin).

   Чтобы подключиться к определенному бакету, нажмите кнопку **Advanced...**. В окне **Advanced Site Settings** в меню слева в блоке **Environment** выберите **Directories**. В поле **Remote directory:** укажите имя бакета и нажмите **OK**.
1. Нажмите кнопку **Login**.

После подключения на панели справа появится бакет, созданный ранее.

{% note info %}

WinSCP работает с {{ objstorage-name }} как с иерархической файловой системой. Это значит, что ключи объектов, загруженных через WinSCP, будут иметь вид пути к файлу, например `prefix/subprefix/picture.jpg`.

{% endnote %}

Подробности о работе WinSCP с S3-совместимыми хранилищами см. в [документации WinSCP](https://winscp.net/eng/docs/guide_amazon_s3#buckets).
