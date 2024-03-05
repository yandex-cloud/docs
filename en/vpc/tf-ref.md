# {{ TF }} provider's {{ vpc-full-name }} resource reference

With [{{ TF }}](https://www.terraform.io/), you can quickly create a cloud infrastructure in {{ yandex-cloud }} and manage it using configuration files. The configuration files store the infrastructure description in the HashiCorp Configuration Language (HCL). {{ TF }} and its providers are distributed under the [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

If you change the configuration files, {{ TF }} automatically figures out which part of your configuration is already deployed and what should be added or removed.

For more information about {{ TF }}, [see the documentation](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

The following {{ TF }} provider resources are supported for {{ vpc-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_vpc_address]({{ tf-provider-resources-link }}/vpc_address) | [Cloud resource address](./concepts/address.md) |
| [yandex_vpc_default_security_group]({{ tf-provider-resources-link }}/vpc_default_security_group) | Default [security group](./concepts/security-groups.md) |
| [yandex_vpc_gateway]({{ tf-provider-resources-link }}/vpc_gateway) | [Gateway](./concepts/gateways.md) |
| [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network) | [Cloud network](./concepts/network.md#network) |
| [yandex_vpc_route_table]({{ tf-provider-resources-link }}/vpc_route_table) | [Route table](./concepts/static-routes.md#rt-vpc) |
| [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group) | [Security group](./concepts/security-groups.md) |
| [yandex_vpc_security_group_rule]({{ tf-provider-resources-link }}/vpc_security_group_rule) | [Security group rule](./concepts/security-groups.md#security-groups-rules) |
| [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet) | [Subnet](./concepts/network.md#subnet) |
