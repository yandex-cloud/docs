[{{ TF }}](https://www.terraform.io/) allows you to quickly create a cloud infrastructure in {{ yandex-cloud }} and manage it using configuration files. Configuration files store the infrastructure description in the HashiCorp Configuration Language (HCL). {{ TF }} and its providers are distributed under the [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

For more information about the provider resources, see the documentation on the [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) website or the [mirror]({{ tf-docs-link }}).

If you change the configuration files, {{ TF }} automatically detects which part of your configuration is already deployed, and what should be added or removed.