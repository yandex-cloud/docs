# Переподключить виртуальную машину к {{ backup-name }}

{% note info %}

Если вы [удалили](delete-vm.md) ВМ из {{ backup-name }} и хотите подключить ее к сервису заново, воспользуйтесь инструкциями:

* [Подключить виртуальную машину на Linux](connect-vm-linux.md)
* [Подключить виртуальную машину на Linux с {{ oslogin }}](connect-vm-oslogin-linux.md)
* [Подключить виртуальную машину на Windows](connect-vm-windows.md)

{% endnote %}

{% note warning %}

При переподключении ВМ добавляется в {{ backup-name }} как новый ресурс. Резервные копии новой ВМ хранятся согласно привязанной [политике резервного копирования](../concepts/policy.md#retention).

Правила политики резервного копирования не действуют на резервные копии старой ВМ. Их хранение тарифицируется в соответствии с [правилами тарификации](../pricing.md#backups). Если резервные копии вам не нужны, [удалите](backup-vm/delete.md) их вручную или воспользуйтесь [массовым удалением](backup-vm/batch-delete.md).

{% endnote %}

После [восстановления одной виртуальной машины из копии другой](backup-vm/non-native-recovery.md) исходная ВМ, из которой была создана копия, становится неактуальной. Чтобы избежать конфликтов между двумя ВМ при резервном копировании, обновите подключение неактуальной ВМ к {{ backup-name }}.

Также переподключение может помочь, когда [агент {{ backup-name }}](../concepts/agent.md) перестал работать и перешел в статус офлайн.

Чтобы переподключить виртуальную машину к {{ backup-name }}:

1. Перезапустите подключение к {{ backup-name }} на неактуальной ВМ:

    {% list tabs group=operating_system %}

    - Linux {#linux}

      1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по SSH.
      1. Установите на ВМ утилиты [jq](https://jqlang.github.io/jq/), [awk](http://awklang.org/), [curl](https://curl.se/) и [uuidgen](https://uuidgen.org/):

          {% note info %}

          Если вы используете дистрибутив, отличный от Ubuntu, установите указанные утилиты с помощью команд вашего пакетного менеджера.

          {% endnote %}

          ```bash
          sudo apt install jq -y
          sudo apt install gawk -y
          sudo apt install curl -y
          sudo apt install uuid-dev -y
          ```

          Для отдельных дистрибутивов также может потребоваться установка пакета `uuid-runtime`:

          ```bash
          sudo apt install uuid-runtime -y
          ```

      1. Выполните команду:

          ```bash
          curl 'https://{{ s3-storage-host }}/backup-distributions/agent_reinit.sh' | sudo bash
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

          {% note info %}
          
          В политиках выполнения PowerShell должен быть разрешен запуск скриптов. Если запуск запрещен, разрешите его и перезапустите PowerShell. Подробнее см. в [документации Microsoft](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).
              
          {% endnote %}

      1. Выполните команду:

          ```powershell
          . { iwr -useb https://{{ s3-storage-host }}/backup-distributions/agent_reinit.ps1 } | iex
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
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
      1. На вкладке ![machines](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_instances }}** проверьте, что в списке нет неактуальной ВМ с меткой ![irrelevant](../../_assets/console-icons/circle-info-fill.svg).

          Если ВМ не удалена, напротив неактуальной ВМ нажмите ![image](../../_assets/console-icons/ellipsis.svg), выберите **{{ ui-key.yacloud.common.delete }}** и подтвердите удаление.

    {% endlist %}

1. [Привяжите](policy-vm/attach-and-detach-vm.md) ВМ к политике резервного копирования.