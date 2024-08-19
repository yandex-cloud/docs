---
title: "Изменить правило в профиле ARL"
description: "Следуя данной инструкции, вы сможете изменить правило в профиле ARL."
---

# Изменить правило в профиле ARL

В [профиле ARL](../concepts/arl.md) можно изменить только правила ARL. Базовые [правила](../concepts/rules.md), а также правила Smart Protection и WAF [изменяются в профиле безопасности](rule-update.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится профиль ARL.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Выберите профиль, в котором вы хотите изменить правило.
  1. В строке с нужным правилом нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:
      1. Измените основные параметры правила:
          * **{{ ui-key.yacloud.common.name }}**.
          * **{{ ui-key.yacloud.common.description }}**.
          * **Приоритет** правила. Чем меньше значение параметра, тем больший приоритет у правила.
          * Настройку опции логирования без блокировки запросов (dry run).

      1. {% include [arl-rule-traffic-conditions](../../_includes/smartwebsecurity/arl-rule-traffic-conditions.md) %}

      1. Измените способ подсчета запросов и характеристики, по которым запросы будут объединяться в группы:

          {% include [arl-rule-request-count](../../_includes/smartwebsecurity/arl-rule-request-count.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.arl.label_save-rule }}**.

{% endlist %}

### См. также {#see-also}

* [{#T}](rule-delete.md)
