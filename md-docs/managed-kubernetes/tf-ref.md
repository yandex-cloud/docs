# Справочник Terraform для Yandex Managed Service for Kubernetes

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Managed Service for Kubernetes поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_kubernetes_cluster](../terraform/resources/kubernetes_cluster.md) | [Кластер Kubernetes](concepts/index.md#kubernetes-cluster) |
| [yandex_kubernetes_node_group](../terraform/resources/kubernetes_node_group.md) | [Группа узлов](concepts/index.md#node-group) |
| [yandex_kubernetes_cluster_iam_binding](../terraform/resources/kubernetes_cluster_iam_binding.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру Kubernetes. <br>Вместо `yandex_kubernetes_cluster_iam_binding` рекомендуется использовать `yandex_kubernetes_cluster_iam_member` |
| [yandex_kubernetes_cluster_iam_member](../terraform/resources/kubernetes_cluster_iam_member.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру Kubernetes |


## Источники данных {#data-sources}

Для Managed Service for Kubernetes поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_kubernetes_cluster](../terraform/data-sources/kubernetes_cluster.md) | Информация о [кластере Kubernetes](concepts/index.md#kubernetes-cluster) |
| [yandex_kubernetes_node_group](../terraform/data-sources/kubernetes_node_group.md) | Информация о [группе узлов](concepts/index.md#node-group) |