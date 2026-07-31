---
title: Справочник {{ TF }} для {{ data-catalog-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для {{ data-catalog-name }} в сервисе {{ metadata-hub-full-name }}.
---

# Справочник {{ TF }} для {{ data-catalog-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ metadata-hub-full-name }} поддерживается следующий ресурс провайдера {{ TF }}:

| **Ресурс {{ TF }}**                                                                | **Ресурс {{ yandex-cloud }}**                    |
|------------------------------------------------------------------------------------|--------------------------------------------------|
| [yandex_datacatalog_catalog]({{ tf-provider-resources-link }}/datacatalog_catalog) | [Каталог метаданных](./concepts/data-catalog.md) |

## Источники данных {#data-sources}

Для {{ metadata-hub-full-name }} поддерживается следующий источник данных провайдера {{ TF }}:

| **Источник данных {{ TF }}**                                                         | **Описание**                                                   |
|--------------------------------------------------------------------------------------|----------------------------------------------------------------|
| [yandex_datacatalog_catalog]({{ tf-provider-datasources-link }}/datacatalog_catalog) | Информация о [каталоге метаданных](./concepts/data-catalog.md) |
