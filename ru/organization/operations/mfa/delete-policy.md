---
title: Удаление политики MFA в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете удалить политику MFA в {{ org-full-name }}.
---

# Удалить политику MFA

{% include [note-preview](../../../_includes/note-preview.md) %}

Чтобы удалить [политику MFA](../../concepts/mfa.md#mfa-policies):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}**.
  1. В списке политик MFA в строке с нужной политикой нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите действие.

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create-policy.md)
* [{#T}](./update-policy.md)
* [{#T}](./add-users.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)