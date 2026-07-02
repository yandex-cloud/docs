[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for GitLab](../../index.md) > [Пошаговые инструкции](../index.md) > Управление резервными копиями

# Управление резервными копиями

Вы можете создавать [резервные копии](../../concepts/backup.md) инстансов вручную.

## Получить список резервных копий {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Managed Service for&nbsp;GitLab**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../../_assets/console-icons/archive.svg) **Резервные копии**.

{% endlist %}

## Создать резервную копию {#create-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Managed Service for&nbsp;GitLab**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../../_assets/console-icons/archive.svg) **Резервные копии**.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Создать резервную копию**.

{% endlist %}

## Восстановить инстанс из резервной копии {#restore}

Чтобы восстановить инстанс из резервной копии, обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

Таким же образом вы можете восстановить удаленный инстанс. Для него автоматически создается [резервная копия](../../concepts/backup.md), которая хранится в течение двух недель.