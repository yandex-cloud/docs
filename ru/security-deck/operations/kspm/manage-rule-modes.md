---
title: Управлять режимами работы правил контроля безопасности в модуле {{ kspm-name }}
description: Инструкция по управлению режимами работы правил контроля безопасности в модуле Контроль {{ k8s }}® ({{ kspm-name }}) в {{ sd-full-name }}.
---

# Управлять режимами работы правил контроля безопасности модуля {{ kspm-name }}

Правила контроля безопасности модуля {{ kspm-name }}, относящиеся к типу `Admission`, имеют два режима работы:

{% include [kspm-admission-modes](../../../_includes/security-deck/kspm-admission-modes.md) %}

## Включить режим {{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_enforce_ttbjL }} {#enable-enforce}

Чтобы включить для правила режим работы `{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_enforce_ttbjL }}`:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите [окружение](*workspace), в котором хотите изменить режим правила.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ k8s }}®**. В появившемся списке найдите правило типа `Admission`, режим которого вы хотите изменить. При необходимости воспользуйтесь фильтром в верхней части списка.
  1. В строке с нужным правилом нажмите **{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.label_mode_rDqYa }} : {{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_audit_jtY6w }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите `{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.action_enable_enforce_bdsK9 }}`.
  1. В открывшемся окне подтвердите включение режима блокировки.

  Аналогичным образом изменить режим работы правила вы можете на странице с подробной информацией о правиле в поле **{{ ui-key.yacloud_org.security.controls.RuleOverview.scan_kind_8Kgmz }}**.

{% endlist %}

## Включить режим {{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_audit_jtY6w }} {#enable-audit}

Чтобы включить для правила режим работы `{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_audit_jtY6w }}` (если ранее для этого правила был включен режим `{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_enforce_ttbjL }}`):

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите [окружение](*workspace), в котором хотите изменить режим правила.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ k8s }}®**. В появившемся списке найдите правило типа `Admission`, режим которого вы хотите изменить. При необходимости воспользуйтесь фильтром в верхней части списка.
  1. В строке с нужным правилом нажмите **{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.label_mode_rDqYa }} : {{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_enforce_ttbjL }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите `{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.action_disable_enforce_oYV96 }}`.
  1. В открывшемся окне подтвердите отключение режима блокировки.

  Аналогичным образом изменить режим работы правила вы можете на странице с подробной информацией о правиле в поле **{{ ui-key.yacloud_org.security.controls.RuleOverview.scan_kind_8Kgmz }}**.

{% endlist %}

## Управлять режимом блокировки с помощью исключений {#apply-exception}

При включении для правила режима `{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_enforce_ttbjL }}` этот режим по умолчанию применяется ко всем кластерам {{ k8s }}® в [окружении](*workspace).

Чтобы изменить эту логику и явным образом указать, к каким ресурсам {{ k8s }}® в окружении не будет применяться режим `{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_enforce_ttbjL }}`, создайте [исключение](*exception) для правила:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите [окружение](*workspace), в котором хотите задать исключение для правила контроля безопасности.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ k8s }}®** и в появившемся списке выберите правило типа `Admission`, для которого вы хотите создать исключение. При необходимости воспользуйтесь фильтром в верхней части списка.
  1. В открывшемся окне с информацией о правиле перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_exceptions_pHKkb }}** и нажмите **{{ ui-key.yacloud_org.security.controls.RuleExceptions.placeholder_action_t5zxy }}**.
  1. В блоке **{{ ui-key.yacloud_org.security.kspm.KspmExceptionForm.section-title_mode }}** выберите нужный режим блокировки:
  
      * `{{ ui-key.yacloud_org.security.kspm.KspmExceptionForm.title_ignore }}` — проверки на соответствие правилу для заданных в исключении ресурсов полностью отключаются, нарушения не фиксируются.
      * `{{ ui-key.yacloud_org.security.kspm.KspmExceptionForm.title_audit }}` — нарушения правила для заданных в исключении ресурсов будут фиксироваться, но развертывание нагрузок в кластерах {{ k8s }}® блокироваться не будет.
  1. В блоке **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}** укажите кластеры, для которых требуется отменить блокировку, настройте другие параметры и завершите создание исключения.

      {% note tip %}

      При необходимости воспользуйтесь инструкцией [{#T}](./manage-exceptions.md).

      {% endnote %}

{% endlist %}

[*workspace]: Окружения {{ sd-name }} позволяют более гранулярно управлять безопасностью инфраструктуры в {{ yandex-cloud }} и представляют собой контейнеры, содержащие настройки и ресурсы модулей {{ sd-name }}, перечни контролируемых ресурсов, параметры контроля и другие параметры. Подробнее читайте в разделе [{#T}](../../concepts/workspace.md).

[*exception]: В исключениях модуля {{ kspm-name }} можно указать объекты, которые будут исключены из проверки по выбранным правилам контроля. Подробнее о работе с исключениями читайте в разделе [{#T}](./manage-exceptions.md).
