# Справочник ресурсов {{ compute-full-name }} провайдера {{ TF }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). {{ TF }} и его провайдеры распространяются под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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
