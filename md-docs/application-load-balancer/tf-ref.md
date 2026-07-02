[Документация Yandex Cloud](../index.md) > [Yandex Application Load Balancer](index.md) > Справочник Terraform

# Справочник Terraform для Yandex Application Load Balancer

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Application Load Balancer поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_alb_backend_group](../terraform/resources/alb_backend_group.md) | [Группа бэкендов](concepts/backend-group.md) |
| [yandex_alb_http_router](../terraform/resources/alb_http_router.md) | [HTTP-роутер](concepts/http-router.md) |
| [yandex_alb_load_balancer](../terraform/resources/alb_load_balancer.md) | [L7-балансировщик нагрузки](concepts/application-load-balancer.md) |
| [yandex_alb_target_group](../terraform/resources/alb_target_group.md) | [Целевая группа](concepts/target-group.md) |
| [yandex_alb_virtual_host](../terraform/resources/alb_virtual_host.md) | [Виртуальный хост](concepts/http-router.md#virtual-host) |

## Источники данных {#data-sources}

Для Application Load Balancer поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_alb_backend_group](../terraform/data-sources/alb_backend_group.md) | Информация о [группе бэкендов](concepts/backend-group.md) |
| [yandex_alb_http_router](../terraform/data-sources/alb_http_router.md) | Информация об [HTTP-роутере](concepts/http-router.md) |
| [yandex_alb_load_balancer](../terraform/data-sources/alb_load_balancer.md) | Информация об [L7-балансировщике нагрузки](concepts/application-load-balancer.md) |
| [yandex_alb_target_group](../terraform/data-sources/alb_target_group.md) | Информация о [целевой группе](concepts/target-group.md) |
| [yandex_alb_virtual_host](../terraform/data-sources/alb_virtual_host.md) | Информация о [виртуальном хосте](concepts/http-router.md#virtual-host) |