# Справочник ресурсов {{ org-full-name }} провайдера {{ TF }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). {{ TF }} и его провайдеры распространяются под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE). 

При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

Для {{ org-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_organizationmanager_group]({{ tf-provider-resources-link }}/organizationmanager_group) | [Группа пользователей](./concepts/groups.md) |
| [yandex_organizationmanager_group_iam_member]({{ tf-provider-resources-link }}/organizationmanager_group_iam_member) | [Роль](./security/index.md#roles-list) на группу пользователей |
| [yandex_organizationmanager_group_membership]({{ tf-provider-resources-link }}/organizationmanager_group_membership) | Участник группы пользователей |
| [yandex_organizationmanager_organization_iam_binding]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_binding) | [Роль](./security/index.md#roles-list) на организацию |
| [yandex_organizationmanager_organization_iam_member]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_member) | [Роль](./security/index.md#roles-list) на организацию |
| [yandex_organizationmanager_saml_federation]({{ tf-provider-resources-link }}/organizationmanager_saml_federation) | [SAML-совместимая федерация удостоверений](./concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account]({{ tf-provider-resources-link }}/organizationmanager_saml_federation_user_account) | [Федеративный пользователь](./concepts/add-federation.md#saml-authentication) |
