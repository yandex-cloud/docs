---
title: "How to get information about a disk snapshot in {{ compute-full-name }}"
---

# Getting information about a disk snapshot

{% list tabs %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing your [disk snapshot](../../concepts/snapshot.md).
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
   1. Select the snapshot you need.
   1. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the snapshot.

- CLI {#cli}

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to get information about a [disk snapshot](../../concepts/snapshot.md):

      ```bash
      yc compute snapshot get --help
      ```

   1. Get information about your disk snapshot by specifying its name or ID:

      ```bash
      yc compute snapshot get <snapshot_name>
      ```

      Result:

      ```
      id: fd8if7bg95dm********
      folder_id: b1gmit33ngp3********
      created_at: "2023-10-30T14:52:37Z"
      name: fhm0r72q6mvq********-1698677556360
      storage_size: "3779067904"
      disk_size: "34359738368"
      product_ids:
        - f2ebcrn2h53v********
        - f2e8f6be9gr1********
      status: READY
      source_disk_id: fhm0r72q6mvq********
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To get information about a [disk snapshot](../../concepts/snapshot.md) using {{ TF }}:

   1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_compute_snapshot" "my_snapshot" {
        snapshot_id = "<snapshot_ID>"
      }

      output "snapshot" {
        value = data.yandex_compute_snapshot.my_snapshot.storage_size
      }
      ```

      Where:

      * `data "yandex_compute_snapshot"`: Description of the disk snapshot as a data source:
         * `snapshot_id`: Snapshot ID.
      * `output "snapshot"`: Output variable that contains information about the snapshot size:
         * `value`: Returned value.

      You can replace `storage_size` with any other parameter to get the information you need. For more information about the `yandex_compute_snapshot` data source parameters, see the [provider documentation]({{ tf-provider-datasources-link }}/datasource_compute_snapshot).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```bash
      snapshot = {
        "created_at" = "2024-02-23T15:54:53Z"
        "description" = "my-snapshot"
        "disk_size" = 100
        "folder_id" = "b1g681qpemb4********"
        "id" = "fd8lv1k3ciui********"
        "labels" = tomap({})
        "name" = "my-disk
        "product_ids" = tolist([])
        "snapshot_id" = "fd8lv1k3ciui********"
        "source_disk_id" = "epd221eamrs7********"
        "status" = "ready"
        "storage_size" = 2
      }
      ```

- API {#api}

   To get detailed information about a [disk snapshot](../../concepts/snapshot.md), use the [get](../../api-ref/Snapshot/get.md) REST API method for the [Snapshot](../../api-ref/Snapshot/index.md) resource or the [SnapshotService/Get](../../api-ref/grpc/snapshot_service.md#Get) gRPC API call.

{% endlist %}