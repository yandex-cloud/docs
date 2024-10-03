---
title: How to get information about a disk snapshot in {{ compute-full-name }}
---

# Getting information about a disk snapshot

{% list tabs %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing your [disk snapshot](../../concepts/snapshot.md).
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
   1. Select the disk snapshot you need.
   1. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the disk snapshot.

- CLI {#cli}

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the [CLI](../../../cli/) command to get information about a [disk snapshot](../../concepts/snapshot.md):

      ```bash
      yc compute snapshot get --help
      ```

   1. Get information about your disk snapshot by specifying its name or ID:

      ```bash
      yc compute snapshot get <disk_snapshot_name>
      ```

      Result:

      ```text
      id: fd8if7bg95dm********
      folder_id: b1gmit33ngp3********
      created_at: "2023-10-30T14:52:37Z"
      ...
        - f2e8f6be9gr1********
      status: READY
      source_disk_id: fhm0r72q6mvq********
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To get information about a [disk snapshot](../../concepts/snapshot.md) using {{ TF }}:
   1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_compute_snapshot" "my_snapshot" {
        snapshot_id = "<disk_snapshot_ID>"
      }

      output "snapshot" {
        value = data.yandex_compute_snapshot.my_snapshot.storage_size
      }
      ```

      Where:
      * `data "yandex_compute_snapshot"`: Description of the disk snapshot as a data source:
         * `snapshot_id`: Disk snapshot ID.
      * `output "snapshot"`: Output variable that contains information about the disk snapshot size:
         * `value`: Returned value.

      You can replace `storage_size` with any other parameter to get the information you need. For more information about the `yandex_compute_snapshot` data source parameters, see the [provider documentation]({{ tf-provider-datasources-link }}/datasource_compute_snapshot).
   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      snapshot = 7
      ```

- API {#api}

   To get detailed information about a [disk snapshot](../../concepts/snapshot.md), use the [get](../../api-ref/Snapshot/get.md) REST API method for the [Snapshot](../../api-ref/Snapshot/index.md) resource or the [SnapshotService/Get](../../api-ref/grpc/snapshot_service.md#Get) gRPC API call.

{% endlist %}