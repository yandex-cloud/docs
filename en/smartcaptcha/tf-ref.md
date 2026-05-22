---
title: '{{ TF }} reference for {{ captcha-full-name }}'
description: This page lists {{ TF }} provider resources and data sources supported by {{ captcha-name }}.
---

# {{ TF }} reference for {{ captcha-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ captcha-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [smartcaptcha_captcha]({{ tf-provider-resources-link }}/smartcaptcha_captcha) | [Standard CAPTCHA](./concepts/validation.md#usual-captcha) |

## Data sources {#data-sources}

{{ captcha-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [smartcaptcha_captcha]({{ tf-provider-datasources-link }}/smartcaptcha_captcha) | [Standard CAPTCHA](./concepts/validation.md#usual-captcha) details |