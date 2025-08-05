---
title: Создание политики MFA в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете создать и настроить политику MFA в {{ org-full-name }}.
---

# Создать политику MFA

{% include [note-preview](../../../_includes/note-preview.md) %}

[Политики MFA](../../concepts/mfa.md#mfa-policies) позволяют настроить [многофакторную аутентификацию](https://ru.wikipedia.org/wiki/Многофакторная_аутентификация) (MFA) для [федеративных](../../../iam/concepts/users/accounts.md#saml-federation) и [локальных](../../../iam/concepts/users/accounts.md#local) аккаунтов пользователей.

Чтобы создать политику MFA:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}**.
  1. В правом верхнем углу страницы нажмите ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.security-settings.mfa-policies-create-policy-action }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.forms.field.display-name }}** задайте имя создаваемой политики. Требования к имени:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}
      1. {% include [mfa-create-policy-step2](../../../_includes/organization/mfa-create-policy-step2.md) %}
      1. Если вы не хотите активировать создаваемую политику при создании, выключите опцию **{{ ui-key.yacloud_org.form.mfa-enforcement.caption.active }}**.
      1. {% include [mfa-create-policy-step4](../../../_includes/organization/mfa-create-policy-step4.md) %}
      1. {% include [mfa-create-policy-step5](../../../_includes/organization/mfa-create-policy-step5.md) %}
      1. {% include [mfa-create-policy-step6](../../../_includes/organization/mfa-create-policy-step6.md) %}
      1. Нажмите кнопку **{{ ui-key.yacloud_org.form.mfa-enforcement.create.action.create }}**.

{% endlist %}

{% include [mfa-policy-add-users-notice](../../../_includes/organization/mfa-policy-add-users-notice.md) %}

#### См. также {#see-also}

* [{#T}](./update-policy.md)
* [{#T}](./add-users.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./delete-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)