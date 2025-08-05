---
title: Изменение политики MFA в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете изменить политику MFA в {{ org-full-name }}.
---

# Изменить политику MFA

{% include [note-preview](../../../_includes/note-preview.md) %}

Чтобы изменить [политику MFA](../../concepts/mfa.md#mfa-policies):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}**.
  1. В списке политик MFA в строке с нужной политикой нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.forms.field.display-name }}** задайте новое имя политики. Требования к имени:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}
      1. {% include [mfa-create-policy-step2](../../../_includes/organization/mfa-create-policy-step2.md) %}
      1. При необходимости с помощью опции **{{ ui-key.yacloud_org.form.mfa-enforcement.caption.active }}** активируйте или деактивируйте политику.
      1. {% include [mfa-create-policy-step4](../../../_includes/organization/mfa-create-policy-step4.md) %}
      1. {% include [mfa-create-policy-step5](../../../_includes/organization/mfa-create-policy-step5.md) %}
      1. {% include [mfa-create-policy-step6](../../../_includes/organization/mfa-create-policy-step6.md) %}
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

{% include [mfa-policy-add-users-notice](../../../_includes/organization/mfa-policy-add-users-notice.md) %}

#### См. также {#see-also}

* [{#T}](./create-policy.md)
* [{#T}](./add-users.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./delete-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)