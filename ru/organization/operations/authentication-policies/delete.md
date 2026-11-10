---
title: Как удалить политику аутентификации в {{ org-full-name }}
description: Следуя этой инструкции, вы сможете удалить политику аутентификации в {{ org-full-name }}.
---

# Удалить политику аутентификации

{% include [auth-policy-intro](../../../_includes/organization/auth-policy-intro.md) %}

{% include [auth-policy-role](../../../_includes/organization/auth-policy-role.md) %}

Чтобы удалить политику аутентификации:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}** и перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_auth_policies }}**.
  1. В строке с нужной политикой аутентификации нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды CLI для удаления политики аутентификации:

      ```bash
      yc organization-manager authentication-policy-rule delete --help
      ```
  1. {% include [auth-policy-list-cli](../../../_includes/organization/auth-policy-list-cli.md) %}
  1. Удалите политику аутентификации, указав ее идентификатор:

      ```bash
      yc organization-manager authentication-policy-rule delete <идентификатор_политики>
      ```
  1. Убедитесь, что политика аутентификации была удалена. Для этого повторно выполните команду `yc organization-manager authentication-policy-rule list`.

- API {#api}

  Воспользуйтесь методом REST API [delete](../../policy/api-ref/AuthenticationPolicyRule/delete.md) для ресурса [AuthenticationPolicyRule](../../policy/api-ref/AuthenticationPolicyRule/index.md) или вызовом gRPC API [AuthenticationPolicyRuleService/Delete](../../policy/api-ref/grpc/AuthenticationPolicyRule/delete.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/applications/index.md)
* [{#T}](../../concepts/authentication-policy.md)
* [{#T}](./create.md)
* [{#T}](./activate-deactivate.md)
* [{#T}](./update.md)

