---
title: Управлять исключениями из правил безопасности модуля {{ td-full-name }} ({{ td-name }}) в {{ sd-full-name }}
description: В данном разделе вы узнаете, как в модуле {{ td-full-name }} ({{ td-name }}) {{ sd-full-name }} создавать, изменять и удалять исключения из правил.
---

# Управлять исключениями из правил безопасности модуля {{ td-full-name }} ({{ td-name }})

{% include [td-use-in-workspaces](../../../_includes/security-deck/td-use-in-workspaces.md) %}

[Исключения](../../concepts/threat-detector.md#exceptions) из [правил](../../concepts/threat-detector.md#rules) контроля безопасности модуля {{ td-full-name }} позволяют гибко настраивать, когда и для каких объектов нужно игнорировать результаты проверки на соответствие правилам.

## Посмотреть список исключений {#view-exceptions-list}

Чтобы посмотреть список действующих для [окружения](../../concepts/workspace.md) исключений из правил контроля безопасности модуля {{ td-full-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md), для которого хотите посмотреть информацию об исключениях из правил контроля.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}**.

      Список исключений для правил модуля {{ td-full-name }} приведен в блоке **{{ td-full-name }}** и содержит следующие поля:

      * **{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_reason_qN8a7 }}** — указанная пользователем при создании причина исключения.
      * **{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_type_kCG8J }}** — вариант действия для создаваемого исключения:

          * `{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_type_manual_mbKxp }}` — при соответствии заданным в исключении условиям ресурс будет генерировать сигналы о соответствии правилу.
          * `{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_type_exclude_cigcD }}` — при соответствии заданным в исключении условиям ресурс не будет генерировать сигналы о соответствии проверяемых ресурсов правилу.
      * **{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_rules_vBK4W }}** — количество правил, проверка на соответствие с которыми исключена. Чтобы посмотреть подробный список исключаемых правил, нажмите на строку с исключением.
      * **{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_author_8hf4z }}** — информация о пользователе, создавшем исключение, а также о дате и времени создания.

{% endlist %}

## Создать исключение {#create-exception}

Чтобы создать новое исключение для правил контроля безопасности модуля {{ td-full-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md), в котором вы хотите создать исключение из правил контроля.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}**.
  1. В правом верхнем углу экрана нажмите кнопку **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите `{{ td-full-name }}`. В открывшемся окне:

      1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}** выберите правила модуля {{ td-full-name }}, для которых не должны проводиться проверки выбранных ресурсов:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}` — чтобы исключить для выбранных ресурсов проверку на соответствие всем правилам модуля {{ td-full-name }}.
          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}` — чтобы исключить для выбранных ресурсов проверку на соответствие заданному набору правил. Чтобы выбрать правила, проверка на соответствие которым будет отключена в соответствии с создаваемым исключением:

              * Нажмите кнопку ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.action_select-rules }}**.
              * В открывшемся окне выберите правила, проверку на соответствие которым вы хотите исключить. При необходимости воспользуйтесь фильтром или поиском в верхней части окна.
              * Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.ServiceAccountResourceSelectDialog.action_save }}**.
      1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}** укажите ресурсы, которые требуется исключить при проверке правил модуля {{ td-full-name }}:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.allResources_2ax5E }}` — чтобы исключить из проверки все ресурсы, контролируемые в [окружении](../../concepts/workspace.md).
          * `{{ ui-key.yacloud_org.security.dspm.data-sources.bXXxQ }}` — чтобы исключить из проверки только часть ресурсов. Чтобы выбрать ресурсы, исключаемые из проверки:

              * Нажмите кнопку ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.selectResources_bD5MC }}**.
              * В открывшемся окне выберите ресурсы, исключаемые из правила, и нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
      1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}** в свободной форме укажите причину, по которой вы создаете исключение.
      1. Нажмите кнопку **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}**

{% endlist %}

После завершения очередной проверки инфраструктуры созданное исключение отобразится на странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** на вкладке **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** в блоке **{{ td-full-name }}**. Периодичность возобновления проверок — 8 часов.

## Удалить исключение {#delete-exception}

Чтобы удалить исключение для правил контроля безопасности модуля {{ td-full-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md), в котором вы хотите удалить исключение из правил контроля.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}**.
  1. В блоке **{{ td-full-name }}** в строке с исключением, которое вы хотите удалить, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

Исключение будет удалено из [окружения](../../concepts/workspace.md), а заданные им ограничения для проверок на соответствие правилам будут отменены после завершения очередной проверки инфраструктуры. Периодичность возобновления проверок — 8 часов.

#### См. также {#see-also}

* [{#T}](./view-rules.md)
* [{#T}](../../concepts/threat-detector.md)
* [{#T}](../../concepts/workspace.md)