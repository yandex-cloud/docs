---
title: Инструкции по работе с {{ objstorage-full-name }} (S3)
description: "Из статьи вы узнаете, как работать с {{ objstorage-full-name }} (S3) в {{ yandex-cloud }}. Вы научитесь работать с бакетами (создавать, удалять и редактировать), объектами (загружать, скачивать, получать ссылки на скачивание, удалять объекты), размещать статические сайты (настраивать хостинг, собственный домен, настраивать https протокол)."
---

# Пошаговые инструкции для {{ objstorage-name }}

## Бакеты {#buckets}

* [{#T}](buckets/create.md)
* [{#T}](buckets/delete.md)
* [{#T}](buckets/limit-max-volume.md)
* [{#T}](buckets/bucket-availability.md)
* [{#T}](buckets/edit-acl.md)
{% if product == "yandex-cloud" %}
* [{#T}](buckets/enable-logging.md)
{% endif %}

## Объекты {#objects}

* [{#T}](objects/upload.md)
* [{#T}](objects/info.md)
* [{#T}](objects/download.md)
* [{#T}](objects/link-for-download.md)
* [{#T}](objects/delete.md)
* [{#T}](objects/delete-all.md)
* [{#T}](objects/deleting-multipart.md)
* [{#T}](objects/edit-acl.md)

## Хостинг статических сайтов {#hosting}

* [{#T}](hosting/setup.md)
* [{#T}](hosting/own-domain.md)
* [{#T}](hosting/multiple-domains.md)
* [{#T}](hosting/certificate.md)
