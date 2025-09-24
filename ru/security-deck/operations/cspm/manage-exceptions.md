---
title: Управлять исключениями из правил контроля безопасности модуля {{ cspm-name }} в {{ sd-full-name }}
description: В данном разделе вы узнаете, как в модуле Контроль конфигурации ({{ cspm-name }}) {{ sd-full-name }} можно создавать, изменять и удалять исключения из правил.
---

# Управлять исключениями из правил контроля безопасности модуля {{ cspm-name }}

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% include [cspm-use-in-workspaces](../../../_includes/security-deck/cspm-use-in-workspaces.md) %}

[Исключения](../../concepts/cspm.md#exceptions) из [правил](../../concepts/cspm.md#rules) контроля безопасности модуля {{ cspm-name }} позволяют гибко настраивать, когда и для каких объектов нужно игнорировать результаты проверки на соответствие правилам.

## Посмотреть список исключений {#view-exceptions-list}

Чтобы посмотреть список действующих для [окружения](../../concepts/workspace.md) исключений из правил контроля безопасности модуля {{ cspm-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите [окружение](../../concepts/workspace.md), для которого хотите посмотреть информацию об исключениях из правил контроля. При необходимости воспользуйтесь поиском.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}**.

      Список исключений для правил модуля {{ cspm-name }} приведен в блоке **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.header_caption_cspm_9dTJt }}** и содержит следующие поля:

      * **{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_reason_qN8a7 }}** — указанная пользователем при создании причина исключения.
      * **{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_type_kCG8J }}** — вариант действия для создаваемого исключения:

          * `{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_type_manual_mbKxp }}` — при соответствии заданным в исключении условиям ресурс будет генерировать только сигналы о соответствии правилу.
          * `{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_type_exclude_cigcD }}` — при соответствии заданным в исключении условиям ресурс не будет генерировать никакие сигналы: ни о соответствии, ни о нарушении правила.
      * **{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_rules_vBK4W }}** — количество правил, проверка на соответствие с которыми исключена. Чтобы посмотреть подробный список исключаемых правил, нажмите на строку с исключением.
      * **{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_author_8hf4z }}** — информация о пользователе, создавшем исключение, а также о дате и времени создания.

{% endlist %}

## Создать исключение {#create-exception}

Чтобы создать новое исключение для правил контроля безопасности модуля {{ cspm-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите [окружение](../../concepts/workspace.md), в котором вы хотите создать исключение из правил контроля. При необходимости воспользуйтесь поиском.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}**.
  1. В правом верхнем углу экрана нажмите кнопку **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите `{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.scope_filter_header_7CrSm }}`. В открывшемся окне:

      1. В блоке **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.info_type_1dxbZ }}** выберите вариант действия для создаваемого исключения:

          {% include [cspm-exception-types](../../../_includes/security-deck/cspm-exception-types.md) %}

      1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}** укажите ресурсы, которые требуется исключить при проверке правил модуля {{ cspm-name }}:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.allResources_2ax5E }}` — чтобы исключить из проверки все ресурсы, контролируемые в [окружении](../../concepts/workspace.md).
          * `Выбранные ресурсы` — чтобы исключить из проверки только часть ресурсов. Чтобы выбрать ресурсы, исключаемые из проверки:

              * Нажмите кнопку ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.selectResources_bD5MC }}**.
              * В открывшемся окне выберите ресурсы, исключаемые из правила, и нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
      1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}** выберите правила модуля {{ cspm-name }}, для которых не должны проводиться проверки выбранных ресурсов:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}` — чтобы исключить для выбранных ресурсов проверку на соответствие всем правилам модуля {{ cspm-name }}.
          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}` — чтобы исключить для выбранных ресурсов проверку на соответствие заданному набору правил. Чтобы выбрать правила, проверка на соответствие которым будет отключена в соответствии с создаваемым исключением:

              * Нажмите кнопку ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.action_select-rules }}**.
              * В открывшемся окне выберите правила, проверку на соответствие которым вы хотите исключить. При необходимости воспользуйтесь фильтром или поиском в верхней части окна.
              * Нажмите кнопку **Сохранить выбор**.
      1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}** в свободной форме укажите причину, по которой вы создаете исключение.
      1. Нажмите кнопку **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}**

{% endlist %}

В результате созданное исключение отобразится в блоке **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.header_caption_cspm_9dTJt }}** на вкладке **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** страницы **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}**.

## Удалить исключение {#delete-exception}

Чтобы удалить исключение для правил контроля безопасности модуля {{ cspm-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите [окружение](../../concepts/workspace.md), в котором вы хотите удалить исключение из правил контроля. При необходимости воспользуйтесь поиском.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}**.
  1. В блоке **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.header_caption_cspm_9dTJt }}** в строке с исключением, которое вы хотите удалить, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

В результате исключение будет удалено из [окружения](../../concepts/workspace.md), а заданные им ограничения для проверок на соответствие правилам будут отменены.

#### См. также {#see-also}

* [{#T}](./view-rules.md)
* [{#T}](../../concepts/cspm.md)
* [{#T}](../../concepts/workspace.md)