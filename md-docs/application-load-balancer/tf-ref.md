# Справочник {{ TF }} для {{ alb-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ alb-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group) | [Группа бэкендов](concepts/backend-group.md) |
| [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router) | [HTTP-роутер](concepts/http-router.md) |
| [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer) | [L7-балансировщик нагрузки](concepts/application-load-balancer.md) |
| [yandex_alb_target_group]({{ tf-provider-resources-link }}/alb_target_group) | [Целевая группа](concepts/target-group.md) |
| [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host) | [Виртуальный хост](concepts/http-router.md#virtual-host) |

## Источники данных {#data-sources}

Для {{ alb-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_alb_backend_group]({{ tf-provider-datasources-link }}/alb_backend_group) | Информация о [группе бэкендов](concepts/backend-group.md) |
| [yandex_alb_http_router]({{ tf-provider-datasources-link }}/alb_http_router) | Информация об [HTTP-роутере](concepts/http-router.md) |
| [yandex_alb_load_balancer]({{ tf-provider-datasources-link }}/alb_load_balancer) | Информация об [L7-балансировщике нагрузки](concepts/application-load-balancer.md) |
| [yandex_alb_target_group]({{ tf-provider-datasources-link }}/alb_target_group) | Информация о [целевой группе](concepts/target-group.md) |
| [yandex_alb_virtual_host]({{ tf-provider-datasources-link }}/alb_virtual_host) | Информация о [виртуальном хосте](concepts/http-router.md#virtual-host) |