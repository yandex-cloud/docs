---
title: Активация и деактивация политики MFA в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете активировать и деактивировать политику MFA в {{ org-full-name }}.
---

# Активировать и деактивировать политику MFA

## Активируйте политику MFA {#reactivate-policy}

Чтобы активировать неактивную [политику MFA](../../concepts/mfa.md#mfa-policies):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}**.
  1. В списке политик MFA в строке с нужной политикой нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrows-rotate-right](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud_org.organization.security-settings.mfa-overview-action-activate }}**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для активации политики MFA:

     ```bash
     yc organization-manager mfa-enforcement activate --help
     ```

  1. Чтобы активировать политику MFA, выполните команду:

     ```bash
     yc organization-manager mfa-enforcement activate \
       --id <идентификатор_политики>
     ```

     Где `--id` — идентификатор политики MFA, которую нужно активировать.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте конфигурационный файл {{ TF }} и измените параметр `status` ресурса `yandex_organizationmanager_mfa_enforcement`:

     ```hcl
     resource "yandex_organizationmanager_mfa_enforcement" "example_mfa_policy" {
       name            = "<имя_политики>"
       organization_id = "<идентификатор_организации>"
       acr_id          = "<тип_фактора_аутентификации>"
       ttl             = "<время_жизни>"
       status          = "MFA_ENFORCEMENT_STATUS_ACTIVE"
       apply_at        = "<время_активации>"
       enroll_window   = "<срок_создания>"
       description     = "<описание_политики>"
     }
     ```

     Где `status` — статус политики: `MFA_ENFORCEMENT_STATUS_ACTIVE` для активации политики. Необязательный параметр.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_mfa_enforcement` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_mfa_enforcement).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} активирует политику MFA. Проверить изменение статуса политики MFA можно в интерфейсе [{{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc organization-manager mfa-enforcement get <идентификатор_политики>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Activate](../../../organization/api-ref/MfaEnforcement/activate.md) для ресурса [MfaEnforcement](../../../organization/api-ref/MfaEnforcement/index.md) или вызовом gRPC API [MfaEnforcementService/Activate](../../../organization/api-ref/grpc/MfaEnforcement/activate.md).

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

- CLI {#cli}

  1. Посмотрите описание команды CLI для деактивации политики MFA:

     ```bash
     yc organization-manager mfa-enforcement deactivate --help
     ```

  1. Чтобы деактивировать политику MFA, выполните команду:

     ```bash
     yc organization-manager mfa-enforcement deactivate \
       --id <идентификатор_политики>
     ```

     Где `--id` — идентификатор политики MFA, которую нужно деактивировать.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте конфигурационный файл {{ TF }} и измените параметр `status` ресурса `yandex_organizationmanager_mfa_enforcement`:

     ```hcl
     resource "yandex_organizationmanager_mfa_enforcement" "example_mfa_policy" {
       name            = "<имя_политики>"
       organization_id = "<идентификатор_организации>"
       acr_id          = "<тип_фактора_аутентификации>"
       ttl             = "<время_жизни>"
       status          = "MFA_ENFORCEMENT_STATUS_INACTIVE"
       apply_at        = "<время_активации>"
       enroll_window   = "<срок_создания>"
       description     = "<описание_политики>"
     }
     ```

     Где `status` — статус политики: `MFA_ENFORCEMENT_STATUS_INACTIVE` для деактивации политики. Необязательный параметр.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_mfa_enforcement` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_mfa_enforcement).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} деактивирует политику MFA. Проверить изменение статуса политики MFA можно в интерфейсе [{{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc organization-manager mfa-enforcement get <идентификатор_политики>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Deactivate](../../../organization/api-ref/MfaEnforcement/deactivate.md) для ресурса [MfaEnforcement](../../../organization/api-ref/MfaEnforcement/index.md) или вызовом gRPC API [MfaEnforcementService/Deactivate](../../../organization/api-ref/grpc/MfaEnforcement/deactivate.md).

{% endlist %}

В результате политика MFA будет деактивирована и перейдет в статус `Inactive`, а к учетным записям пользователей, добавленных в целевые группы политики, перестанут применяться требования этой политики по использованию дополнительного фактора аутентификации.

#### См. также {#see-also}

* [{#T}](./create-policy.md)
* [{#T}](./update-policy.md)
* [{#T}](./add-users.md)
* [{#T}](./delete-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)