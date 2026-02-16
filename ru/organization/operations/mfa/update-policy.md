---
title: Изменение политики MFA в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете изменить политику MFA в {{ org-full-name }}.
---

# Изменить политику MFA

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

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите список политик MFA с помощью команды:

     ```bash
     yc organization-manager mfa-enforcement list \
       --organization-id <идентификатор_организации>
     ```

     Где `--organization-id` — идентификатор организации.

  1. Посмотрите описание нужной политики MFA:

     ```bash
     yc organization-manager mfa-enforcement get \
       --id <идентификатор_политики>
     ```

  1. Посмотрите описание команды CLI для изменения политики MFA:

     ```bash
     yc organization-manager mfa-enforcement update --help
     ```

  1. Чтобы изменить политику MFA, выполните команду:

     ```bash
     yc organization-manager mfa-enforcement update \
       --id <идентификатор_политики> \
       --acr-id <тип_фактора_аутентификации> \
       --ttl <время_жизни> \
       --status <статус_политики> \
       --apply-at <время_применения_изменений> \
       --enroll-window <период_регистрации> \
       --new-name <новое_имя> \
       --description <новое_описание> \
       --organization-id <идентификатор_организации>
     ```

     Где:

     * `--id` — идентификатор политики MFA.
     * {% include [mfa-acr-id-cli-flag-legend](../../../_includes/organization/mfa-acr-id-cli-flag-legend.md) %}
     * `--ttl` — срок действия учетных данных в днях.
     * `--status` — статус политики: `status-active` — активна, `status-inactive` — неактивна.
     * `--apply-at` — время, по истечении которого политика станет активна.
     * `--enroll-window` — период в днях после регистрации, в течение которого пользователь должен добавить второй фактор аутентификации.
     * `--new-name` — новое имя политики.
     * `--description` — новое описание.
     * `--organization-id` — идентификатор организации.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте конфигурационный файл {{ TF }} и измените параметры ресурса `yandex_organizationmanager_mfa_enforcement`:

     ```hcl
     resource "yandex_organizationmanager_mfa_enforcement" "example_mfa_policy" {
       name            = "<новое_имя_политики>"
       organization_id = "<идентификатор_организации>"
       acr_id          = "<новый_тип_фактора_аутентификации>"
       ttl             = "<новое_время_жизни>"
       status          = "<новый_статус_политики>"
       apply_at        = "<новое_время_активации>"
       enroll_window   = "<новый_срок_создания>"
       description     = "<новое_описание_политики>"
     }
     ```

     {% include [mfa-tf-params-description](../../../_includes/organization/mfa-tf-params-description.md) %}

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} обновит политику MFA. Проверить изменения политики MFA можно в интерфейсе [{{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc organization-manager mfa-enforcement get <идентификатор_политики>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Update](../../../organization/api-ref/MfaEnforcement/update.md) для ресурса [MfaEnforcement](../../../organization/api-ref/MfaEnforcement/index.md) или вызовом gRPC API [MfaEnforcementService/Update](../../../organization/api-ref/grpc/MfaEnforcement/update.md).

{% endlist %}

{% include [mfa-policy-add-users-notice](../../../_includes/organization/mfa-policy-add-users-notice.md) %}

#### См. также {#see-also}

* [{#T}](./create-policy.md)
* [{#T}](./add-users.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./delete-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)