---
title: '{{ TF }} reference for {{ captcha-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ captcha-name }}.
---

# {{ TF }} reference for {{ captcha-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ captcha-name }}:

| **{{ TF }}** resource | **{{ yandex-cloud }}** resource |
| --- | --- |
| [smartcaptcha_captcha]({{ tf-provider-resources-link }}/smartcaptcha_captcha) | [Standard CAPTCHA](./concepts/validation.md#usual-captcha) |

## Data sources {#data-sources}

{{ captcha-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }}** data source | **Description** |
| --- | --- |
| [smartcaptcha_captcha]({{ tf-provider-datasources-link }}/smartcaptcha_captcha) | [Standard CAPTCHA](./concepts/validation.md#usual-captcha) information |