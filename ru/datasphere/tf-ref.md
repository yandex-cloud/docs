# Справочник ресурсов {{ ml-platform-full-name }} провайдера {{ TF }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). {{ TF }} и его провайдеры распространяются под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE). 

При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

Для {{ ml-platform-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_datasphere_community]({{ tf-provider-resources-link }}/datasphere_community) | [Сообщество](concepts/community.md) |
| [yandex_datasphere_community_iam_binding]({{ tf-provider-resources-link }}/datasphere_community_iam_binding) | [Роль](security/index.md#roles-list) на сообщество |
| [yandex_datasphere_project]({{ tf-provider-resources-link }}/datasphere_project) | [Проект](concepts/project.md) |
| [yandex_datasphere_project_iam_binding]({{ tf-provider-resources-link }}/datasphere_project_iam_binding) | [Роль](security/index.md#roles-list) на проект |