# Обновить подключение виртуальной машины к {{ backup-name }}

{% note info %}

Если вы [удалили](delete-vm.md) ВМ из {{ backup-name }} и хотите подключить ее к сервису заново, воспользуйтесь инструкциями:

* [Подключить виртуальную машину на Linux](connect-vm-linux.md)
* [Подключить виртуальную машину на Windows](connect-vm-windows.md)

{% endnote %}

После [восстановления одной виртуальной машины из копии другой](./backup-vm/non-native-recovery.md), исходная ВМ, из которой была создана копия, становится неактуальной.

Чтобы избежать конфликтов между двумя ВМ при резервном копировании, обновите подключение неактуальной ВМ к {{ backup-name }}:

1. Перезапустите подключение к {{ backup-name }} на неактуальной ВМ:

    {% list tabs group=operating_system %}

    - Linux {#linux}

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

          Если вы используете дистрибутив Astra Linux, дополнительно установите пакет uuid-runtime:

          ```bash
          sudo apt install uuid-runtime
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

    - Windows {#windows}

      1. [Подключитесь](../../compute/operations/vm-connect/rdp.md) к ВМ по RDP.
      1. Запустите Windows PowerShell.

          {% include [ps-note](../../_includes/backup/ps-note.md) %}

      1. Выполните команду:

          ```powershell
          . { iwr -useb https://storage.yandexcloud.net/backup-distributions/agent_reinit.ps1 } | iex
          ```
     
          Результат:
     
          ```text
          ...
          Backup agent reinit completed after 204 s!
          ```

    {% endlist %}

1. Отключитесь от ВМ.
1. Убедитесь, что неактуальная ВМ удалена из списка ВМ, подключенных к {{ backup-name }}:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором подключен {{ backup-name }}.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
      1. На вкладке ![machines](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_instances }}** проверьте, что в списке нет неактуальной ВМ с меткой ![irrelevant](../../_assets/console-icons/circle-info-fill.svg).

          Если ВМ не удалена, напротив неактуальной ВМ нажмите ![image](../../_assets/console-icons/ellipsis.svg), выберите **{{ ui-key.yacloud.common.delete }}** и подтвердите удаление.

    {% endlist %}

1. [Привяжите](./policy-vm/update.md#update-vm-list) ВМ к политике резервного копирования.
