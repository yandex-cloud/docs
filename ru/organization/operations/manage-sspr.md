---
title: Настроить самостоятельный сброс пароля пользователями в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете настроить самостоятельный сброс пароля пользователями (SSPR) в {{ org-full-name }}.
---

# Настроить самостоятельный сброс пароля пользователями в {{ org-full-name }}

С помощью [политик MFA](../concepts/mfa.md) вы можете разрешить самостоятельный сброс пароля (SSPR — [self-service password reset](https://en.wikipedia.org/wiki/Self-service_password_reset)) для [локальных](../../iam/concepts/users/accounts.md#local) пользователей {{ org-full-name }}.

Чтобы настроить для пользователей возможность самостоятельного сброса пароля:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}**.
  1. В списке политик MFA в строке с нужной политикой нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. Если у вас нет политики MFA, [создайте](./mfa/create-policy.md) новую политику. В открывшемся окне:

      1. Чтобы включить возможность [самостоятельного сброса пароля](../../organization/concepts/sspr.md) для пользователей, добавленных в целевую группу политики MFA, в блоке **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyForm.sspr-section_4HP7w }}**:

          1. Включите опцию **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyForm.caption_sspr_enabled_dXFne }}**.
          1. В поле **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyForm.caption_sspr_methods_7Xw6F }}** выберите как минимум один способ верификации пользователя при сбросе пароля:

          {% include [password-reset-mfa-methods](../../_includes/organization/password-reset-mfa-methods.md) %}

      {% note info %}

      Чтобы отключить для пользователей возможность самостоятельного сброса пароля, в блоке **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyForm.sspr-section_4HP7w }}** отключите опцию **{{ ui-key.yacloud_org.organization.security-settings.MfaPolicyForm.caption_sspr_enabled_dXFne }}**.

      {% endnote %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../concepts/sspr.md)
* [{#T}](../concepts/mfa.md)
* [{#T}](./user-account/reset-password.md)