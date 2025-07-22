---
title: Включить требование двухфакторной аутентификации
description: Следуя данной инструкции, вы сможете настроить доступ к ресурсам только для пользователей с двухфакторной аутентификацией.
---

# Включить требование двухфакторной аутентификации

Вы можете запретить аутентификацию в {{ yandex-cloud }} всем пользователям вашей организации с [аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport), у которых не настроена [двухфакторная аутентификация](https://yandex.ru/support/passport/authorization/twofa.html).

{% note warning %}

При включении настройки доступ к организации потеряют все пользователи, уже аутентифицированные без применения двухфакторной проверки, включая администраторов и владельцев.
Чтобы вернуть доступ к организации, [настройте](https://id.yandex.ru/security/enter-methods) двухфакторную аутентификацию для аккаунта на Яндексе.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

      При необходимости [переключитесь](./manage-organizations.md#switch-to-another-org) на нужную организацию.

  1. На панели слева выберите ![shield](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.oslogin.title }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_other_kJgk8 }}**, в блоке **{{ ui-key.yacloud_org.organization.security-settings.OtherSecuritySettingsForm.auth_settings_1RoAM }}** включите опцию **{{ ui-key.yacloud_org.organization.security-settings.OtherSecuritySettingsForm.required_mfa_6P4xN }}**.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/enable-refresh-tokens.md)
* [{#T}](../operations/hide-user-info.md)