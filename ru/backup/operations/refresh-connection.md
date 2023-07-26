# Обновить подключение виртуальной машины к {{ backup-name }}

После [восстановления одной виртуальной машины из копии другой](./backup-vm/non-native-recovery.md), исходная ВМ, из которой была создана копия, становится неактуальной.

Чтобы избежать конфликтов между двумя ВМ при резервном копировании, обновите подключение неактуальной ВМ к {{ backup-name }}:

{% list tabs %}

- Linux

  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по SSH.
  
  1. Установите на ВМ утилиты [jq](https://jqlang.github.io/jq/), [awk](http://awklang.org/), [curl](https://curl.se/) и [uuidgen](https://uuidgen.org/):

      {% note info %}

      Если вы используете дистрибутив, отличный от Ubuntu, установите указанные утилиты с помощью команд вашего пакетного менеджера.

      {% endnote %}
  
     ```bash
     sudo apt install jq
     sudo apt install gawk
     sudo apt install curl
     sudo apt install uuid-dev
     ```

  1. Выполните команду:

     ```bash
     curl 'https://storage.yandexcloud.net/backup-distributions/agent_reinit.sh' | sudo bash
     ```

     Результат:

     ```text
     ...
     Deleting old resource bound for instance_id epdoe4g6dbq4******** and resource_id: F07543A1-BDC1-415A-A143-C18E********
     Updating ids in {{ backup-name }}
     Finished     
     ```

  1. Отключитесь от ВМ:

      ```bash
      exit
      ```

  1. [Привяжите](./policy-vm/update.md#update-vm-list) ВМ к политике резервного копирования.

- Windows

  1. [Подключитесь](../../compute/operations/vm-connect/rdp.md) к ВМ по RDP.

  1. Запустите Windows PowerShell.

  1. Выполните команду:

     ```powershell
     . { iwr -useb https://storage.yandexcloud.net/backup-distributions/agent_reinit.ps1 } | iex
     ```
     
     Результат:
     
     ```text
     ...
     Backup agent reinit completed after 204 s!
     ```

  1. [Привяжите](./policy-vm/update.md#update-vm-list) ВМ к политике резервного копирования. 

{% endlist %}

#### См. также {#see-also}

* [{#T}](connect-vm-windows.md)
* [Привязать виртуальную машину к политике резервного копирования](./policy-vm/update.md#update-vm-list)
* [{#T}](./backup-vm/recover.md)
* [{#T}](./backup-vm/non-native-recovery.md)
* [{#T}](./backup-vm/delete.md)
* [{#T}](./policy-vm/create.md)
