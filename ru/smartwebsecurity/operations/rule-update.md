---
title: "Изменить правило в профиле безопасности"
description: "Следуя данной инструкции, вы сможете изменить правило в профиле безопасности."
---

# Изменить правило в профиле безопасности

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить [правило](../concepts/rules.md) в [профиле безопасности](../concepts/profiles.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Выберите профиль, в котором вы хотите изменить правило.
  1. На вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** напротив правила, параметры которого вы хотите изменить, нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените основные параметры правила:
      * **{{ ui-key.yacloud.common.name }}**.
      * **{{ ui-key.yacloud.common.description }}**.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** правила.

        {% include [preconfigured-rules-priority](../../_includes/smartwebsecurity/preconfigured-rules-priority.md) %}

      * Опцию логирования трафика без дальнейшей фильтрации (dry run).
      * Тип правила:
        * [**{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}**](../concepts/rules.md#base-rules) — правило, которое разрешает или запрещает трафик по заданным условиям.
        * [**{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}**](../concepts/rules.md#smart-protection-rules) — правило, которое отправляет трафик на автоматический анализ с помощью алгоритмов машинного обучения и поведенческого анализа. Подозрительные запросы отправляются в {{ captcha-name }} для дополнительной верификации.
      * [**{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**](../concepts/rules.md#rule-action):
        * Для базового правила: `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` или `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}` трафик, параметры которого соответствуют условиям.
        * Для правила Smart Protection:
          * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` — трафик проверяется на основе ML-моделей и поведенческого анализа. Подозрительные запросы отправляются в {{ captcha-name }}.
          * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}` — трафик проверяется на основе ML-моделей и поведенческого анализа. Подозрительные запросы блокируются.
  1. В поле **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** и дополнительных полях ниже измените условия, которым должен соответствовать трафик, чтобы попасть под действие правила. Подробнее см. [Условия действия правила](../concepts/conditions.md).
      
      Вы можете задать несколько условий одного типа. Для разных типов условий действуют разные логические операторы: _и_ или _или_. Чтобы добавить более одного условия определенного типа нажмите кнопки ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.overview.condition_and }}** или ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.overview.condition_or }}**.

      Чтобы удалить условие, нажмите кнопку ![options](../../_assets/console-icons/trash-bin.svg).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}

### См. также {#see-also}

* [{#T}](rule-delete.md)
