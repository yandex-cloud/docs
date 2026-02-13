---
title: Удаление политики MFA в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете удалить политику MFA в {{ org-full-name }}.
---

# Удалить политику MFA

Чтобы удалить [политику MFA](../../concepts/mfa.md#mfa-policies):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}**.
  1. В списке политик MFA в строке с нужной политикой нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите список политик MFA с помощью команды:

     ```bash
     yc organization-manager mfa-enforcement list \
       --organization-id <идентификатор_организации>
     ```

     Где `--organization-id` — идентификатор организации.

  1. Посмотрите описание команды CLI для удаления политики MFA:

     ```bash
     yc organization-manager mfa-enforcement delete --help
     ```

  1. Чтобы удалить политику MFA, выполните команду:

     ```bash
     yc organization-manager mfa-enforcement delete \
       --id <идентификатор_политики>
     ```

     Где `--id` — идентификатор политики MFA, которую нужно удалить.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте конфигурационный файл {{ TF }} и удалите фрагмент с описанием политики MFA:

     {% include [mfa-tf-code-block](../../../_includes/organization/mfa-tf-code-block.md) %}

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_mfa_enforcement` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_mfa_enforcement).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} удалит политику MFA. Проверить удаление политики MFA можно в интерфейсе [{{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc organization-manager mfa-enforcement list --organization-id <идентификатор_организации>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Delete](../../../organization/api-ref/MfaEnforcement/delete.md) для ресурса [MfaEnforcement](../../../organization/api-ref/MfaEnforcement/index.md) или вызовом gRPC API [MfaEnforcementService/Delete](../../../organization/api-ref/grpc/MfaEnforcement/delete.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create-policy.md)
* [{#T}](./update-policy.md)
* [{#T}](./add-users.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)