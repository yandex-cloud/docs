# Ограничить использование оперативной памяти агентом Cloud Backup


Для ускорения [резервного копирования](backup-vm/create.md) данных и их [восстановления](backup-vm/recover.md) из резервных копий [агент Cloud Backup](../concepts/agent.md) может потреблять значительные объемы оперативной памяти (RAM) защищаемого ресурса — [виртуальной машины](../../compute/concepts/vm.md) или [сервера BareMetal](../../baremetal/concepts/servers.md). При этом агент может использовать всю доступную память, что в некоторых случаях приводит к сбоям в работе других служб защищаемого ресурса и невозможности завершить процесс резервного копирования или восстановления данных.

Чтобы предотвратить возникновение таких сбоев, вы можете ограничить объем данных, кешируемых агентом в оперативной памяти.

{% note info %}

Ограничение использования оперативной памяти агентом Cloud Backup может привести к снижению скорости выполнения операций резервного копирования и восстановления данных.

{% endnote %}

Чтобы ограничить использование агентом оперативной памяти:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ или серверу BareMetal по SSH.
  1. Остановите системный процесс агента резервного копирования, выполнив в терминале команду:

      ```bash
      sudo service acronis_mms stop
      ```
  1. Откройте файл конфигурации агента:

      ```bash
      sudo nano /usr/lib/Acronis/system_libs/config
      ```

      Если файла конфигурации не существует, он будет создан.
  1. Добавьте в открытый файл конфигурации строку:

      ```text
      export A3_CACHE_SIZE=<лимит_на_объем_памяти>
      ```

      Где в переменной `A3_CACHE_SIZE` задается лимит на объем оперативной памяти, доступный агенту. Например, чтобы задать лимит в 2 ГБ, укажите `A3_CACHE_SIZE=2G` или `A3_CACHE_SIZE=2048M`.
  1. Сохраните изменения и закройте файл конфигурации.
  1. Перезапустите системный процесс агента резервного копирования:

      ```bash
      sudo systemctl restart acronis_mms
      ```

- Windows {#windows}

  1. Подключитесь к ВМ [по RDP](../../compute/operations/vm-connect/rdp.md) или к серверу BareMetal [с помощью KVM-консоли](../../baremetal/operations/servers/server-kvm.md).
  1. Запустите от имени администратора оболочку `PowerShell`.
  1. В терминале `PowerShell` выполните команду:

      ```powershell
      setx /M A3_CACHE_SIZE <лимит_на_объем_памяти>
      ```

      Где в переменной `A3_CACHE_SIZE` задается лимит на объем оперативной памяти, доступный агенту. Например, чтобы задать лимит в 2 ГБ, укажите `A3_CACHE_SIZE 2G` или `A3_CACHE_SIZE 2048M`.

      Результат:

      ```text
      SUCCESS: Specified value was saved.
      ```
  1. Перезапустите службу `Acronis Managed Machine Service`:

      1. Остановите службу:

          ```powershell
          net stop MMS
          ```

          Результат:

          ```text
          The Acronis Managed Machine Service service is stopping..
          The Acronis Managed Machine Service service was stopped successfully.
          ```
      1. Повторно запустите службу:

          ```powershell
          net start MMS
          ```

          Результат:

          ```text
          The Acronis Managed Machine Service service is starting.
          The Acronis Managed Machine Service service was started successfully.
          ```

{% endlist %}


#### См. также {#see-also}

* [Агент Cloud Backup](../concepts/agent.md)
* [Создать виртуальную машину на Linux с подключением к Cloud Backup](create-vm.md)
* [Создать виртуальную машину Windows Server с подключением к Cloud Backup](create-vm-windows.md)
* [Арендовать сервер Yandex BareMetal с подключением к Cloud Backup](backup-baremetal/lease-server-with-backup.md)