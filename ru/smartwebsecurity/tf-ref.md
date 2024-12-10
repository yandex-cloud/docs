---
title: Справочник {{ TF }} для {{ sws-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ sws-full-name }}.
---

# Справочник {{ TF }} для {{ sws-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ sws-full-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [sws_security_profile]({{ tf-provider-resources-link }}/sws_security_profile) | [Профиль безопасности](./concepts/profiles.md) |
| [sws_waf_profile]({{ tf-provider-resources-link }}/sws_waf_profile) | [Профили WAF](./concepts/waf.md) |
| [sws_advanced_rate_limiter_profile]({{ tf-provider-resources-link }}/sws_advanced_rate_limiter_profile) | [Профиль ARL](./concepts/arl.md) |

## Источники данных {#data-sources}

Для {{ sws-full-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [security_profile]({{ tf-provider-datasources-link }}/yandex_sws_security_profile) | Информация о [профиле безопасности](./concepts/profiles.md) |
| [sws_waf_profile]({{ tf-provider-datasources-link }}/sws_waf_profile) | Информация о [профиле WAF](./concepts/waf.md) |
| [sws_waf_rule_set_descriptor]({{ tf-provider-datasources-link }}/sws_waf_rule_set_descriptor) | Информация о [наборе базовых правил](./concepts/waf.md#rules-set) |
| [sws_advanced_rate_limiter_profile]({{ tf-provider-datasources-link }}/sws_advanced_rate_limiter_profile) | Информация о [профиле ARL](./concepts/arl.md) |
