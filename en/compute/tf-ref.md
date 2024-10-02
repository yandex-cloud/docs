---
title: "{{ TF }} reference for {{ compute-full-name }}"
description: "This page provides reference information on {{ TF }} provider resources and data sources supported for {{ compute-name }}."
---

# {{ TF }} reference for {{ compute-full-name }}


{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ compute-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk) | [Disk](./concepts/disk.md) |
| [yandex_compute_disk_iam_binding]({{ tf-provider-resources-link }}/compute_disk_iam_binding)| [Binding](../iam/concepts/access-control/index.md#access-bindings) access permissions to a disk |
| [yandex_compute_disk_placement_group]({{ tf-provider-resources-link }}/compute_disk_placement_group) | [Non-replicated disk placement group](./concepts/disk-placement-group.md) |
| [yandex_compute_disk_placement_group_iam_binding]({{ tf-provider-resources-link }}/compute_disk_placement_group_iam_binding) | [Binding](../iam/concepts/access-control/index.md#access-bindings) access permissions for a non-replicated disk placement group |
| [yandex_compute_filesystem]({{ tf-provider-resources-link }}/compute_filesystem) | [File storage](./concepts/filesystem.md) |
| [yandex_compute_filesystem_iam_binding]({{ tf-provider-resources-link }}/compute_filesystem_iam_binding) | [Binding](../iam/concepts/access-control/index.md#access-bindings) file storage access permissions |
| [yandex_compute_gpu_cluster]({{ tf-provider-resources-link }}/compute_gpu_cluster) | [GPU cluster](./concepts/gpus.md#gpu-clusters) |
| [yandex_compute_gpu_cluster_iam_binding]({{ tf-provider-resources-link }}/compute_gpu_cluster_iam_binding) | [Binding](../iam/concepts/access-control/index.md#access-bindings) GPU cluster access permissions |
| [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image) | [Image](./concepts/image.md) |
| [yandex_compute_image_iam_binding]({{ tf-provider-resources-link }}/compute_image_iam_binding) | [Binding](../iam/concepts/access-control/index.md#access-bindings) access permissions to an image |
| [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance) | [VM instance](./concepts/vm.md) |
| [yandex_compute_instance_iam_binding]({{ tf-provider-resources-link }}/compute_instance_iam_binding) | [Binding](../iam/concepts/access-control/index.md#access-bindings) VM access permissions |
| [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group) | [Instance group](./concepts/instance-groups/index.md) |
| [yandex_compute_placement_group]({{ tf-provider-resources-link }}/compute_placement_group) | [VM placement group](./concepts/placement-groups.md) |
| [yandex_compute_placement_group_iam_binding]({{ tf-provider-resources-link }}/compute_placement_group_iam_binding) | [Binding](../iam/concepts/access-control/index.md#access-bindings) VM placement group access permissions |
| [yandex_compute_snapshot]({{ tf-provider-resources-link }}/compute_snapshot) | [Disk snapshot](./concepts/snapshot.md) |
| [yandex_compute_snapshot_iam_binding]({{ tf-provider-resources-link }}/compute_snapshot_iam_binding) | [Binding](../iam/concepts/access-control/index.md#access-bindings) access permissions to snapshots |
| [yandex_compute_snapshot_schedule]({{ tf-provider-resources-link }}/compute_snapshot_schedule) | [Disk snapshot schedule](./concepts/snapshot-schedule.md) |
| [yandex_compute_snapshot_schedule_iam_binding]({{ tf-provider-resources-link }}/compute_snapshot_schedule_iam_binding) | [Binding](../iam/concepts/access-control/index.md#access-bindings) access permissions for a disk snapshot schedule |

## Data sources {#data-sources}

{{ compute-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_compute_disk]({{ tf-provider-datasources-link }}/datasource_compute_disk) | [Disk](./concepts/disk.md) information |
| [yandex_compute_disk_placement_group]({{ tf-provider-datasources-link }}/datasource_compute_disk_placement_group) | Information on a [non-replicated disk placement group](./concepts/disk-placement-group.md) |
| [yandex_compute_filesystem]({{ tf-provider-datasources-link }}/datasource_compute_filesystem) | [File storage](./concepts/filesystem.md) information |
| [yandex_compute_gpu_cluster]({{ tf-provider-datasources-link }}/datasource_compute_gpu_cluster) | [GPU cluster](./concepts/gpus.md#gpu-clusters) information |
| [yandex_compute_image]({{ tf-provider-datasources-link }}/datasource_compute_image) | [Image](./concepts/image.md) information |
| [yandex_compute_instance]({{ tf-provider-datasources-link }}/datasource_compute_instance) | [VM instance](./concepts/vm.md) information |
| [yandex_compute_instance_group]({{ tf-provider-datasources-link }}/datasource_compute_instance_group) | [Instance group](./concepts/instance-groups/index.md) information |
| [yandex_compute_placement_group]({{ tf-provider-datasources-link }}/datasource_compute_placement_group) | [VM placement group](./concepts/placement-groups.md) information |
| [yandex_compute_snapshot]({{ tf-provider-datasources-link }}/datasource_compute_snapshot) | [Disk snapshot](./concepts/snapshot.md) information |
| [yandex_compute_snapshot_schedule]({{ tf-provider-datasources-link }}/datasource_compute_snapshot_schedule) | Information on a [disk snapshot schedule](./concepts/snapshot-schedule.md) |