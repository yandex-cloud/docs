# Работа с резервными копиями в {{ mgl-full-name }}

{% include [mgl-backup-intro](../../../_includes/managed-gitlab/mgl-backup-intro.md) %}

Подробнее на странице [{#T}](../../concepts/backup.md).

Вы можете выполнить следующие действия:
* [{#T}](#list)
* [{#T}](#create-backup)
* [{#T}](#restore)
* [{#T}](#create-instance-from-backup)
* [{#T}](#download)
* [{#T}](#delete)

## Получить список резервных копий {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-gitlab) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса и выберите вкладку **{{ ui-key.yacloud.gitlab.title_backups }}**.

{% endlist %}

## Создать резервную копию вручную {#create-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-gitlab) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса и выберите вкладку **{{ ui-key.yacloud.gitlab.title_backups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.gitlab.action_create-backup }}**.

{% endlist %}

## Восстановить инстанс из резервной копии {#restore}

{% note warning %}

При восстановлении текущие данные инстанса будут перезаписаны.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-gitlab) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.gitlab.title_backups }}**.
  1. В строке с нужной резервной копией нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.gitlab.action_restore-backup }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.gitlab.action_restore-backup }}**.

{% endlist %}

{% note tip %}

Чтобы восстановить удаленный инстанс, обратитесь в [техническую поддержку]({{ link-console-support }}). Для него автоматически создается [резервная копия](../../concepts/backup.md), которая хранится в течение двух недель.

{% endnote %}

## Создать новый инстанс из резервной копии {#create-instance-from-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-gitlab) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя инстанса, для которого создана резервная копия, и выберите вкладку ![image](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.gitlab.title_backups }}**.
  1. В строке с нужной резервной копией нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.gitlab.action_create-instance-from-backup }}**.
  1. Укажите параметры нового инстанса.
  1. В блоке **{{ ui-key.yacloud.gitlab.label_restore-section }}** выберите, какие настройки исходного инстанса нужно восстановить:

     * **{{ ui-key.yacloud.gitlab.field_copy-object-storage }}** — подробнее на странице [{#T}](../objstorage-integration.md).
     * **{{ ui-key.yacloud.gitlab.field_copy-omniauth-config }}** — подробнее на странице [{#T}](../omniauth.md).

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Скачать резервную копию и секреты по подписанным ссылкам {#download}

{% note warning %}

Секреты {{ GL }} содержат конфиденциальные данные. Не передавайте ссылки на резервную копию и секреты третьим лицам.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-gitlab) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.gitlab.title_backups }}**.
  1. В строке с нужной резервной копией нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.gitlab.action_get-backup-link }}**.
  1. В поле **{{ ui-key.yacloud.gitlab.components.DownloadBackupModal.label_lifetime }}** укажите срок действия подписанных ссылок — от одного часа до семи дней.
  1. Нажмите **{{ ui-key.yacloud.gitlab.components.DownloadBackupModal.button_generate }}**.
  1. Скопируйте подписанные ссылки из полей **{{ ui-key.yacloud.gitlab.components.DownloadBackupModal.label_backup-link }}** и **{{ ui-key.yacloud.gitlab.components.DownloadBackupModal.label_secrets-link }}**.
  1. Перейдите по каждой скопированной ссылке, чтобы скачать файлы.

{% endlist %}

## Удалить резервную копию {#delete}

{% note warning %}

Удаленную резервную копию восстановить нельзя.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-gitlab) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.gitlab.title_backups }}**.
  1. В строке с нужной резервной копией нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.gitlab.action_delete-backup }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.gitlab.action_delete-backup }}**.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/backup.md)
* [{#T}](../objstorage-integration.md)
* [{#T}](../omniauth.md)
* [{#T}](./instance-create.md)