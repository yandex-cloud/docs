---
title: Изменить правило-исключение WAF
description: Следуя данной инструкции, вы сможете изменить правило-исключение для WAF.
---

# Изменить правило-исключение WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Выберите профиль, в котором вы хотите изменить [правило-исключение](../concepts/waf.md#exclusion-rules).
  1. Перейдите на вкладку **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rules }}**.
  1. В строке с нужным правилом нажмите ![options](../../_assets/console-icons/ellipsis.svg) → ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Измените имя и описание правила-исключения.
  1. (Опционально) Включите опцию **{{ ui-key.yacloud.smart-web-security.waf.field_logging }}**, чтобы логировать факты срабатывания правил-исключений.
  1. {% include [waf-rule-rules-section](../../_includes/smartwebsecurity/waf-rule-rules-section.md) %}
  1. {% include [waf-rule-request-condition](../../_includes/smartwebsecurity/waf-rule-request-condition.md) %}
  1. {% include [waf-rule-traffic-conditions](../../_includes/smartwebsecurity/waf-rule-traffic-conditions.md) %}
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и в описании профиля WAF `yandex_sws_waf_profile` измените блок `exclusion_rule` с правилом-исключением.

     {% cut "Пример настройки правил-исключений профиля WAF в конфигурации {{ TF }}" %}

     {% include [waf-profile-exclusion-terraform-example](../../_includes/smartwebsecurity/waf-profile-exclusion-terraform-example.md) %}

     {% endcut %}

      Подробнее о параметрах ресурса `yandex_sws_waf_profile` в [документации провайдера]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Вы можете проверить изменение ресурсов в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../waf/api-ref/WafProfile/update.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/) или вызовом gRPC API [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](exclusion-rule-add.md)
* [{#T}](exclusion-rule-delete.md)
* [{#T}](configure-set-rules.md)
