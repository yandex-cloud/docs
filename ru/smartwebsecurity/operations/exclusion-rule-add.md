---
title: "Добавить правило-исключение WAF"
description: "Следуя данной инструкции, вы сможете создать правило-исключение для WAF."
---

# Добавить правило-исключение WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Выберите профиль, в который вы хотите добавить [правило-исключение](../concepts/waf.md#exclusion-rules).
  1. В меню слева перейдите на вкладку ![image](../../_assets/console-icons/file-xmark.svg) **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rules }}** и нажмите кнопку **{{ ui-key.yacloud.smart-web-security.waf.label_create-exclusion-rule }}**. В открывшемся окне:
      1. Введите имя правила-исключения.
      1. (опционально) Введите описание.
      1. (опционально) Включите опцию **{{ ui-key.yacloud.smart-web-security.waf.field_logging }}**, чтобы логировать факты срабатывания правил-исключений.
      1. В блоке **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-rules-section }}** выберите правила из базового набора, для которых будет срабатывать исключение:
          * `{{ ui-key.yacloud.smart-web-security.waf.value_exclude-all-yes }}` — исключение будет срабатывать для всех правил.
          * `{{ ui-key.yacloud.smart-web-security.waf.value_exclude-all-no }}` — исключение будет срабатывать для выбранных правил.

              Нажмите **{{ ui-key.yacloud.smart-web-security.waf.action_exclusion-rule-add-rules }}**, чтобы выбрать правила из базового набора.

      1. {% include [waf-rule-traffic-conditions](../../_includes/smartwebsecurity/waf-rule-traffic-conditions.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


### См. также {#see-also}

* [{#T}](configure-set-rules.md)
* [{#T}](exclusion-rule-delete.md)
* [{#T}](rule-add.md)
