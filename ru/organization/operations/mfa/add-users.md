---
title: Применить политику MFA к пользователям в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете добавить пользователей и группы в политику MFA в {{ org-full-name }} и удалить их из нее.
---

# Применить политику MFA к пользователям

{% include [note-preview](../../../_includes/note-preview.md) %}

Чтобы [политика MFA](../../concepts/mfa.md#mfa-policies) применялась в отношении учетных записей пользователей, в целевые группы этой политики требуется явно добавить нужных пользователей или [группы](../../concepts/groups.md), в которые эти пользователи входят.

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}** и в списке политик выберите нужную. В открывшемся окне:

      1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyPageLayout.tab_groups }}**.
      1. Чтобы добавить в целевые группы политики нового пользователя или группу:

          1. Нажмите кнопку ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.mfa-policy-audiences.action_add-users }}**.
          1. В открывшемся окне выберите нужного пользователя или группу пользователей.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
      1. Чтобы удалить из политики пользователя или группу:
          1. В списке пользователей и групп в строке с нужным пользователем или группой нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
          1. Подтвердите удаление.

{% endlist %}

{% include [mfa-policy-applications-acc-type-notice](../../../_includes/organization/mfa-policy-applications-acc-type-notice.md) %}

#### См. также {#see-also}

* [{#T}](./create-policy.md)
* [{#T}](./update-policy.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./delete-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)