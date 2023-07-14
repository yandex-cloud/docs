# Удалить резервную копию

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится резервная копия.
  1. Выберите сервис **{{ backup-name }}**.
  1. Перейдите на вкладку ![backups](../../../_assets/backup/backups.svg) **Резервные копии**.
  1. Напротив резервной копии, которую нужно удалить, нажмите ![image](../../../_assets/options.svg) и выберите **Удалить**.
  1. Подтвердите удаление.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления резервной копии:

      ```bash
      yc backup backups delete --help
      ```

  1. Узнайте идентификатор резервной копии, которую нужно удалить:

      {% include [get-backup-id](../../../_includes/backup/operations/get-backup-id.md) %}

  1. Узнайте идентификатор ВМ, резервную копию которой нужно удалить:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

  1. Удалите резервную копию:

      ```bash
      yc backup backups delete \
        --backup-id <идентификатор_резервной_копии> \
        --instance-id <идентификатор_ВМ>
      ```

      Где:

      * `--backup-id` — идентификатор резервной копии, которую нужно удалить.
      * `--instance-id` — идентификатор ВМ, резервную копию которой нужно удалить.

  Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/backup/backup/delete.md).

{% endlist %}

{% note info %}

Чтобы удалить резервные копии, в каталоге должна быть хотя бы одна виртуальная машина, подключенная к сервису {{ backup-name }}. Если таких ВМ нет, [создайте](../create-vm.md) новую ВМ с подключением к {{ backup-name }} и удалите резервные копии.

{% endnote %}

