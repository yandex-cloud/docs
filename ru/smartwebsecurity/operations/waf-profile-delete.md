---
title: Удалить профиль WAF
description: Следуя данной инструкции, вы сможете удалить профиль WAF.
---

# Удалить профиль WAF

Прежде чем удалить профиль WAF, удалите все правила WAF из связанных профилей безопасности.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Сохраните или запомните идентификатор профиля, который вы хотите удалить.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** и выберите [профиль безопасности](../concepts/profiles.md), в котором используется профиль WAF, который вы хотите удалить.
  1. На вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** удалите правила профиля WAF:

     1. В фильтре **{{ ui-key.yacloud.smart-web-security.label_search-rule-type }}** выберите `{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}`.
     1. В строке с правилом, которое относится к профилю WAF с нужным идентификатором, нажмите ![options](../../_assets/console-icons/ellipsis.svg) → ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
     1. Подтвердите удаление.

  1. Таким же способом удалите правила WAF из всех связанных профилей безопасности.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. В строке с нужным профилем нажмите ![options](../../_assets/console-icons/ellipsis.svg) → ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить профиль WAF {{ sws-full-name }}, который вы создали с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием профиля WAF.

     {% cut "Пример описания профиля WAF в конфигурации {{ TF }}" %}

     {% include [waf-profile-terraform-example](../../_includes/smartwebsecurity/waf-profile-terraform-example.md) %}

     {% endcut %}

  1. Примените изменения:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Вы можете проверить удаление ресурсов в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [delete](../waf/api-ref/WafProfile/delete.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/) или вызовом gRPC API [WafProfile/Delete](../waf/api-ref/grpc/WafProfile/delete.md).

{% endlist %}
