---
title: Удалить правило-исключение WAF
description: Следуя данной инструкции, вы сможете удалить правило-исключение для WAF.
---

# Удалить правило-исключение WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Выберите профиль, в котором вы хотите удалить [правило-исключение](../concepts/waf.md#exclusion-rules).
  1. Перейдите на вкладку **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rules }}**.
  1. В строке с нужным правилом-исключением нажмите ![options](../../_assets/console-icons/ellipsis.svg) → ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и в описании профиля WAF `yandex_sws_waf_profile` удалите блок `exclusion_rule` с правилом-исключением WAF.

     {% cut "Пример настройки правил-исключений профиля WAF в конфигурации {{ TF }}" %}

     {% include [waf-profile-exclusion-terraform-example](../../_includes/smartwebsecurity/waf-profile-exclusion-terraform-example.md) %}

     {% endcut %}

      Подробнее о параметрах ресурса `yandex_sws_waf_profile` в [документации провайдера]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Вы можете проверить удаление ресурсов в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../waf/api-ref/WafProfile/update.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/) или вызовом gRPC API [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md).

{% endlist %}
