# Справочник {{ TF }} для {{ compute-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ compute-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk) | [Диск](./concepts/disk.md) |
| [yandex_compute_disk_placement_group]({{ tf-provider-resources-link }}/compute_disk_placement_group) | [Группа размещения нереплицируемых дисков](./concepts/disk-placement-group.md) |
| [yandex_compute_filesystem]({{ tf-provider-resources-link }}/compute_filesystem) | [Файловое хранилище](./concepts/filesystem.md) |
| [yandex_compute_gpu_cluster]({{ tf-provider-resources-link }}/compute_gpu_cluster) | [Кластер GPU](./concepts/gpus.md#gpu-clusters) |
| [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image) | [Образ](./concepts/image.md) |
| [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance) | [Виртуальная машина](./concepts/vm.md) |
| [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group) | [Группа ВМ](./concepts/instance-groups/index.md) |
| [yandex_compute_placement_group]({{ tf-provider-resources-link }}/compute_placement_group) | [Группа размещения ВМ](./concepts/placement-groups.md) |
| [yandex_compute_snapshot]({{ tf-provider-resources-link }}/compute_snapshot) | [Снимок диска](./concepts/snapshot.md) |
| [yandex_compute_snapshot_schedule]({{ tf-provider-resources-link }}/compute_snapshot_schedule) | [Расписание снимков диска](./concepts/snapshot-schedule.md) |

## Источники данных {#data-sources}

Для {{ compute-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_compute_disk]({{ tf-provider-datasources-link }}/datasource_compute_disk) | Информация о [диске](./concepts/disk.md) |
| [yandex_compute_disk_placement_group]({{ tf-provider-datasources-link }}/datasource_compute_disk_placement_group) | Информация о [группе размещения нереплицируемых дисков](./concepts/disk-placement-group.md) |
| [yandex_compute_filesystem]({{ tf-provider-datasources-link }}/datasource_compute_filesystem) | Информация о [файловом хранилище](./concepts/filesystem.md) |
| [yandex_compute_gpu_cluster]({{ tf-provider-datasources-link }}/datasource_compute_gpu_cluster) | Информация о [кластере GPU](./concepts/gpus.md#gpu-clusters) |
| [yandex_compute_image]({{ tf-provider-datasources-link }}/datasource_compute_image) | Информация об [образе](./concepts/image.md) |
| [yandex_compute_instance]({{ tf-provider-datasources-link }}/datasource_compute_instance) | Информация о [виртуальной машине](./concepts/vm.md) |
| [yandex_compute_instance_group]({{ tf-provider-datasources-link }}/datasource_compute_instance_group) | Информация о [группе ВМ](./concepts/instance-groups/index.md) |
| [yandex_compute_placement_group]({{ tf-provider-datasources-link }}/datasource_compute_placement_group) | Информация о [группе размещения ВМ](./concepts/placement-groups.md) |
| [yandex_compute_snapshot]({{ tf-provider-datasources-link }}/datasource_compute_snapshot) | Информация о [снимке диска](./concepts/snapshot.md) |
| [yandex_compute_snapshot_schedule]({{ tf-provider-datasources-link }}/datasource_compute_snapshot_schedule) | Информация о [расписании снимков диска](./concepts/snapshot-schedule.md) |
