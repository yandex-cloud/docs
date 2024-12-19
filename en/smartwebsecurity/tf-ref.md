---
title: '{{ TF }} reference for {{ sws-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ sws-full-name }}.
---

# {{ TF }} reference for {{ sws-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ sws-full-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource**|
| --- | --- |
| [sws_security_profile]({{ tf-provider-resources-link }}/sws_security_profile) | [Security profile](./concepts/profiles.md) |
| [sws_waf_profile]({{ tf-provider-resources-link }}/sws_waf_profile) | [WAF profiles](./concepts/waf.md) |
| [sws_advanced_rate_limiter_profile]({{ tf-provider-resources-link }}/sws_advanced_rate_limiter_profile) | [ARL profile](./concepts/arl.md) |

## Data sources {#data-sources}

{{ sws-full-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [security_profile]({{ tf-provider-datasources-link }}/yandex_sws_security_profile) | [Security profile](./concepts/profiles.md) information |
| [sws_waf_profile]({{ tf-provider-datasources-link }}/sws_waf_profile) | [WAF profile](./concepts/waf.md) information |
| [sws_waf_rule_set_descriptor]({{ tf-provider-datasources-link }}/sws_waf_rule_set_descriptor) | [Basic rule set](./concepts/waf.md#rules-set) information |
| [sws_advanced_rate_limiter_profile]({{ tf-provider-datasources-link }}/sws_advanced_rate_limiter_profile) | [ARL profile](./concepts/arl.md) information |