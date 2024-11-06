---
title: Как подключить виртуальную машину на Linux с OS Login к {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете подключить виртуальную машину на Linux с OS Login к {{ backup-name }}.
---

# Подключить виртуальную машину на Linux с OS Login к {{ backup-name }}

Вы можете создавать резервные копии [виртуальных машин](../../compute/concepts/vm.md) {{ compute-name }} c [поддерживаемыми операционными системами с OS Login на базе Linux](../concepts/vm-connection.md#linux).

{% include [requirements](../../_includes/backup/requirements.md) %}

{% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

Если вы [удалили](delete-vm.md) ВМ с OS Login из {{ backup-name }} и хотите подключить ее к сервису заново, воспользуйтесь инструкцией ниже.

Чтобы подключить виртуальную машину на Linux с OS Login к {{ backup-name }}:

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с [ролью](../security/index.md#backup-editor) `backup.editor`.
1. [Подключите](../../compute/operations/vm-control/vm-update.md) к ВМ сервисный аккаунт, созданный ранее.
1. [Настройте](../concepts/vm-connection.md#vm-network-access) сетевой доступ для ВМ.
1. Установите агента {{ backup-name }}:

   {% list tabs group=instructions %}

   - {{ yandex-cloud }} CLI {#cli}

     1. {% include [cli-install](../../_includes/cli-install.md) %}
     1. Посмотрите описание команды CLI для установки агента {{ backup-name }}:

        ```bash
        yc backup agent install --help
        ```

     1. Выполните команду:

        ```bash
        yc backup agent install \
          --id <идентификатор_ВМ> \
          --policy-ids <идентификатор_политики1>[,<идентификатор_политики2>]
        ```

        Где:

        * `id` — уникальный идентификатор ВМ. Обязательный параметр.
        * `policy-ids` — идентификаторы [политик резервного копирования](../concepts/policy.md) для присоединения к ВМ после установки агента. Необязательный параметр. Присоединение политики к ВМ — асинхронная операция, которая может занять несколько минут.

        После выполнения команды появится предупреждение об установке агента резервного копирования: `This command will launch commands on specified instance to install backup agent via oslogin. Do you confirm this actions to be executed? [Yes/no][y/N]`. Подтвердите установку — в терминале введите `yes` и нажмите `Enter`. После этого начнется установка агента, которая займет некоторое время.

        Результат:

        ```text
        ...
        Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
        ```

     1. (Опционально) Чтобы посмотреть логи установки агента {{ backup-name }}, выполните команду:

         ```bash
         yc backup agent debug-info \
           --id <идентификатор_ВМ>
         ```

   {% endlist %}

Также для подключения существующей ВМ к {{ backup-name }} вы можете [сделать](../../compute/operations/disk-control/create-snapshot.md) снимки дисков этой ВМ и [создать](../../compute/operations/vm-create/create-from-snapshots.md) новую ВМ из этих снимков, выбрав опцию резервного копирования.

#### См. также {#see-also}

* [{#T}](create-vm.md)
* [Привязать виртуальную машину к политике резервного копирования](./policy-vm/update.md#update-vm-list)
* [{#T}](./policy-vm/create.md)
* [{#T}](./backup-vm/recover.md)
