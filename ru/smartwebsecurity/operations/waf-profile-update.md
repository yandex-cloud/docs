---
title: Изменить основные параметры профиля WAF
description: Следуя данной инструкции, вы сможете изменить основные параметры профиля WAF.
---

# Изменить основные параметры профиля WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. В строке с нужным профилем нажмите ![options](../../_assets/console-icons/ellipsis.svg) → ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. На странице редактирования профиля измените основные параметры:

      * **{{ ui-key.yacloud.common.name }}**.
      * **{{ ui-key.yacloud.common.description }}**.
      * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md). Чтобы добавить новую метку, нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.

  1. Включите или выключите наборы правил для профиля WAF.
  1. Выберите версию набора правил.
  1. {% include [waf-verdicts](../../_includes/smartwebsecurity/waf-verdicts.md) %}
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.
  1. При необходимости [настройте правила](configure-set-rules.md) в каждом наборе, который вы добавили.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы изменить параметры профиля WAF {{ sws-full-name }}, который вы создали с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием профиля WAF.

     {% cut "Пример описания профиля WAF в конфигурации {{ TF }}" %}

     {% include [waf-profile-terraform-example](../../_includes/smartwebsecurity/waf-profile-terraform-example.md) %}

     {% endcut %}

      Подробнее о параметрах ресурса `yandex_sws_waf_profile` в [документации провайдера]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Примените изменения:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Вы можете проверить изменение ресурсов в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../waf/api-ref/WafProfile/update.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/) или вызовом gRPC API [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](waf-profile-delete.md)
* [{#T}](rule-add.md)
* [{#T}](rule-update.md)
