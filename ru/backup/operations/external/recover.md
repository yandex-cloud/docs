---
title: Как восстановить внешний ресурс из резервной копии
description: Следуя данной инструкции, вы сможете восстановить из резервной копии виртуальную машину или сервер, расположенные за пределами инфраструктуры {{ yandex-cloud }}.
---

# Восстановить внешнюю виртуальную машину или сервер из резервной копии


{% note info %}

{% include [vm-and-bms-backup-incompatibility](../../../_includes/backup/vm-and-bms-backup-incompatibility.md) %}

{% endnote %}

{% include [avoid-errors-when-restoring-from-backup.md](../../../_includes/backup/avoid-errors-when-restoring-from-backup.md) %}

Чтобы восстановить из резервной копии виртуальную машину или сервер, расположенные в вашей инфраструктуре или инфраструктуре стороннего провайдера:

1. [Запустите процесс восстановления на стороне {{ yandex-cloud }}](#initiate-recovery).
1. [Убедитесь в наличии сетевого доступа на стороне восстанавливаемого ресурса](#validate-access).

## Запустите процесс восстановления на стороне {{ yandex-cloud }} {#initiate-recovery}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится резервная копия.
  1. [Перейдите]({{ link-console-main }}/link/backup) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева выберите ![backups](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.label_backups }}**.
  1. В зависимости от типа ресурса, который вы хотите восстановить из резервной копии, откройте вкладку **{{ ui-key.yacloud.backup.label_external-vm-instances }}** или **{{ ui-key.yacloud.backup.label_external-server-instances }}**.
  1. В строке с резервной копией, из которой нужно восстановить внешнюю ВМ или сервер, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/clock-arrow-rotate-left.svg) **{{ ui-key.yacloud.backup.action_recovery }}**.
  1. В открывшемся окне **{{ ui-key.yacloud.backup.title_recovery-dialog_external }}** в поле **{{ ui-key.yacloud.backup.field_recover-to-resource }}** выберите внешний ресурс, в который будет восстановлена резервная копия.
  1. Нажмите кнопку **{{ ui-key.yacloud.backup.action_recovery-start }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для восстановления [защищаемого ресурса](../../concepts/index.md#protected-resources) из резервной копии:

      ```bash
      yc backup backups recover --help
      ```

  1. Узнайте идентификатор нужной резервной копии:

      {% include [get-backup-id](../../../_includes/backup/operations/get-backup-id.md) %}

  1. Узнайте идентификатор ресурса, который нужно восстановить:

      {% include [get-resource-ids](../../../_includes/backup/operations/get-resource-ids.md) %}

  1. Восстановите виртуальную машину или сервер из резервной копии:

      ```bash
      yc backup backups recover \
        --source-backup-id <идентификатор_резервной_копии> \
        --destination-instance-id <идентификатор_внешнего_ресурса>
      ```

      Где:

      * `--source-backup-id` — идентификатор резервной копии, из которой нужно восстановить ВМ или сервер.
      * `--destination-instance-id` — идентификатор ВМ или сервера, в которые нужно восстановить резервную копию.

      Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/backup/recover.md).

- API {#api}

  Воспользуйтесь методом REST API [startRecovery](../../backup/api-ref/Backup/startRecovery.md) для ресурса [Backup](../../backup/api-ref/Backup/index.md) или вызовом gRPC API [BackupService/StartRecovery](../../backup/api-ref/grpc/Backup/startRecovery.md).

{% endlist %}

В результате будет запущено восстановление внешнего ресурса из резервной копии.

{% note info %}

{% include [lvm-restoration-notice](../../../_includes/backup/lvm-restoration-notice.md) %}

{% endnote %}

## Убедитесь в наличии сетевого доступа на стороне восстанавливаемого ресурса {#validate-access}

Для восстановления внешних ВМ и серверов из резервных копий {{ backup-full-name }} этим ресурсам необходим доступ в интернет. В процессе восстановления внешнего ресурса из резервной копии он будет перезапущен, и на нем будет запущено средство восстановления `Recovery Bootable Media`. Убедитесь, что в этом режиме ваши ВМ или сервер имеют доступ в интернет.

При необходимости настройте сетевой доступ в средстве восстановления `Recovery Bootable Media`. Для этого:

* В меню сверху нажмите **Tools** и в зависимости от используемого интерфейса выберите `Configure network` или `Wi-Fi settings`.
* В открывшемся окне задайте необходимые настройки и убедитесь в наличии интернет-соединения.

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/vm-connection/external-resources.md)
* [{#T}](./connect.md)
* [{#T}](../policy-vm/attach-and-detach-vm.md)
* [{#T}](../backup-vm/create.md)
