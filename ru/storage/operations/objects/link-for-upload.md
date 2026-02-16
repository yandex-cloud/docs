---
title: Получение подписанной ссылки на загрузку объекта в бакет в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете получить подписанную ссылку (pre-signed URL) на загрузку объекта в бакет в {{ objstorage-name }}.
---

# Получение подписанной ссылки (pre-signed URL) на загрузку объекта

Если у вас публичный бакет, загрузка объектов доступна всегда, даже если для бакета не настроен [хостинг сайта](../../concepts/hosting.md). Ссылку можно получить по этой инструкции либо сформировать самостоятельно. [Подробнее про формат ссылки](../../concepts/object.md#object-url).

Если у вас бакет с ограниченным доступом, то {{ objstorage-name }} позволяет сгенерировать подписанную ссылку на загрузку объекта. Любой человек, получивший эту ссылку, сможет загрузить объект даже в бакет с ограниченным доступом. [Подробнее про подписанные ссылки, их генерацию и использование](../../concepts/pre-signed-urls.md).

{% note info %}

Если для бакета настроена [политика доступа](../buckets/policy.md), запрещающая создание подписанных ссылок, создать ссылку не получится. 

{% endnote %}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [storage-get-link-for-upload-cli](../../_includes_service/storage-get-link-for-upload-cli.md) %}

- SDK для Python (boto3) {#sdk-python}

  {% include [storage-get-link-for-upload-sdk-python](../../_includes_service/storage-get-link-for-upload-sdk-python.md) %}

- SDK для JavaScript {#sdk-javascript}

  {% include [storage-get-link-for-upload-sdk-javascript](../../_includes_service/storage-get-link-for-upload-sdk-javascript.md) %}

- SDK для Go {#go}

  {% include [storage-get-link-for-upload-sdk-go](../../_includes_service/storage-get-link-for-upload-sdk-go.md) %}

{% endlist %}

{% note info %}

Продлить срок действия подписанной ссылки на объект в бакете с ограниченным доступом нельзя. Если срок действия ссылки истек, сформируйте новую ссылку.

{% endnote %}

#### См. также {#see-also}

* [{#T}](./link-for-download.md)
