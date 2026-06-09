# Справочник {{ TF }} для {{ network-load-balancer-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ network-load-balancer-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_lb_network_load_balancer]({{ tf-provider-resources-link }}/lb_network_load_balancer) | [Сетевой балансировщик нагрузки](concepts/index.md) |
| [yandex_lb_target_group]({{ tf-provider-resources-link }}/lb_target_group) | [Целевая группа](concepts/target-resources.md) |

## Источники данных {#data-sources}

Для {{ network-load-balancer-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_lb_network_load_balancer]({{ tf-provider-datasources-link }}/lb_network_load_balancer) | Информация о [сетевом балансировщике нагрузки](concepts/index.md) |
| [yandex_lb_target_group]({{ tf-provider-datasources-link }}/lb_target_group) | Информация о [целевой группе](concepts/target-resources.md) |