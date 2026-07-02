[Документация Yandex Cloud](../index.md) > [Yandex Smart Web Security](index.md) > Справочник Terraform

# Справочник Terraform для Yandex Smart Web Security

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Yandex Smart Web Security поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [sws_security_profile](../terraform/resources/sws_security_profile.md) | [Профиль безопасности](concepts/profiles.md) |
| [sws_waf_profile](../terraform/resources/sws_waf_profile.md) | [Профили WAF](concepts/waf.md) |
| [sws_advanced_rate_limiter_profile](../terraform/resources/sws_advanced_rate_limiter_profile.md) | [Профиль ARL](concepts/arl.md) |

## Источники данных {#data-sources}

Для Yandex Smart Web Security поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [security_profile](../terraform/data-sources/sws_security_profile.md) | Информация о [профиле безопасности](concepts/profiles.md) |
| [sws_waf_profile](../terraform/data-sources/sws_waf_profile.md) | Информация о [профиле WAF](concepts/waf.md) |
| [sws_waf_rule_set_descriptor](../terraform/data-sources/sws_waf_rule_set_descriptor.md) | Информация о [наборе базовых правил](concepts/waf.md#rules-set) |
| [sws_advanced_rate_limiter_profile](../terraform/data-sources/sws_advanced_rate_limiter_profile.md) | Информация о [профиле ARL](concepts/arl.md) |