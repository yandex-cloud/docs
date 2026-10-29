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

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Для настройки SSPR используйте провайдер {{ yandex-cloud }} версии 0.239.0 или выше.

  1. Откройте конфигурационный файл {{ TF }} и добавьте параметр `sspr_policies` в описание нужной политики MFA — ресурса `yandex_organizationmanager_mfa_enforcement`:

     ```hcl
     resource "yandex_organizationmanager_mfa_enforcement" "example_mfa_policy" {
       name            = "<имя_политики>"
       organization_id = "<идентификатор_организации>"
       acr_id          = "<тип_фактора_аутентификации>"
       ttl             = "<время_жизни>"
       enroll_window   = "<срок_создания>"
       sspr_policies   = ["two-any", "mfa"]
     }
     ```

     `sspr_policies` — список разрешенных [способов сброса пароля](../concepts/sspr.md#reset-methods). Укажите одно или оба значения:

     * `two-any` — подтверждение личности с помощью двух любых факторов MFA.
     * `mfa` — подтверждение личности с помощью FIDO2-ключа или Passkey с обязательной локальной проверкой пользователя (User Verification), например с помощью PIN-кода или биометрии.

     Чтобы отключить самостоятельный сброс пароля, задайте пустой список: `sspr_policies = []`.

     Сохраните остальные параметры политики без изменений. Подробнее о параметрах ресурса `yandex_organizationmanager_mfa_enforcement` читайте в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_mfa_enforcement).

     Если политика создана не в {{ TF }}, сначала добавьте ее описание в конфигурационный файл с текущими значениями параметров и импортируйте ее в состояние {{ TF }}:

     ```bash
     terraform init
     terraform import yandex_organizationmanager_mfa_enforcement.example_mfa_policy <идентификатор_политики>
     ```

     Если политики MFA еще нет, [создайте](./mfa/create-policy.md) ее и [добавьте пользователей в целевую группу](./mfa/add-users.md).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

    Воспользуйтесь методом REST API [update](../api-ref/MfaEnforcement/update.md) для ресурса [MfaEnforcement](../api-ref/MfaEnforcement/index.md) или вызовом gRPC API [MfaEnforcementService/Update](../api-ref/grpc/MfaEnforcement/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../concepts/sspr.md)
* [{#T}](../concepts/mfa.md)
* [{#T}](./user-account/reset-password.md)
