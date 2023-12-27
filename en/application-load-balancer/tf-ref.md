# {{ TF }} provider's {{ alb-full-name }} resource reference

With [{{ TF }}](https://www.terraform.io/), you can quickly create a cloud infrastructure in {{ yandex-cloud }} and manage it using configuration files. The configuration files store the infrastructure description in the HashiCorp Configuration Language (HCL). {{ TF }} and its providers are distributed under the [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

If you change the configuration files, {{ TF }} automatically determines which part of your configuration is already deployed and what should be added or removed.

For more information about {{ TF }}, [see the documentation](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

The following {{ TF }} provider resources are supported for {{ alb-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_alb_backend_group](https://terraform-provider.yandexcloud.net/Resources/alb_backend_group) | [Backend group](./concepts/backend-group.md) |
| [yandex_alb_http_router](https://terraform-provider.yandexcloud.net/Resources/alb_http_router) | [HTTP router](./concepts/http-router.md) |
| [yandex_alb_load_balancer](https://terraform-provider.yandexcloud.net/Resources/alb_load_balancer) | [L7 load balancer](./concepts/application-load-balancer.md) |
| [yandex_alb_target_group](https://terraform-provider.yandexcloud.net/Resources/alb_target_group) | [Target group](./concepts/target-group.md) |
| [yandex_alb_virtual_host](https://terraform-provider.yandexcloud.net/Resources/alb_virtual_host) | [Virtual host](./concepts/http-router.md#virtual-host) |
