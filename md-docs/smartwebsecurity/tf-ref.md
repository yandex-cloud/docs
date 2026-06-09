# Справочник {{ TF }} для {{ sws-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ sws-full-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [sws_security_profile]({{ tf-provider-resources-link }}/sws_security_profile) | [Профиль безопасности](concepts/profiles.md) |
| [sws_waf_profile]({{ tf-provider-resources-link }}/sws_waf_profile) | [Профили WAF](concepts/waf.md) |
| [sws_advanced_rate_limiter_profile]({{ tf-provider-resources-link }}/sws_advanced_rate_limiter_profile) | [Профиль ARL](concepts/arl.md) |

## Источники данных {#data-sources}

Для {{ sws-full-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [security_profile]({{ tf-provider-datasources-link }}/sws_security_profile) | Информация о [профиле безопасности](concepts/profiles.md) |
| [sws_waf_profile]({{ tf-provider-datasources-link }}/sws_waf_profile) | Информация о [профиле WAF](concepts/waf.md) |
| [sws_waf_rule_set_descriptor]({{ tf-provider-datasources-link }}/sws_waf_rule_set_descriptor) | Информация о [наборе базовых правил](concepts/waf.md#rules-set) |
| [sws_advanced_rate_limiter_profile]({{ tf-provider-datasources-link }}/sws_advanced_rate_limiter_profile) | Информация о [профиле ARL](concepts/arl.md) |