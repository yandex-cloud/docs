---
title: "Как восстановить на виртуальной машине отдельные директории и файлы"
description: "Следуя данной инструкции, вы сможете восстановить на виртуальной машине отдельные директории и файлы." 
---

# Восстановить на виртуальной машине отдельные директории и файлы

Вы можете восстановить из резервной копии отдельные файлы и директории на любую из ВМ, подключенных к {{ backup-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится резервная копия.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Перейдите на вкладку ![backups](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.label_backups }}**.
  1. Выберите резервную копию, из которой вы хотите восстановить отдельные файлы или директории.
  1. В открывшемся файловом менеджере отметьте файлы и директории, которые вы хотите восстановить.
  1. На нижней панели нажмите кнопку ![file](../../../_assets/console-icons/file-plus.svg) **{{ ui-key.yacloud.backup.action_add-to-recovery-list }}**.
  1. Последовательно добавьте в список **{{ ui-key.yacloud.component.files-recovery-container.title_recovery-container }}** все файлы и директории, которые вы хотите восстановить.
  1. Нажмите кнопку **{{ ui-key.yacloud.component.files-recovery-container.action_start-recovery }}**.
  1. В открывшемся окне:
      * Выберите ВМ, в которую вы хотите восстановить файлы и директории.

        {% note info %}

        ВМ, на которую будут восстановлены файлы и директории, должна быть [подключена](../../concepts/vm-connection.md) к {{ backup-name }}.

        {% endnote %}

      * (опционально) Укажите, нужно ли перезагрузить ВМ после восстановления.
      * Выберите один из типов расположения, в котором вы хотите восстановить файлы:
        * `{{ ui-key.yacloud.backup.files-recovery.value_location-original }}` — файлы будут восстановлены в директориях, в которых находились изначально.
        * `{{ ui-key.yacloud.backup.files-recovery.value_location-custom }}` — файлы будут восстановлены в указанную директорию.

          Для пользовательского расположения в открывшемся файловом менеджере выберите директорию, в которую вы хотите восстановить файлы. 
          
          Чтобы создать новую директорию, нажмите кнопку ![new-folder](../../../_assets/console-icons/folder-plus.svg) **{{ ui-key.yacloud.common.create }}** и задайте ее имя.

          {% note info %}

          Имя директории не должно содержать символы: `\`, `/`, `:`, `*`, `?`, `"`, `'`, `<`, `>`, `|`.

          {% endnote %}

  1. Выберите действие, которое вы хотите выполнить при совпадении имен файлов из резервной копии и файлов на ВМ:
      * `{{ ui-key.yacloud.backup.files-recovery.value_overwrite-all }}`.
      * `{{ ui-key.yacloud.backup.files-recovery.value_overwrite-older }}`.
      * `{{ ui-key.yacloud.backup.files-recovery.value_overwrite-none }}` — файлы, которых нет в исходной директории, также не будут записаны.
  1. Нажмите кнопку **{{ ui-key.yacloud.backup.action_recovery-start }}**.

  Вы можете посмотреть прогресс восстановления файлов из резервной копии на вкладке ![operations](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** в столбце **{{ ui-key.yacloud.common.operations.column_status }}**.

{% endlist %}