# Справочник ресурсов {{ sf-full-name }} провайдера {{ TF }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). {{ TF }} и его провайдеры распространяются под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

Для {{ sf-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_function]({{ tf-provider-resources-link }}/function) | [Функция](./concepts/function.md) |
| [yandex_function_iam_binding]({{ tf-provider-resources-link }}/function_iam_binding) | [Роль](./security/index.md#roles-list.md) на функцию |
| [yandex_function_scaling_policy]({{ tf-provider-resources-link }}/function_scaling_policy) | [Настройки масштабирования функции](./concepts/function.md#scaling) |
| [yandex_function_trigger]({{ tf-provider-resources-link }}/function_trigger) | [Триггер](./concepts/trigger/index.md) |
