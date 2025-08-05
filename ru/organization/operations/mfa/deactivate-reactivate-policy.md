---
title: Активация и деактивация политики MFA в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете активировать и деактивировать политику MFA в {{ org-full-name }}.
---

# Активировать и деактивировать политику MFA

{% include [note-preview](../../../_includes/note-preview.md) %}

## Активируйте политику MFA {#reactivate-policy}

Чтобы активировать неактивную [политику MFA](../../concepts/mfa.md#mfa-policies):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}**.
  1. В списке политик MFA в строке с нужной политикой нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrows-rotate-right](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud_org.organization.security-settings.mfa-overview-action-activate }}**.
  1. В открывшемся окне подтвердите действие.

{% endlist %}

В результате политика MFA будет активирована и перейдет в статус `Active`, а к учетным записям пользователей, добавленных в целевые группы политики, начнут применяться требования этой политики по использованию дополнительного фактора аутентификации.

## Деактивируйте политику MFA {#deactivate-policy}

Чтобы временно деактивировать [политику MFA](../../concepts/mfa.md#mfa-policies):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}**.
  1. В списке политик MFA в строке с нужной политикой нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pause](../../../_assets/console-icons/pause.svg) **{{ ui-key.yacloud_org.organization.security-settings.mfa-overview-action-suspend }}**.
  1. В открывшемся окне подтвердите действие.

{% endlist %}

В результате политика MFA будет деактивирована и перейдет в статус `Inactive`, а к учетным записям пользователей, добавленных в целевые группы политики, перестанут применяться требования этой политики по использованию дополнительного фактора аутентификации.

#### См. также {#see-also}

* [{#T}](./create-policy.md)
* [{#T}](./update-policy.md)
* [{#T}](./add-users.md)
* [{#T}](./delete-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)