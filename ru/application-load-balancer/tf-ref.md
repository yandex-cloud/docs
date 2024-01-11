# Справочник ресурсов {{ alb-full-name }} провайдера {{ TF }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). {{ TF }} и его провайдеры распространяются под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE). 

При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

Для {{ alb-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group) | [Группа бэкендов](./concepts/backend-group.md) |
| [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router) | [HTTP-роутер](./concepts/http-router.md) |
| [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer) | [L7-балансировщик нагрузки](./concepts/application-load-balancer.md) |
| [yandex_alb_target_group]({{ tf-provider-resources-link }}/alb_target_group) | [Целевая группа](./concepts/target-group.md) |
| [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host) | [Виртуальный хост](./concepts/http-router.md#virtual-host) |
