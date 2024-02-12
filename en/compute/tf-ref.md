# {{ TF }} provider's {{ compute-full-name }} resource reference

With [{{ TF }}](https://www.terraform.io/), you can quickly create a cloud infrastructure in {{ yandex-cloud }} and manage it using configuration files. The configuration files store the infrastructure description in the HashiCorp Configuration Language (HCL). {{ TF }} and its providers are distributed under the [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

If you change the configuration files, {{ TF }} automatically figures out which part of your configuration is already deployed and what should be added or removed.

For more information about {{ TF }}, [see the documentation](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

The following {{ TF }} provider resources are supported for {{ compute-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk) | [Disk](./concepts/disk.md) |
| [yandex_compute_disk_placement_group]({{ tf-provider-resources-link }}/compute_disk_placement_group) | [Non-replicated disk placement group](./concepts/disk-placement-group.md) |
| [yandex_compute_filesystem]({{ tf-provider-resources-link }}/compute_filesystem) | [File storage](./concepts/filesystem.md) |
| [yandex_compute_gpu_cluster]({{ tf-provider-resources-link }}/compute_gpu_cluster) | [GPU cluster](./concepts/gpus.md#gpu-clusters) |
| [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image) | [Image](./concepts/image.md) |
| [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance) | [VM instance](./concepts/vm.md) |
| [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group) | [Instance group](./concepts/instance-groups/index.md) |
| [yandex_compute_placement_group]({{ tf-provider-resources-link }}/compute_placement_group) | [VM placement group](./concepts/placement-groups.md) |
| [yandex_compute_snapshot]({{ tf-provider-resources-link }}/compute_snapshot) | [Disk snapshot](./concepts/snapshot.md) |
| [yandex_compute_snapshot_schedule]({{ tf-provider-resources-link }}/compute_snapshot_schedule) | [Disk snapshot schedule](./concepts/snapshot-schedule.md) |
