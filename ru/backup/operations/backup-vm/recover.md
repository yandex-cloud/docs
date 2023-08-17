# Восстановить виртуальную машину из резервной копии

{% note info %}

Если текущая виртуальная машина неисправна, [создайте](../#connect-vm) новую ВМ с подключением к {{ backup-name }} и [восстановите](non-native-recovery.md) в нее резервную копию.

{% endnote %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится резервная копия.
  1. Выберите сервис **{{ backup-name }}**.
  1. Перейдите на вкладку ![backups](../../../_assets/backup/backups.svg) **Резервные копии**.
  1. Напротив резервной копии, из которой нужно восстановить ВМ, нажмите ![image](../../../_assets/options.svg) и выберите **Восстановить ВМ**.
  1. В поле **Целевая ВМ** выберите ВМ, из которой была создана резервная копия. В списке эта ВМ отмечена как `(текущая)`.
  1. Нажмите кнопку **Восстановить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для восстановления ВМ из резервной копии:

      ```bash
      yc backup backups recover --help
      ```

  1. Узнайте идентификатор нужной резервной копии:

      {% include [get-backup-id](../../../_includes/backup/operations/get-backup-id.md) %}

  1. Узнайте идентификатор ВМ, которую нужно восстановить:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

  1. Восстановите ВМ из резервной копии:

      ```bash
      yc backup backups recover \
        --source-backup-id <идентификатор_резервной_копии> \
        --destination-instance-id <идентификатор_ВМ>
      ```

      Где:

      * `--source-backup-id` — идентификатор резервной копии, из которой нужно восстановить ВМ.
      * `--destination-instance-id` — идентификатор ВМ, в которую нужно восстановить резервную копию.

      Результат:

      ```text
      ...1s...6s...11s ... 9m4s...9m9s...done (9m9s)
      ```

      Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/backup/backup/recover.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](non-native-recovery.md)