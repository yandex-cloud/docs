# {{ TF }} provider's {{ managed-k8s-full-name }} resource reference

With [{{ TF }}](https://www.terraform.io/), you can quickly create a cloud infrastructure in {{ yandex-cloud }} and manage it using configuration files. The configuration files store the infrastructure description in the HashiCorp Configuration Language (HCL). {{ TF }} and its providers are distributed under the [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

If you change the configuration files, {{ TF }} automatically determines which part of your configuration is already deployed and what should be added or removed.

For more information about {{ TF }}, [see the documentation](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

The following {{ TF }} provider resources are supported for {{ managed-k8s-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_kubernetes_cluster]({{ tf-provider-resources-link }}/kubernetes_cluster) | [{{ k8s }} cluster](./concepts/index.md#kubernetes-cluster) |
| [yandex_kubernetes_node_group]({{ tf-provider-resources-link }}/kubernetes_node_group) | [Node group](./concepts/index.md#node-group) |