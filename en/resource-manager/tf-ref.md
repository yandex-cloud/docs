# {{ TF }} provider's {{ resmgr-full-name }} resource reference

With [{{ TF }}](https://www.terraform.io/), you can quickly create a cloud infrastructure in {{ yandex-cloud }} and manage it using configuration files. The configuration files store the infrastructure description in the HashiCorp Configuration Language (HCL). {{ TF }} and its providers are distributed under the [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

If you change the configuration files, {{ TF }} automatically figures out which part of your configuration is already deployed and what should be added or removed.

For more information about {{ TF }}, [see the documentation](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

The following {{ TF }} provider resources are supported for {{ resmgr-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_resourcemanager_cloud]({{ tf-provider-resources-link }}/resourcemanager_cloud) | [Cloud](./concepts/resources-hierarchy.md#cloud) |
| [yandex_resourcemanager_cloud_iam_binding]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_binding) | [Role](./security/index.md#roles-list) for a cloud |
| [yandex_resourcemanager_cloud_iam_member]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_member) | [Role](./security/index.md#roles-list) for a cloud |
| [yandex_resourcemanager_folder]({{ tf-provider-resources-link }}/resourcemanager_folder) | [Folder](./concepts/resources-hierarchy.md#folder) |
| [yandex_resourcemanager_folder_iam_binding]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_binding) | [Role](./security/index.md#roles-list) for a folder |
| [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member) | [Role](./security/index.md#roles-list) for a folder |
| [yandex_resourcemanager_folder_iam_policy]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_policy) | Folder access policy |
