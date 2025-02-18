# Viewing the parameters of backup disks and partitions

To avoid errors when recovering from a backup, start by comparing the parameters of the disks and partitions of the backup against those of the [VM](../../../compute/concepts/vm.md) or {{ baremetal-full-name }} [server](../../../baremetal/concepts/servers.md).

{% include [baremetal-note](../../../_includes/backup/baremetal-note.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [name-format](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to get parameters of disks and partitions in a backup:

      ```bash
      yc backup backup get --help
      ```

  1. Get the ID of the appropriate backup:

      {% include [get-backup-id](../../../_includes/backup/operations/get-backup-id.md) %}

  1. Get the parameters of disks and partitions in the backup:

      ```bash
      yc backup backup get --backup-id <backup_ID>
      ```

      Result:

      ```text
      id: 3cafa684-a046-459f-a772-cb8f********
      vault_id: c069302c-5ed6-2a15-7844-3a6d********
      archive_id: 2f1b7059-5981-6f3c-5420-e017********
      created_at: "2024-08-19T09:38:17Z"
      last_seen_at: "2024-08-19T09:40:52Z"
      size: "2420551680"
      deduplicated_size: "5333225683"
      original_data_size: "5333225683"
      compute_instance_id: epdc87d7q49r********
      disks:
        - name: Disk 1
          size: "21474836480"
          volumes:
            - name: vda1
              size: "1048576"
              mount_strid: \archpit(3CAFA684459FA0468FCB72A7********)\disk1_part1
            - free_space: "15617032192"
              is_bootable: true
              is_system: true
              name: vda2
              size: "21472722432"
              mount_strid: \archpit(3CAFA684459FA0468FCB72A7********)\disk1_part2
      type: FULL
      resource_id: CACBB364-FBC5-42A4-83F4-BC8D********
      ```

      Before recovering a disk from the backup, make sure that the number, names, and sizes of the backup's volumes match those of the target disk.

      For more information about the command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/backup/get.md).

- API {#api}

  To view the parameters of disks and partitions in a backup, use the [get](../../backup/api-ref/Backup/get.md) REST API method for the [Backup](../../backup/api-ref/Backup/index.md) resource or the [BackupService/Get](../../backup/api-ref/grpc/Backup/get.md) gRPC API call.

{% endlist %}