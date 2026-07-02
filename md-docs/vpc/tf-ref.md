[Документация Yandex Cloud](../index.md) > [Yandex Virtual Private Cloud](index.md) > Справочник Terraform

# Справочник Terraform для Yandex Virtual Private Cloud

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Virtual Private Cloud поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_vpc_address](../terraform/resources/vpc_address.md) | [Адрес облачного ресурса](concepts/address.md) |
| [yandex_vpc_default_security_group](../terraform/resources/vpc_default_security_group.md) | [Группа безопасности](concepts/security-groups.md) по умолчанию |
| [yandex_vpc_gateway](../terraform/resources/vpc_gateway.md) | [Шлюз](concepts/gateways.md) |
| [yandex_vpc_network](../terraform/resources/vpc_network.md) | [Облачная сеть](concepts/network.md#network) |
| [yandex_vpc_route_table](../terraform/resources/vpc_route_table.md) | [Таблица маршрутизации](concepts/routing.md#rt-vpc) |
| [yandex_vpc_security_group](../terraform/resources/vpc_security_group.md) | [Группа безопасности](concepts/security-groups.md) |
| [yandex_vpc_security_group_rule](../terraform/resources/vpc_security_group_rule.md) | [Правило группы безопасности](concepts/security-groups.md#security-groups-rules) |
| [yandex_vpc_subnet](../terraform/resources/vpc_subnet.md) | [Подсеть](concepts/network.md#subnet) |
| [yandex_vpc_private_endpoint](../terraform/resources/vpc_private_endpoint.md) | [Сервисное подключение](concepts/private-endpoint.md) |


## Источники данных {#data-sources}

Для Virtual Private Cloud поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_vpc_address](../terraform/data-sources/vpc_address.md) | Информация об [адресе облачного ресурса](concepts/address.md) |
| [yandex_vpc_gateway](../terraform/data-sources/vpc_gateway.md) | Информация о [шлюзе](concepts/gateways.md) |
| [yandex_vpc_network](../terraform/data-sources/vpc_network.md) | Информация об [облачной сети](concepts/network.md#network) |
| [yandex_vpc_route_table](../terraform/data-sources/vpc_route_table.md) | Информация о [таблице маршрутизации](concepts/routing.md#rt-vpc) |
| [yandex_vpc_security_group](../terraform/data-sources/vpc_security_group.md) | Информация о [группе безопасности](concepts/security-groups.md) |
| [yandex_vpc_security_group_rule](../terraform/data-sources/vpc_security_group_rule.md) | Информация о [правиле группы безопасности](concepts/security-groups.md#security-groups-rules) |
| [yandex_vpc_subnet](../terraform/data-sources/vpc_subnet.md) | Информация о [подсети](concepts/network.md#subnet) |
| [yandex_vpc_private_endpoint](../terraform/data-sources/vpc_private_endpoint.md) | Информация о [сервисном подключении](concepts/private-endpoint.md) |