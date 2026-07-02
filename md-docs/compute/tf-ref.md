[Документация Yandex Cloud](../index.md) > [Yandex Compute Cloud](index.md) > Справочник Terraform

# Справочник Terraform для Yandex Compute Cloud


[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Compute Cloud поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_compute_disk](../terraform/resources/compute_disk.md) | [Диск](concepts/disk.md) |
| [yandex_compute_disk_iam_binding](../terraform/resources/compute_disk_iam_binding.md)| [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к диску |
| [yandex_compute_disk_placement_group](../terraform/resources/compute_disk_placement_group.md) | [Группа размещения нереплицируемых дисков](concepts/disk-placement-group.md) |
| [yandex_compute_disk_placement_group_iam_binding](../terraform/resources/compute_disk_placement_group_iam_binding.md) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к группе размещения нереплицируемых дисков |
| [yandex_compute_filesystem](../terraform/resources/compute_filesystem.md) | [Файловое хранилище](concepts/filesystem.md) |
| [yandex_compute_filesystem_iam_binding](../terraform/resources/compute_filesystem_iam_binding.md) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к файловому хранилищу |
| [yandex_compute_gpu_cluster](../terraform/resources/compute_gpu_cluster.md) | [Кластер GPU](concepts/gpus.md#gpu-clusters) |
| [yandex_compute_gpu_cluster_iam_binding](../terraform/resources/compute_gpu_cluster_iam_binding.md) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру GPU |
| [yandex_compute_image](../terraform/resources/compute_image.md) | [Образ](concepts/image.md) |
| [yandex_compute_image_iam_binding](../terraform/resources/compute_image_iam_binding.md) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к образу |
| [yandex_compute_instance](../terraform/resources/compute_instance.md) | [Виртуальная машина](concepts/vm.md) |
| [yandex_compute_instance_iam_binding](../terraform/resources/compute_instance_iam_binding.md) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к виртуальной машине |
| [yandex_compute_instance_group](../terraform/resources/compute_instance_group.md) | [Группа ВМ](concepts/instance-groups/index.md) |
| [yandex_compute_placement_group](../terraform/resources/compute_placement_group.md) | [Группа размещения ВМ](concepts/placement-groups.md) |
| [yandex_compute_placement_group_iam_binding](../terraform/resources/compute_placement_group_iam_binding.md) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к группе размещения ВМ |
| [yandex_compute_snapshot](../terraform/resources/compute_snapshot.md) | [Снимок диска](concepts/snapshot.md) |
| [yandex_compute_snapshot_iam_binding](../terraform/resources/compute_snapshot_iam_binding.md) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к снимкам диска |
| [yandex_compute_snapshot_schedule](../terraform/resources/compute_snapshot_schedule.md) | [Расписание снимков диска](concepts/snapshot-schedule.md) |
| [yandex_compute_snapshot_schedule_iam_binding](../terraform/resources/compute_snapshot_schedule_iam_binding.md) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к расписанию снимков диска |

## Источники данных {#data-sources}

Для Compute Cloud поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_compute_disk](../terraform/data-sources/compute_disk.md) | Информация о [диске](concepts/disk.md) |
| [yandex_compute_disk_placement_group](../terraform/data-sources/compute_disk_placement_group.md) | Информация о [группе размещения нереплицируемых дисков](concepts/disk-placement-group.md) |
| [yandex_compute_filesystem](../terraform/data-sources/compute_filesystem.md) | Информация о [файловом хранилище](concepts/filesystem.md) |
| [yandex_compute_gpu_cluster](../terraform/data-sources/compute_gpu_cluster.md) | Информация о [кластере GPU](concepts/gpus.md#gpu-clusters) |
| [yandex_compute_image](../terraform/data-sources/compute_image.md) | Информация об [образе](concepts/image.md) |
| [yandex_compute_instance](../terraform/data-sources/compute_instance.md) | Информация о [виртуальной машине](concepts/vm.md) |
| [yandex_compute_instance_group](../terraform/data-sources/compute_instance_group.md) | Информация о [группе ВМ](concepts/instance-groups/index.md) |
| [yandex_compute_placement_group](../terraform/data-sources/compute_placement_group.md) | Информация о [группе размещения ВМ](concepts/placement-groups.md) |
| [yandex_compute_snapshot](../terraform/data-sources/compute_snapshot.md) | Информация о [снимке диска](concepts/snapshot.md) |
| [yandex_compute_snapshot_schedule](../terraform/data-sources/compute_snapshot_schedule.md) | Информация о [расписании снимков диска](concepts/snapshot-schedule.md) |