# Справочник ресурсов {{ vpc-full-name }} провайдера {{ TF }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). {{ TF }} и его провайдеры распространяются под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

Для {{ vpc-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_vpc_address]({{ tf-provider-resources-link }}/vpc_address) | [Адрес облачного ресурса](./concepts/address.md) |
| [yandex_vpc_default_security_group]({{ tf-provider-resources-link }}/vpc_default_security_group) | [Группа безопасности](./concepts/security-groups.md) по умолчанию |
| [yandex_vpc_gateway]({{ tf-provider-resources-link }}/vpc_gateway) | [Шлюз](./concepts/gateways.md) |
| [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network) | [Облачная сеть](./concepts/network.md#network) |
| [yandex_vpc_route_table]({{ tf-provider-resources-link }}/vpc_route_table) | [Таблица маршрутизации](./concepts/static-routes.md#rt-vpc) |
| [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group) | [Группа безопасности](./concepts/security-groups.md) |
| [yandex_vpc_security_group_rule]({{ tf-provider-resources-link }}/vpc_security_group_rule) | [Правило группы безопасности](./concepts/security-groups.md#security-groups-rules) |
| [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet) | [Подсеть](./concepts/network.md#subnet) |
