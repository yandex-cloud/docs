---
title: Управление правилами корреляции в {{ yandex-siem-full-name }}
description: Следуя данной инструкции, вы научитесь создавать, редактировать, выключать и удалять правила корреляции в {{ yandex-siem-full-name }}.
---

# Управление правилами корреляции

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

В этом разделе описано, как создавать правила корреляции, управлять их параметрами и выполнять основные операции.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../../_includes/yandex-siem/before-you-begin.md) %}

## Создание правила корреляции {#create}

Чтобы создать правило корреляции:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. Нажмите **{{ ui-key.yacloud_org.security.siem.CorrelationRulesPage.create-correlation-rule }}**.
  1. В поле **Условие корреляции** введите KQL-запрос. При необходимости используйте шаблоны, схему или датасеты.
  1. В блоке **Агрегация** укажите ключ агрегации и окно агрегации.
  1. В блоке **{{ ui-key.yacloud_org.security.siem.detect-overview.title-actions-on-trigger_j8dE3 }}** настройте параметры создаваемого алерта: имя, тип и классификацию.
  1. В блоке **Параметры** заполните обязательное поле **{{ ui-key.yacloud_org.security.siem.label_name_udzhS }}**, а также при необходимости — **{{ ui-key.yacloud_org.security.siem.label_description_4xXeP }}**, **{{ ui-key.yacloud_org.security.siem.CorrelationRuleTable.category }}** и **Критичность срабатывания**.
  1. Нажмите **{{ ui-key.yacloud_org.siem.SearchActionButtonBlock.save }}**.

{% endlist %}

## Редактирование правила {#edit}

Чтобы изменить параметры правила корреляции:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. В строке нужного правила нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.header_action_edit }}**.
  1. Измените нужные поля.
  1. Нажмите **{{ ui-key.yacloud_org.siem.SearchActionButtonBlock.save }}**.

{% endlist %}

## Выключение правила {#disable}

Чтобы выключить правило корреляции:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. В строке нужного правила нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.security.siem.action_switch-off_kYx8w }}**.

  Выключенное правило переходит в статус **Inactive** и перестает обрабатывать события.

{% endlist %}

## Сброс изменений {#reset}

Чтобы сбросить изменения правила до последней развернутой версии:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. В строке нужного правила нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.security.siem.action_reset-changes_eXJka }}**.

  Все несохраненные изменения будут отменены. Правило вернется к последней развернутой конфигурации.

{% endlist %}

## Удаление правила {#delete}

Удалить можно только пользовательские правила. Предустановленные правила удалить нельзя.

Чтобы удалить пользовательское правило корреляции:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. В строке нужного правила нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.header_action_delete }}**.
  1. Подтвердите удаление.

  {% note warning %}

  Удаление правила необратимо. Все настройки правила будут удалены.

  {% endnote %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/correlation-rules.md).
* [{#T}](../exceptions/manage-exceptions.md).
* [{#T}](rules-list.md).
