# Посмотреть параметры дисков и разделов в резервной копии

Чтобы избежать ошибок при восстановлении из резервной копии, перед восстановлением рекомендуется сопоставить параметры дисков и разделов резервной копии с параметрами дисков и разделов [ВМ](../../../compute/concepts/vm.md) или [сервера](../../../baremetal/concepts/servers.md) {{ baremetal-full-name }}.

{% include [baremetal-note](../../../_includes/backup/baremetal-note.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [name-format](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения параметров дисков и разделов в резервной копии:

      ```bash
      yc backup backup get --help
      ```

  1. Узнайте идентификатор нужной резервной копии:

      {% include [get-backup-id](../../../_includes/backup/operations/get-backup-id.md) %}

  1. Получите параметры дисков и разделов в резервной копии:

      ```bash
      yc backup backup get --backup-id <идентификатор_резервной_копии>
      ```

      Результат:

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

      Прежде чем восстанавливать диск из резервной копии, убедитесь, что количество, имена и размеры томов в резервной копии соответствуют таковым на целевом диске.

      Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/backup/get.md).

- API {#api}

  Чтобы посмотреть параметры дисков и разделов в резервной копии, воспользуйтесь методом REST API [get](../../backup/api-ref/Backup/get.md) для ресурса [Backup](../../backup/api-ref/Backup/index.md) или вызовом gRPC API [BackupService/Get](../../backup/api-ref/grpc/Backup/get.md).

{% endlist %}