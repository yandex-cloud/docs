---
title: Как деактивировать или удалить OIDC-приложение в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете деактивировать, повторно активировать и удалить OIDC-приложение в {{ org-name }}.
---

# Деактивировать и удалить OIDC-приложение в {{ org-full-name }}


{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

## Деактивируйте приложение {#deactivate}

Если вам требуется временно отключить возможность аутентификации пользователей вашей [организации](../../concepts/organization.md) во внешнем приложении с помощью технологии единого входа по стандарту [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC), деактивируйте соответствующее [OIDC-приложение](../../concepts/applications.md#oidc) в {{ org-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. В строке с OIDC-приложением, которое вы хотите деактивировать, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pause](../../../_assets/console-icons/pause.svg) **{{ ui-key.yacloud_org.action.applications.components.action_deactivate }}**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для деактивации OIDC-приложения:

     ```bash
     yc organization-manager idp application oauth application suspend --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp application oauth application suspend <идентификатор_приложения>
     ```

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: test-oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
     status: SUSPENDED
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T11:28:09.167252Z"
     ```

- API {#api}

  Воспользуйтесь методом REST API [Application.Suspend](../../idp/application/oauth/api-ref/Application/suspend.md) для ресурса [Application](../../idp/application/oauth/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Suspend](../../idp/application/oauth/api-ref/grpc/Application/suspend.md).

{% endlist %}

В результате OIDC-приложение будет деактивировано и перейдет в статус `Suspended`, а пользователи потеряют возможность аутентификации с его помощью в соответствующем внешнем приложении.

## Активируйте приложение {#reactivate}

Если вам требуется восстановить возможность аутентификации пользователей вашей организации во внешнем приложении с помощью стандарта единого входа OIDC, активируйте соответствующее OIDC-приложение в {{ org-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. В строке с OIDC-приложением, которое вы хотите активировать, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrows-rotate-right](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud_org.action.applications.components.action_activate }}**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для активации OIDC-приложения:

     ```bash
     yc organization-manager idp application oauth application reactivate --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp application oauth application reactivate <идентификатор_приложения>
     ```

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: test-oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T11:28:09.167252Z"
     ```

- API {#api}

  Воспользуйтесь методом REST API [Application.Reactivate](../../idp/application/oauth/api-ref/Application/reactivate.md) для ресурса [Application](../../idp/application/oauth/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Reactivate](../../idp/application/oauth/api-ref/grpc/Application/reactivate.md).

{% endlist %}

В результате OIDC-приложение будет активировано и перейдет в статус `Active`, а пользователи, добавленные в приложение, вновь получат возможность аутентификации с его помощью во внешнем приложении.

## Удалите приложение {#delete}

Чтобы удалить OIDC-приложение:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. В строке с OIDC-приложением, которое вы хотите удалить, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления OIDC-приложения:

     ```bash
     yc organization-manager idp application oauth application delete --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp application oauth application delete <идентификатор_приложения>
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Чтобы удалить OIDC-приложение, удалите соответствующий ресурс из конфигурационного файла {{ TF }}:

     Пример описания OIDC-приложения в конфигурации Terraform

     ```hcl
     resource "yandex_organizationmanager_idp_application_oauth_application" "example_oidc_app" {
       organization_id = "<идентификатор_организации>"
       name            = "<имя_приложения>"
       description     = "<описание_приложения>"
    
       client_grant = {
         client_id         = "<идентификатор_OAuth-клиента>"
         authorized_scopes = ["<атрибут1>", "<атрибут2>"]
       }
    
       group_claims_settings = {
         group_distribution_type = "ALL_GROUPS"
       }
    
       labels = {
         "<ключ1>" = "<значение1>"
         "<ключ2>" = "<значение2>"
       }
     }
     ```

     Где:

     * `organization_id` — [идентификатор организации](../organization-get-id.md), в которой находится OIDC-приложение.
     * `name` — имя OIDC-приложения.
     * `description` — описание OIDC-приложения.
     * `client_grant` — параметры подключения к OAuth-клиенту:
       * `client_id` — идентификатор OAuth-клиента.
       * `authorized_scopes` — набор атрибутов пользователей, которые доступны поставщику услуг.
     * `group_claims_settings` — настройки передачи групп пользователей поставщику услуг:
       * `group_distribution_type` — тип распределения групп.
     * `labels` — список [меток](../../../resource-manager/concepts/labels.md).

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_application_oauth_application` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_application_oauth_application).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} удалит ресурс OIDC-приложения. Проверить удаление ресурса можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc organization-manager idp application oauth application list --organization-id <идентификатор_организации>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Application.Delete](../../idp/application/oauth/api-ref/Application/delete.md) для ресурса [Application](../../idp/application/oauth/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Delete](../../idp/application/oauth/api-ref/grpc/Application/delete.md).

{% endlist %}

В результате OIDC-приложение будет удалено, а пользователи навсегда потеряют возможность аутентификации с его помощью во внешнем приложении.

#### См. также {#see-also}

* [{#T}](./oidc-create.md)
* [{#T}](./oidc-update.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#oidc)
* [{#T}](../manage-groups.md)