---
title: Каталог метаданных
description: Сервис {{ data-catalog-name }} позволяет вам собирать, анализировать и размечать метаданные из различных источников. Вы можете загружать структурные метаданные, например список таблиц в кластере управляемых баз данных, их схемы и связи между таблицами. Основная сущность, которой оперирует сервис {{ data-catalog-name }} — каталог метаданных. Каталог одновременно является местом хранения метаданных и рабочим пространством для их разметки.
---

# Каталог метаданных


{% note info %}

{% include [preview-pp](../../_includes/preview-pp.md) %}

{% endnote %}

{% include [data-catalog-definition](../../_includes/metadata-hub/data-catalog-definition.md) %}

Основная сущность, которой оперирует сервис {{ data-catalog-name }} — _каталог метаданных_.

{% include [data-catalog-concept](../../_includes/metadata-hub/data-catalog-concept.md) %}

## Загрузка метаданных {#metadata-upload}

Для загрузки метаданных используются _источники_ и _загрузки_.

[Источник](data-catalog-sources.md) — это подключение, через которое загружаются метаданные. В этом подключении хранится информация о БД или другом сервисе, из которого загружаются метаданные, а также данные для аутентификации.

Источник может подключаться как к кластерам управляемых БД в облаке {{ yandex-cloud }}, так и к пользовательским инсталляциям этих БД. Также поддерживается поставка связей между объектами на основе запущенных поставок данных в сервисе {{ data-transfer-full-name }}.

Загрузка — это процесс, который подключается к указанному в источнике хранилищу данных или сервису и загружает его метаданные в каталог. В загрузке вы можете настроить:

* Фильтры, чтобы получать только нужные вам метаданные.
* Профилирование, чтобы выгружать нужные вам данные о статистике.

Загрузка привязывается к конкретному источнику и работает только с ним. При этом к одному источнику можно привязывать несколько загрузок. Это позволяет создать несколько загрузок с разными фильтрами для одного источника.

Загрузку можно запускать вручную или настроить ее запуск по расписанию. В указанное время загрузка всегда выполняется однократно, даже если в расписании указан период, а не конкретный час.

Максимальное количество источников и загрузок в каталоге определяется квотами сервиса.

## Хранилище данных {#data-store}

{% include [data-catalog-concept](../../_includes/metadata-hub/data-catalog-storage-concept.md) %}

## Разметка метаданных {#metadata-markup}

### Домены и поддомены {#domains-and-subdomains}

{% include [data-catalog-concept](../../_includes/metadata-hub/data-catalog-domain-concept.md) %}

### Классификации и теги {#classifications-and-tags}

{% include [data-catalog-concept](../../_includes/metadata-hub/data-catalog-classification-tag-concept.md) %}

### Глоссарии и термины {#glossaries-and-terms}

{% include [data-catalog-concept](../../_includes/metadata-hub/data-catalog-glossary-term.md) %}

## Примеры использования {#examples}

* [{#T}](../operations/data-catalog/create-term.md) в глоссарии.
* [{#T}](../operations/data-catalog/create-term-child.md).
* [{#T}](../operations/data-catalog/update-glossary.md).
* [{#T}](../operations/data-catalog/update-term.md).
* [{#T}](../operations/data-catalog/create-tag.md) в классификации.
* [{#T}](../operations/data-catalog/update-classification.md).
* [{#T}](../operations/data-catalog/update-tag.md) в классификации.