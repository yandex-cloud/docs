# Управление резервными копиями

Вы можете создавать [резервные копии](../../concepts/backup.md) инстансов вручную.

## Получить список резервных копий {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.gitlab.title_backups }}**.

{% endlist %}

## Создать резервную копию {#create-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.gitlab.title_backups }}**.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.gitlab.action_create-backup }}**.

{% endlist %}

## Восстановить инстанс из резервной копии {#restore}

Чтобы восстановить инстанс из резервной копии, обратитесь в [техническую поддержку]({{ link-console-support }}).

Таким же образом вы можете восстановить удаленный инстанс. Для него автоматически создается [резервная копия](../../concepts/backup.md), которая хранится в течение двух недель.
