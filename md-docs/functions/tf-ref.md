# Справочник {{ TF }} для {{ sf-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ sf-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_function]({{ tf-provider-resources-link }}/function) | [Функция](concepts/function.md) |
| [yandex_function_iam_binding]({{ tf-provider-resources-link }}/function_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к функции |
| [yandex_function_scaling_policy]({{ tf-provider-resources-link }}/function_scaling_policy) | [Настройки масштабирования функции](concepts/function.md#scaling) |
| [yandex_function_trigger]({{ tf-provider-resources-link }}/function_trigger) | [Триггер](concepts/trigger/index.md) |

## Источники данных {#data-sources}

Для {{ sf-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_function]({{ tf-provider-datasources-link }}/function) | Информация о [функции](concepts/function.md) |
| [yandex_function_scaling_policy]({{ tf-provider-datasources-link }}/function_scaling_policy) | Информация о [настройках масштабирования функции](concepts/function.md#scaling) |
| [yandex_function_trigger]({{ tf-provider-datasources-link }}/function_trigger) | Информация о [триггере](concepts/trigger/index.md) |