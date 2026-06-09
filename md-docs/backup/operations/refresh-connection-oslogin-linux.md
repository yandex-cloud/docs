# Переподключить виртуальную машину на Linux с OS Login к Cloud Backup

{% note info %}

Если вы [удалили](delete-vm.md) ВМ из Cloud Backup и хотите подключить ее к сервису заново, воспользуйтесь инструкциями:

* [Подключить виртуальную машину на Linux](connect-vm-linux.md)
* [Подключить виртуальную машину на Linux с OS Login](connect-vm-oslogin-linux.md)

{% endnote %}

{% note warning %}

При переподключении ВМ добавляется в Cloud Backup как новый ресурс. Резервные копии новой ВМ хранятся согласно привязанной [политике резервного копирования](../concepts/policy.md#retention).

Правила политики резервного копирования не действуют на резервные копии старой ВМ. Их хранение тарифицируется в соответствии с [правилами тарификации](../pricing.md#backups). Если резервные копии вам не нужны, [удалите](backup-vm/delete.md) их вручную или воспользуйтесь [массовым удалением](backup-vm/batch-delete.md).

{% endnote %}

После [восстановления одной виртуальной машины из копии другой](backup-vm/non-native-recovery.md), исходная ВМ, из которой была создана копия, становится неактуальной.

Чтобы избежать конфликтов между двумя ВМ при резервном копировании, обновите подключение неактуальной ВМ к Cloud Backup:

1. Перезапустите подключение к Cloud Backup на неактуальной ВМ:

   {% list tabs group=instructions %}

   - Yandex Cloud CLI {#cli}

     1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
     1. Посмотрите описание команды CLI для переустановки [агента Cloud Backup](../concepts/agent.md):

        ```bash
        yc backup agent reinstall --help
        ```

     1. Выполните команду:

        ```bash
        yc backup agent reinstall \
          --id <идентификатор_ВМ>
        ```

        Где `id` — уникальный идентификатор ВМ. Обязательный параметр.

        После выполнения команды появится предупреждение о переустановке агента Cloud Backup: `This command will launch commands on specified instance to reinstall backup agent via oslogin. Do you confirm this actions to be executed? [Yes/no][y/N]`. Подтвердите переустановку — в терминале введите `yes` и нажмите `Enter`. После этого запустится процесс переустановки агента Cloud Backup, который займет некоторое время.

        Результат:

        ```text
        ...
        Deleting old resource bound for instance_id epdoe4g6dbq4******** and resource_id: F07543A1-BDC1-415A-A143-C18E********
        Updating ids in Cloud Backup
        Finished
        ```

     1. (Опционально) Чтобы посмотреть логи установки агента Cloud Backup, выполните команду:

        ```bash
        yc backup agent debug-info \
          --id <идентификатор_ВМ>
        ```

   {% endlist %}

1. Убедитесь, что неактуальная ВМ удалена из списка ВМ, подключенных к Cloud Backup:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором подключен Cloud Backup.
     1. Перейдите в сервис **Cloud Backup**.
     1. На вкладке ![machines](../../_assets/console-icons/server.svg) **Виртуальные машины** проверьте, что в списке нет неактуальной ВМ с меткой ![irrelevant](../../_assets/console-icons/circle-info-fill.svg).

        Если ВМ не удалена, напротив неактуальной ВМ нажмите ![image](../../_assets/console-icons/ellipsis.svg), выберите **Удалить** и подтвердите удаление.

   {% endlist %}

1. [Привяжите](policy-vm/attach-and-detach-vm.md) ВМ к политике резервного копирования.