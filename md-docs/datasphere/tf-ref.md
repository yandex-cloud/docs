# Справочник {{ TF }} для {{ ml-platform-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ ml-platform-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_datasphere_community]({{ tf-provider-resources-link }}/datasphere_community) | [Сообщество](concepts/community.md) |
| [yandex_datasphere_community_iam_binding]({{ tf-provider-resources-link }}/datasphere_community_iam_binding) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к сообществу |
| [yandex_datasphere_project]({{ tf-provider-resources-link }}/datasphere_project) | [Проект](concepts/project.md) |
| [yandex_datasphere_project_iam_binding]({{ tf-provider-resources-link }}/datasphere_project_iam_binding) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к проекту |

## Источники данных {#data-sources}

Для {{ ml-platform-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_datasphere_community]({{ tf-provider-datasources-link }}/datasphere_community) | Информация о [сообществе](concepts/community.md) |
| [yandex_datasphere_project]({{ tf-provider-datasources-link }}/datasphere_project) | Информация о [проекте](concepts/project.md) |