# Переподключить виртуальную машину к Cloud Backup

{% note info %}

Если вы [удалили](delete-vm.md) ВМ из Cloud Backup и хотите подключить ее к сервису заново, воспользуйтесь инструкциями:

* [Подключить виртуальную машину на Linux](connect-vm-linux.md)
* [Подключить виртуальную машину на Linux с OS Login](connect-vm-oslogin-linux.md)
* [Подключить виртуальную машину на Windows](connect-vm-windows.md)

{% endnote %}

После [восстановления одной виртуальной машины из копии другой](backup-vm/non-native-recovery.md), исходная ВМ, из которой была создана копия, становится неактуальной.

Чтобы избежать конфликтов между двумя ВМ при резервном копировании, обновите подключение неактуальной ВМ к Cloud Backup:

1. Перезапустите подключение к Cloud Backup на неактуальной ВМ:

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
          Updating ids in Cloud Backup
          Finished
          ```

    - Windows {#windows}

      1. [Подключитесь](../../compute/operations/vm-connect/rdp.md) к ВМ по RDP.
      1. Запустите Windows PowerShell.

          {% note info %}
          
          В политиках выполнения PowerShell должен быть разрешен запуск скриптов. Если запуск запрещен, разрешите его и перезапустите PowerShell. Подробнее см. в [документации Microsoft](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).
              
          {% endnote %}

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
1. Убедитесь, что неактуальная ВМ удалена из списка ВМ, подключенных к Cloud Backup:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором подключен Cloud Backup.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Backup**.
      1. На вкладке ![machines](../../_assets/console-icons/server.svg) **Виртуальные машины** проверьте, что в списке нет неактуальной ВМ с меткой ![irrelevant](../../_assets/console-icons/circle-info-fill.svg).

          Если ВМ не удалена, напротив неактуальной ВМ нажмите ![image](../../_assets/console-icons/ellipsis.svg), выберите **Удалить** и подтвердите удаление.

    {% endlist %}

1. [Привяжите](policy-vm/attach-and-detach-vm.md) ВМ к политике резервного копирования.