# {{ TF }} provider's {{ iot-full-name }} resource reference

With [{{ TF }}](https://www.terraform.io/), you can quickly create a cloud infrastructure in {{ yandex-cloud }} and manage it using configuration files. The configuration files store the infrastructure description in the HashiCorp Configuration Language (HCL). {{ TF }} and its providers are distributed under the [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

If you change the configuration files, {{ TF }} automatically figures out which part of your configuration is already deployed and what should be added or removed.

For more information about {{ TF }}, [see the documentation](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

The following {{ TF }} provider resources are supported for {{ iot-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_iot_core_broker]({{ tf-provider-resources-link }}/iot_core_broker) | [Broker](./concepts/index.md#broker) |
| [yandex_iot_core_device]({{ tf-provider-resources-link }}/iot_core_device) | [Device](./concepts/index.md#device) |
| [yandex_iot_core_registry]({{ tf-provider-resources-link }}/iot_core_registry) | [Registry](./concepts/index.md#registry) |
