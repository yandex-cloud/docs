# Справочник {{ TF }} для {{ lockbox-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ lockbox-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_lockbox_secret]({{ tf-provider-resources-link }}/lockbox_secret) | [Секрет](concepts/secret.md#secret) |
| [yandex_lockbox_secret_iam_binding]({{ tf-provider-resources-link }}/lockbox_secret_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к секрету. <br>Вместо `yandex_lockbox_secret_iam_binding` рекомендуется использовать `yandex_lockbox_secret_iam_member` |
| [yandex_lockbox_secret_iam_member]({{ tf-provider-resources-link }}/lockbox_secret_iam_member) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к секрету |
| [yandex_lockbox_secret_version]({{ tf-provider-resources-link }}/lockbox_secret_version) | [Версия секрета](concepts/secret.md#version)<br> Вместо `lockbox_secret_version` рекомендуется использовать `lockbox_secret_version_hashed` |
| [yandex_lockbox_secret_version_hashed]({{ tf-provider-resources-link }}/lockbox_secret_version_hashed) | [Версия секрета](concepts/secret.md#version), хранит в состоянии {{ TF }} значения в хешированном виде. <br> Хранить данные в таком виде безопаснее, чем в открытом. <br> Может содержать не более 10 пар ключей и значений |

## Источники данных {#data-sources}

Для {{ lockbox-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_lockbox_secret]({{ tf-provider-datasources-link }}/lockbox_secret) | Информация о [секрете](concepts/secret.md#secret) |
| [yandex_lockbox_secret_version]({{ tf-provider-datasources-link }}/lockbox_secret_version) | Информация о [версии секрета](concepts/secret.md#version) |