# Справочник ресурсов {{ resmgr-full-name }} провайдера {{ TF }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). {{ TF }} и его провайдеры распространяются под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

Для {{ resmgr-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_resourcemanager_cloud]({{ tf-provider-resources-link }}/resourcemanager_cloud) | [Облако](./concepts/resources-hierarchy.md#cloud) |
| [yandex_resourcemanager_cloud_iam_binding]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_binding) | [Роль](./security/index.md#roles-list) на облако |
| [yandex_resourcemanager_cloud_iam_member]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_member) | [Роль](./security/index.md#roles-list) на облако |
| [yandex_resourcemanager_folder]({{ tf-provider-resources-link }}/resourcemanager_folder) | [Каталог](./concepts/resources-hierarchy.md#folder) |
| [yandex_resourcemanager_folder_iam_binding]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_binding) | [Роль](./security/index.md#roles-list) на каталог |
| [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member) | [Роль](./security/index.md#roles-list) на каталог |
| [yandex_resourcemanager_folder_iam_policy]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_policy) | Политика доступа каталога |
