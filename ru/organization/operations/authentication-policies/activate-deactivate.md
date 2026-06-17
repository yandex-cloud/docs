---
title: Как активировать и деактивировать политику аутентификации в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете активировать и деактивировать политику аутентификации в {{ org-full-name }}.
---

# Активировать и деактивировать политику аутентификации

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [auth-policy-intro](../../../_includes/organization/auth-policy-intro.md) %}

{% include [auth-policy-role](../../../_includes/organization/auth-policy-role.md) %}

## Активируйте политику аутентификации {#activate}

Чтобы активировать политику аутентификации:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}** и перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_auth_policies }}**.
  1. В строке с неактивной политикой аутентификации нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrows-rotate-right](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud_org.organization.security-settings.auth-policies-table.action-activate }}**.
  1. В открывшемся окне подтвердите активацию политики.

{% endlist %}

## Деактивируйте политику аутентификации {#deactivate}

Чтобы деактивировать политику аутентификации:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}** и перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_auth_policies }}**.
  1. В строке с активной политикой аутентификации нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pause](../../../_assets/console-icons/pause.svg) **{{ ui-key.yacloud_org.organization.security-settings.auth-policies-table.action-deactivate }}**.
  1. В открывшемся окне подтвердите деактивацию политики.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/applications.md)
* [{#T}](../../concepts/authentication-policy.md)
* [{#T}](./create.md)
* [{#T}](./update.md)
