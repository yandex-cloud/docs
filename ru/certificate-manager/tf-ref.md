---
title: Справочник {{ TF }} для {{ certificate-manager-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ certificate-manager-name }}.
---

# Справочник {{ TF }} для {{ certificate-manager-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ certificate-manager-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate) | [TLS-сертификат](./concepts/index.md#types) |

## Источники данных {#data-sources}

Для {{ certificate-manager-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_cm_certificate]({{ tf-provider-datasources-link }}/cm_certificate) | Информация о [TLS-сертификате](./concepts/index.md#types) |
| [yandex_cm_certificate_content]({{ tf-provider-datasources-link }}/cm_certificate_content) | Содержимое TLS-сертификата |