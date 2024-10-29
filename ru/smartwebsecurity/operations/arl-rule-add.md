---
title: Добавить правило в профиль ARL
description: Следуя данной инструкции, вы сможете добавить правило в профиль ARL.
---

# Добавить правило в профиль ARL

В [профиле ARL](../concepts/arl.md) можно добавить только правила ARL. Базовые [правила](../concepts/rules.md), а также правила Smart Protection и WAF [добавляются в профиле безопасности](rule-add.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится профиль ARL.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Выберите профиль, в который вы хотите добавить правило.
  1. Нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}** и в открывшемся окне:

      {% include [add-arl-rule](../../_includes/smartwebsecurity/add-arl-rule.md) %}

{% endlist %}

### См. также {#see-also}

* [{#T}](rule-update.md)
* [{#T}](rule-delete.md)
