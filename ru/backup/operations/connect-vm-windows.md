# Подключить виртуальную машину Windows Server к {{ backup-name }}

Сервис {{ backup-name }} поддерживает резервное копирование [виртуальных машин {{ compute-name }}](../../compute/concepts/vm.md) с операционными системами Windows Server 2019 и 2022. Подробнее см. в разделе [{#T}](../concepts/vm-connection.md#os).

{% include [ask-for-turning-on](../../_includes/backup/ask-for-turning-on.md) %}

{% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

Чтобы подключить ВМ Windows к {{ backup-name }}:

1. [Подключитесь к ВМ по RDP](../../compute/operations/vm-connect/rdp.md).
1. Запустите Windows PowerShell.
1. Выполните следующую команду:

   ```powershell
   . { iwr -useb https://{{ s3-storage-host }}/backup-distributions/agent_installer.ps1 } | iex
   ```
   
   Результат:

   ```text
   ...
   Backup agent installation complete after 190 s!
   ```

После этого ВМ можно привязать к [политике резервного копирования](../concepts/policy.md).


#### См. также {#see-also}

* [{#T}](create-vm.md)
* [Привязать виртуальную машину к политике резервного копирования](./policy-vm/update.md#update-vm-list)
* [{#T}](./backup-vm/recover.md)
* [{#T}](./backup-vm/delete.md)
* [{#T}](./policy-vm/create.md)