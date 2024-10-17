# Adding a disk to a placement group


{% note warning %}

Due to the technical features of the {{ yandex-cloud }} infrastructure, we cannot guarantee that you will be able to add an existing [non-replicated disk](../../concepts/disk.md#nr-disks) to a [placement group](../../concepts/disk-placement-group.md). However, you will certainly be able to [create](../disk-create/nonreplicated.md#nr-disk-in-group) a [disk](../../concepts/disk.md) directly in the group.

{% endnote %}

A non-replicated disk can only be placed in a single group and must reside in the same [availability zone](../../../overview/concepts/geo-scope.md) with this group.

To add a disk to a placement group:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you want to add a disk to a placement group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.compute.switch_placement-groups }}**.
   1. Go to the **{{ ui-key.yacloud.compute.placement-groups.label_tab-disks }}** tab.
   1. Select the placement group to add the disk to.
   1. Go to the **{{ ui-key.yacloud.compute.placement-group.switch_disks }}** panel and click ![image](../../../_assets/plus-sign.svg) **{{ ui-key.yacloud.compute.placement-group.disks.button_add-disk }}**.
   1. In the window that opens, select the disk you want to add.

      For groups with the [partition placement](../../concepts/disk-placement-group.md#partition) strategy, specify the partition number.
   1. Click **{{ ui-key.yacloud.common.add }}**.


- API {#api}

   Use the [update](../../api-ref/Disk/update.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Update](../../api-ref/grpc/Disk/update.md) gRPC API call.

   To request the list of available disks, use the [list](../../api-ref/Disk/list.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/List](../../api-ref/grpc/Disk/list.md) gRPC API call.

{% endlist %}