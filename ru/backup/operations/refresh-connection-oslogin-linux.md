---
title: Как обновить подключение виртуальной машины на Linux с {{ oslogin }} к {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете обновить подключение виртуальной машины на Linux с {{ oslogin }} к {{ backup-name }}.
---

# Обновить подключение виртуальной машины на Linux с {{ oslogin }} к {{ backup-name }}

{% note info %}

Если вы [удалили](delete-vm.md) ВМ из {{ backup-name }} и хотите подключить ее к сервису заново, воспользуйтесь инструкциями:

* [Подключить виртуальную машину на Linux](connect-vm-linux.md)
* [Подключить виртуальную машину на Linux с {{ oslogin }}](connect-vm-oslogin-linux.md)

{% endnote %}

После [восстановления одной виртуальной машины из копии другой](./backup-vm/non-native-recovery.md), исходная ВМ, из которой была создана копия, становится неактуальной.

Чтобы избежать конфликтов между двумя ВМ при резервном копировании, обновите подключение неактуальной ВМ к {{ backup-name }}:

1. Перезапустите подключение к {{ backup-name }} на неактуальной ВМ:

   {% list tabs group=instructions %}

   - {{ yandex-cloud }} CLI {#cli}

     1. {% include [cli-install](../../_includes/cli-install.md) %}
     1. Посмотрите описание команды CLI для переустановки [агента {{ backup-name }}](../concepts/agent.md):

        ```bash
        yc backup agent reinstall --help
        ```

     1. Выполните команду:

        ```bash
        yc backup agent reinstall \
          --id <идентификатор_ВМ>
        ```

        Где `id` — уникальный идентификатор ВМ. Обязательный параметр.

        После выполнения команды появится предупреждение о переустановке агента {{ backup-name }}: `This command will launch commands on specified instance to reinstall backup agent via oslogin. Do you confirm this actions to be executed? [Yes/no][y/N]`. Подтвердите переустановку — в терминале введите `yes` и нажмите `Enter`. После этого запустится процесс переустановки агента {{ backup-name }}, который займет некоторое время.

        Результат:

        ```text
        ...
        Deleting old resource bound for instance_id epdoe4g6dbq4******** and resource_id: F07543A1-BDC1-415A-A143-C18E********
        Updating ids in {{ backup-name }}
        Finished
        ```

     1. (Опционально) Чтобы посмотреть логи установки агента {{ backup-name }}, выполните команду:

        ```bash
        yc backup agent debug-info \
          --id <идентификатор_ВМ>
        ```

   {% endlist %}

1. Убедитесь, что неактуальная ВМ удалена из списка ВМ, подключенных к {{ backup-name }}:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором подключен {{ backup-name }}.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
     1. На вкладке ![machines](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_instances }}** проверьте, что в списке нет неактуальной ВМ с меткой ![irrelevant](../../_assets/console-icons/circle-info-fill.svg).

        Если ВМ не удалена, напротив неактуальной ВМ нажмите ![image](../../_assets/console-icons/ellipsis.svg), выберите **{{ ui-key.yacloud.common.delete }}** и подтвердите удаление.

   {% endlist %}

1. [Привяжите](./policy-vm/attach-and-detach-vm.md) ВМ к политике резервного копирования.
