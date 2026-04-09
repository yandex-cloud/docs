---
title: Управление исключениями в {{ yandex-siem-full-name }}
description: Следуя данной инструкции, вы научитесь создавать, редактировать, выключать и удалять исключения в {{ yandex-siem-full-name }}.
---

# Управление исключениями

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

В этом разделе описано, как создавать исключения, управлять их параметрами и выполнять основные операции.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../../_includes/yandex-siem/before-you-begin.md) %}

## Создание исключения из правила корреляции {#create-from-rule}

Чтобы создать исключение из правила корреляции:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. В строке нужного правила нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.security.siem.action_create-exception_bLSu4 }}**.
  1. В блоке **{{ ui-key.yacloud_org.security.siem.condition_title_gAfRm }}** добавьте одну или несколько пар «ключ = значение», определяющих события, которые не должны вызывать срабатывание правила.
  1. В блоке **Параметры** заполните обязательное поле **{{ ui-key.yacloud_org.security.siem.label_name_udzhS }}**, а также при необходимости — **{{ ui-key.yacloud_org.security.siem.label_description_4xXeP }}**.
  1. Нажмите **{{ ui-key.yacloud_org.siem.SearchActionButtonBlock.save }}**.

  Привязанное правило будет заполнено автоматически.

{% endlist %}

## Создание исключения из раздела исключений {#create-from-exceptions}

Чтобы создать исключение из раздела исключений:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. Нажмите **{{ ui-key.yacloud_org.security.siem.ExceptionsPage.create-exception }}**.
  1. В открывшемся списке выберите правило корреляции, для которого создается исключение.
  1. В блоке **{{ ui-key.yacloud_org.security.siem.condition_title_gAfRm }}** добавьте одну или несколько пар «ключ = значение», определяющих события, которые не должны вызывать срабатывание правила.
  1. В блоке **Параметры** заполните обязательное поле **{{ ui-key.yacloud_org.security.siem.label_name_udzhS }}**, а также при необходимости — **{{ ui-key.yacloud_org.security.siem.label_description_4xXeP }}**.
  1. Нажмите **{{ ui-key.yacloud_org.siem.SearchActionButtonBlock.save }}**.

{% endlist %}

## Редактирование исключения {#edit}

Чтобы изменить параметры исключения:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. В строке нужного исключения нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.header_action_edit }}**.
  1. Измените нужные поля.
  1. Нажмите **{{ ui-key.yacloud_org.siem.SearchActionButtonBlock.save }}**.

{% endlist %}

## Выключение исключения {#disable}

Чтобы выключить исключение:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. В строке нужного исключения нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.security.siem.action_switch-off_kYx8w }}**.

  Выключенное исключение переходит в статус **Inactive** и перестает применяться при обработке событий.

{% endlist %}

## Сброс изменений {#reset}

Чтобы сбросить изменения исключения до последней развернутой версии:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. В строке нужного исключения нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.security.siem.action_reset-changes_eXJka }}**.

  Все несохраненные изменения будут отменены. Исключение вернется к последней развернутой конфигурации.

{% endlist %}

## Удаление исключения {#delete}

Чтобы удалить исключение:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. В строке нужного исключения нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.header_action_delete }}**.
  1. Подтвердите удаление.

  {% note warning %}

  Удаление исключения необратимо. Все настройки исключения будут удалены.

  {% endnote %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/correlation-rules.md).
* [{#T}](../correlation-rules/manage-rules.md).
* [{#T}](exceptions-list.md).
