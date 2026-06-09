# Справочник {{ TF }} для {{ managed-k8s-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ managed-k8s-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_kubernetes_cluster]({{ tf-provider-resources-link }}/kubernetes_cluster) | [Кластер {{ k8s }}](concepts/index.md#kubernetes-cluster) |
| [yandex_kubernetes_node_group]({{ tf-provider-resources-link }}/kubernetes_node_group) | [Группа узлов](concepts/index.md#node-group) |
| [yandex_kubernetes_cluster_iam_binding]({{ tf-provider-resources-link }}/kubernetes_cluster_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру {{ k8s }}. <br>Вместо `yandex_kubernetes_cluster_iam_binding` рекомендуется использовать `yandex_kubernetes_cluster_iam_member` |
| [yandex_kubernetes_cluster_iam_member]({{ tf-provider-resources-link }}/kubernetes_cluster_iam_member) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру {{ k8s }} |


## Источники данных {#data-sources}

Для {{ managed-k8s-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_kubernetes_cluster]({{ tf-provider-datasources-link }}/kubernetes_cluster) | Информация о [кластере {{ k8s }}](concepts/index.md#kubernetes-cluster) |
| [yandex_kubernetes_node_group]({{ tf-provider-datasources-link }}/kubernetes_node_group) | Информация о [группе узлов](concepts/index.md#node-group) |