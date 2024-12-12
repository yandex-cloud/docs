---
title: Справочник {{ TF }} для {{ captcha-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ captcha-name }}.
---

# Справочник {{ TF }} для {{ captcha-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ captcha-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [smartcaptcha_captcha]({{ tf-provider-resources-link }}/smartcaptcha_captcha) | [Обычная капча](./concepts/validation.md#usual-captcha) |

## Источники данных {#data-sources}

Для {{ captcha-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [smartcaptcha_captcha]({{ tf-provider-datasources-link }}/smartcaptcha_captcha) | Информация об [обычной капче](./concepts/validation.md#usual-captcha) |
