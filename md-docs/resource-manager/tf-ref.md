# Справочник {{ TF }} для {{ resmgr-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ resmgr-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_resourcemanager_cloud]({{ tf-provider-resources-link }}/resourcemanager_cloud) | [Облако](concepts/resources-hierarchy.md#cloud) |
| [yandex_resourcemanager_cloud_iam_binding]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к облаку. Имеет ограничение в 1000 привязок на ресурс. <br>Вместо `yandex_resourcemanager_cloud_iam_binding` рекомендуется использовать `yandex_resourcemanager_cloud_iam_member` |
| [yandex_resourcemanager_cloud_iam_member]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_member) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к облаку |
| [yandex_resourcemanager_folder]({{ tf-provider-resources-link }}/resourcemanager_folder) | [Каталог](concepts/resources-hierarchy.md#folder) |
| [yandex_resourcemanager_folder_iam_binding]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к каталогу. Имеет ограничение в 1000 привязок на ресурс. <br>Вместо `yandex_resourcemanager_folder_iam_binding` рекомендуется использовать `yandex_resourcemanager_folder_iam_member` |
| [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к каталогу |
| [yandex_resourcemanager_folder_iam_policy]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_policy) | Устанавливает политику доступа к каталогу и заменяет любую заданную политику |

## Источники данных {#data-sources}

Для {{ resmgr-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_resourcemanager_cloud]({{ tf-provider-datasources-link }}/resourcemanager_cloud) | Информация об [облаке](concepts/resources-hierarchy.md#cloud) |
| [yandex_resourcemanager_folder]({{ tf-provider-datasources-link }}/resourcemanager_folder) | Информация о [каталоге](concepts/resources-hierarchy.md#folder) |