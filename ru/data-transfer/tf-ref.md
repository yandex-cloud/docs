---
title: Справочник {{ TF }} для {{ data-transfer-full-name }}
description: На этой странице приведен справочник ресурсов провайдера Terraform, которые поддерживаются для сервиса {{ data-transfer-name }}.
---

# Справочник {{ TF }} для {{ data-transfer-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ data-transfer-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_datatransfer_transfer]({{ tf-provider-resources-link }}/datatransfer_transfer) | [Трансфер](concepts/index.md#transfer) |
| [yandex_datatransfer_endpoint]({{ tf-provider-resources-link }}/datatransfer_endpoint) | [Эндпоинт](concepts/index.md#endpoint) |
