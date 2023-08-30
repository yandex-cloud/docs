# Управление резервными копиями

Вы можете создавать [резервные копии](../../concepts/backup.md) и восстанавливать [инстансы](../../concepts/index.md) из имеющихся резервных копий.

## Получить список резервных копий {#list}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.gitlab.title_backups }}**.

{% endlist %}

## Создать резервную копию {#create-backup}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.gitlab.title_backups }}**.
  1. Нажмите кнопку ![image](../../../_assets/plus.svg) **{{ ui-key.yacloud.gitlab.action_create-backup }}**.

{% endlist %}

## Восстановить инстанс из резервной копии {#restore}

Восстанавливая инстанс из резервной копии, вы создаете новый инстанс с данными из резервной копии. Если в [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) не хватает [ресурсов](../../concepts/limits.md) для создания такого инстанса, восстановиться из резервной копии не получится.

Для восстановления инстанса из резервной копии или скачивания файлов резервных копий обратитесь в [техническую поддержку]({{ link-console-support }}).