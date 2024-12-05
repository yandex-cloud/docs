---
title: Как обновить агент резервного копирования {{ backup-full-name }} на виртуальной машине
description: Следуя данной инструкции, вы сможете обновить агент резервного копирования {{ backup-name }} на ВМ.
---

# Обновить агент резервного копирования {{ backup-name }} на виртуальной машине

В некоторых ситуациях, чтобы обеспечить бесперебойное автоматическое резервное копирование [виртуальных машин](../../compute/concepts/vm.md) {{ compute-full-name }}, может понадобиться обновить агент резервного копирования {{ backup-name }}.

Например, такая ситуация может возникнуть при технических обновлениях на стороне [провайдера резервного копирования](../concepts/index.md#providers).

О подобных случаях {{ yandex-cloud }} заблаговременно предупреждает клиентов.

{% note info %}

Обновление агента резервного копирования не влияет на данные в существующих резервных копиях.

{% endnote %}

Чтобы обновить агент резервного копирования {{ backup-name }} на ВМ:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по SSH.
  1. В терминале выполните команду:

      ```bash
      curl -o backup\_agent\_linux\_installer.bin https://storage.yandexcloud.net/backup-distributions/backup_agent_linux_installer.bin && sudo bash ./backup\_agent\_linux\_installer.bin -a
      ```

      Результат:

      ```text
      ...
      Backup agent update completed after 204 s!
      ```

  1. Отключитесь от ВМ.

- Windows {#windows}

  1. Запустите [Windows PowerShell](https://learn.microsoft.com/ru-ru/powershell/).  
  1. Выполните команды:

      ```powershell
      Invoke-WebRequest <https://storage.yandexcloud.net/backup-distributions/backup_agent_windows_installer.exe>    -o .\\backup\_agent\_windows\_installer.exe
      
      Invoke-Expression .\\backup\_agent\_windows\_installer.exe --quiet
      ```

      Результат:

      ```text
      ...
      Backup agent update completed after 204 s!
      ```

  1. Отключитесь от ВМ.

{% endlist %}



Если по какой-либо причине обновить агент не удалось, [обратитесь]({{ link-console-support }}) в техническую поддержку.