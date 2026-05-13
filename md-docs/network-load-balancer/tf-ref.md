# Справочник Terraform для Yandex Network Load Balancer

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Network Load Balancer поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_lb_network_load_balancer](../terraform/resources/lb_network_load_balancer.md) | [Сетевой балансировщик нагрузки](concepts/index.md) |
| [yandex_lb_target_group](../terraform/resources/lb_target_group.md) | [Целевая группа](concepts/target-resources.md) |

## Источники данных {#data-sources}

Для Network Load Balancer поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_lb_network_load_balancer](../terraform/data-sources/lb_network_load_balancer.md) | Информация о [сетевом балансировщике нагрузки](concepts/index.md) |
| [yandex_lb_target_group](../terraform/data-sources/lb_target_group.md) | Информация о [целевой группе](concepts/target-resources.md) |