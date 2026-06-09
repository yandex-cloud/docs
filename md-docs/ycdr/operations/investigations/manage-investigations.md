# Управление расследованиями

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

В этом разделе описано, как создавать расследования, управлять их параметрами и выполнять основные операции.

## Перед началом работы {#before-you-begin}

Раздел {{ ycdr-name }} появится в интерфейсе {{ sd-name }} после одобрения заявки на доступ.

Для работы с расследованиями вам потребуется [роль](../../../iam/roles-reference.md#ycdr-admin) `ycdr.admin`.

## Создание расследования {#create}

Чтобы создать расследование:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ ycdr-name }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.security.ycdr.YcdrPageLayout.investigations_wYxSe }}**.
  1. Нажмите **{{ ui-key.yacloud_org.security.siem.InvestigationsPage.create-investigation_iCPUP }}**.
  1. Введите название расследования в поле заголовка.
  1. В поле **{{ ui-key.yacloud_org.security.siem.InvestigationPageLayout.fieldDescription_wiAxw }}** добавьте описание расследования.

  {% note tip %}

  Используйте понятные названия, отражающие цель расследования. Например: «Анализ неудачных входов за февраль» или «Подозрительная активность в prod-кластере».

  {% endnote %}

{% endlist %}

## Изменение расследования {#edit}

### Переименование расследования {#rename}

Чтобы переименовать расследование:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте расследование.
  1. Нажмите на название расследования в верхней части страницы.
  1. Введите новое название.
  1. Нажмите **Enter** или кликните вне поля ввода.

{% endlist %}

### Редактирование описания {#edit-description}

Чтобы изменить описание расследования:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте расследование.
  1. В блоке **{{ ui-key.yacloud_org.security.siem.InvestigationPageLayout.information_cZr8L }}** нажмите на поле **{{ ui-key.yacloud_org.security.siem.InvestigationPageLayout.fieldDescription_wiAxw }}**.
  1. Введите новое описание.
  1. Нажмите клавишу **Enter** или кликните вне поля ввода.

{% endlist %}


## Копирование расследования {#copy}

Чтобы создать копию расследования:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте расследование.
  1. В меню действий выберите **Создать копию**.
  1. Дождитесь создания копии.

  Копия расследования содержит все запросы и настройки оригинала.

{% endlist %}

## Удаление расследования {#delete}

Чтобы удалить расследование:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте расследование.
  1. В меню действий выберите **{{ ui-key.yacloud_org.security.siem.action_delete_wM5k5 }}**.
  1. Подтвердите удаление.

  {% note warning %}

  Удаление расследования необратимо. Все запросы и результаты будут удалены.

  {% endnote %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/investigations.md).
* [{#T}](../../concepts/queries.md).
* [{#T}](investigations-list.md).
* [{#T}](../queries/index.md).