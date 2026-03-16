---
title: Управление расследованиями в {{ ycdr-full-name }}
description: Следуя данной инструкции, вы научитесь создавать, изменять, копировать и удалять расследования в {{ ycdr-name }}.
---

# Управление расследованиями

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

В этом разделе описано, как создавать расследования, управлять их параметрами и выполнять основные операции.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../../_includes/ycdr/before-you-begin.md) %}

## Создание расследования {#create}

Чтобы создать расследование:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ ycdr-name }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.security.ycdr.YcdrPageLayout.investigations_wYxSe }}**.
  1. Нажмите **{{ ui-key.yacloud_org.security.ycdr.InvestigationsPage.create-investigation_iCPUP }}**.
  1. Введите название расследования в поле заголовка.
  1. В поле **{{ ui-key.yacloud_org.security.ycdr.InvestigationPageLayout.fieldDescription_wiAxw }}** добавьте описание расследования.

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
  1. В блоке **{{ ui-key.yacloud_org.security.ycdr.InvestigationPageLayout.information_cZr8L }}** нажмите на поле **{{ ui-key.yacloud_org.security.ycdr.InvestigationPageLayout.fieldDescription_wiAxw }}**.
  1. Введите новое описание.
  1. Нажмите клавишу **Enter** или кликните вне поля ввода.

{% endlist %}


## Копирование расследования {#copy}

Чтобы создать копию расследования:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте расследование.
  1. В меню действий выберите **{{ ui-key.yacloud_org.security.ycdr.InvestigationPageLayout.copy_wiAxw }}**.
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