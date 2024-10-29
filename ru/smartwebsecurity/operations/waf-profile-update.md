---
title: Изменить основные параметры профиля WAF
description: Следуя данной инструкции, вы сможете изменить основные параметры профиля WAF.
---

# Изменить основные параметры профиля WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. В строке с нужным профилем нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. На странице редактирования профиля измените параметры:
      * **{{ ui-key.yacloud.common.name }}**.
      * **{{ ui-key.yacloud.common.description }}**.
      * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md). Чтобы добавить новую метку, нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.

  1. {% include [waf-inspect-request](../../_includes/smartwebsecurity/waf-inspect-request.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### См. также {#see-also}

* [{#T}](waf-profile-delete.md)
* [{#T}](rule-add.md)
* [{#T}](rule-update.md)
