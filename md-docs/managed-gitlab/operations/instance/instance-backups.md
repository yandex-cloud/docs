[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for GitLab](../../index.md) > [Пошаговые инструкции](../index.md) > Управление резервными копиями

# Работа с резервными копиями в Yandex Managed Service for GitLab

Managed Service for GitLab обеспечивает автоматическое и ручное резервное копирование [инстанса](../../concepts/index.md#instance). Вы можете восстановить инстанс или создать новый из резервной копий.

{% note warning %}

Помимо содержимого базы данных, репозиториев и вложений в резервную копию попадают секреты: SSH-ключи, токены и т. д.

{% endnote %}

Подробнее на странице [Резервные копии в Yandex Managed Service for GitLab](../../concepts/backup.md).

Вы можете выполнить следующие действия:
* [Получить список резервных копий](#list)
* [Создать резервную копию вручную](#create-backup)
* [Восстановить инстанс из резервной копии](#restore)
* [Создать новый инстанс из резервной копии](#create-instance-from-backup)
* [Скачать резервную копию и секреты по подписанным ссылкам](#download)
* [Удалить резервную копию](#delete)

## Получить список резервных копий {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-gitlab) в сервис **Managed Service for&nbsp;GitLab**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../../_assets/console-icons/archive.svg) **Резервные копии**.

{% endlist %}

## Создать резервную копию вручную {#create-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-gitlab) в сервис **Managed Service for&nbsp;GitLab**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../../_assets/console-icons/archive.svg) **Резервные копии**.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Создать резервную копию**.

{% endlist %}

## Восстановить инстанс из резервной копии {#restore}

{% note warning %}

При восстановлении текущие данные инстанса будут перезаписаны.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-gitlab) в сервис **Managed Service for&nbsp;GitLab**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../../_assets/console-icons/archive.svg) **Резервные копии**.
  1. В строке с нужной резервной копией нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Восстановить инстанс**.
  1. В открывшемся окне нажмите **Восстановить инстанс**.

{% endlist %}

{% note tip %}

Чтобы восстановить удаленный инстанс, обратитесь в [техническую поддержку](https://center.yandex.cloud/support). Для него автоматически создается [резервная копия](../../concepts/backup.md), которая хранится в течение двух недель.

{% endnote %}

## Создать новый инстанс из резервной копии {#create-instance-from-backup}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-gitlab) в сервис **Managed Service for&nbsp;GitLab**.
  1. Нажмите на имя инстанса, для которого создана резервная копия, и выберите вкладку ![image](../../../_assets/console-icons/archive.svg) **Резервные копии**.
  1. В строке с нужной резервной копией нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Создать инстанс из резервной копии**.
  1. Укажите параметры нового инстанса.
  1. В блоке **Настройки восстановления** выберите, какие настройки исходного инстанса нужно восстановить:

     * **Перенести данные из Object Storage** — подробнее на странице [Интеграция с Object Storage](../objstorage-integration.md).
     * **Перенести параметры OmniAuth** — подробнее на странице [Настройка OmniAuth](../omniauth.md).

  1. Нажмите **Создать**.

{% endlist %}

## Скачать резервную копию и секреты по подписанным ссылкам {#download}

{% note warning %}

Секреты GitLab содержат конфиденциальные данные. Не передавайте ссылки на резервную копию и секреты третьим лицам.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-gitlab) в сервис **Managed Service for&nbsp;GitLab**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../../_assets/console-icons/archive.svg) **Резервные копии**.
  1. В строке с нужной резервной копией нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Скачать резервную копию**.
  1. В поле **Время жизни** укажите срок действия подписанных ссылок — от одного часа до семи дней.
  1. Нажмите **Получить ссылку**.
  1. Скопируйте подписанные ссылки из полей **Резервная копия** и **Секреты GitLab**.
  1. Перейдите по каждой скопированной ссылке, чтобы скачать файлы.

{% endlist %}

## Удалить резервную копию {#delete}

{% note warning %}

Удаленную резервную копию восстановить нельзя.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-gitlab) в сервис **Managed Service for&nbsp;GitLab**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../../_assets/console-icons/archive.svg) **Резервные копии**.
  1. В строке с нужной резервной копией нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Удалить резервную копию**.
  1. В открывшемся окне нажмите **Удалить резервную копию**.

{% endlist %}

#### Полезные ссылки {#see-also}

* [Резервные копии в Yandex Managed Service for GitLab](../../concepts/backup.md)
* [Интеграция с Object Storage](../objstorage-integration.md)
* [Настройка OmniAuth](../omniauth.md)
* [Создание и активация инстанса Yandex Managed Service for GitLab](instance-create.md)