---
title: Как ограничить использование оперативной памяти агентом резервного копирования
description: 'Следуя данной инструкции, вы сможете настроить для агента резервного копирования ограничение на использование оперативной памяти (RAM) защищаемого ресурса: виртуальной машины или сервера {{ baremetal-name }}.'
---

# Ограничить использование оперативной памяти агентом {{ backup-name }}


{% include [agent-ram-usage-paragraph](../../_includes/backup/operations/agent-ram-usage-paragraph.md) %}

Чтобы предотвратить возникновение таких сбоев, вы можете ограничить объем данных, кешируемых агентом в оперативной памяти.

{% include [agent-ram-usage-notice](../../_includes/backup/operations/agent-ram-usage-notice.md) %}

Чтобы ограничить использование агентом оперативной памяти:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ или серверу {{ baremetal-name }} по SSH.
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

  1. Подключитесь к ВМ [по RDP](../../compute/operations/vm-connect/rdp.md) или к серверу {{ baremetal-name }} [с помощью KVM-консоли](../../baremetal/operations/servers/server-kvm.md).
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

* [{#T}](../concepts/agent.md)
* [{#T}](./create-vm.md)
* [{#T}](./create-vm-windows.md)
* [{#T}](./backup-baremetal/lease-server-with-backup.md)