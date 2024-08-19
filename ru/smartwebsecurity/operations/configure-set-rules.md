---
title: "Настроить набор базовых правил WAF"
description: "Следуя данной инструкции, вы сможете настроить набор базовых правил для профиля WAF."
---

# Настроить набор базовых правил WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Выберите профиль, в котором вы хотите настроить набор базовых правил.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.waf.label_action-edit-settings }}**.
  1. Установите **{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-threshold }}** — суммарную [аномальность](../concepts/waf.md#anomaly) сработавших правил, при которой запрос будет заблокирован.

      Рекомендуется начинать с порога аномальности `25` и постепенно снижать его до `5`. Чтобы снизить порог аномальности, отработайте ложные срабатывания WAF на легитимные запросы. Для этого подберите правила из базового набора и [настройте правила-исключения](exclusion-rule-add.md). 
      
      Для тестирования порогов аномальности используйте режим **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)**. Режим включается при добавлении в профиль безопасности правила WAF.

  1. Установите **{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-level }}**.

      [Уровень паранойи](../concepts/waf.md#paranoia) классифицирует правила по степени агрессивности. Чем выше уровень паранойи, тем лучше уровень защиты, но и больше вероятность ложных срабатываний WAF. 
  1. Проверьте включенные в набор правила, при необходимости включите дополнительные или уберите ненужные. При работе с правилами обращайте внимание на значение их аномальности и уровень паранойи. 

      Любое правило из набора можно сделать блокирующим. Запрос, соответствующий таком правилу, будет заблокирован независимо от установленного порога аномальности. Чтобы сделать правило блокирующим, нажмите ![image](../../_assets/console-icons/ban.svg) справа от него. Если в профиле безопасности включен режим **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)**, запросы блокироваться не будут.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.waf.label_save-settings }}**.

{% endlist %}


### См. также {#see-also}

* [{#T}](exclusion-rule-add.md)
* [{#T}](rule-add.md)
