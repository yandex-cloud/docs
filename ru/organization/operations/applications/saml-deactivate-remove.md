---
title: Как деактивировать или удалить SAML-приложение в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете деактивировать, повторно активировать и удалить SAML-приложение в {{ org-name }}.
---

# Деактивировать и удалить SAML-приложение в {{ org-full-name }}


{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

## Деактивируйте приложение {#deactivate}

Если вам требуется временно отключить возможность аутентификации пользователей вашей [организации](../../concepts/organization.md) во внешнем приложении с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), деактивируйте соответствующее [SAML-приложение](../../concepts/applications.md#saml) в {{ org-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. В строке с SAML-приложением, которое вы хотите деактивировать, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pause](../../../_assets/console-icons/pause.svg) **{{ ui-key.yacloud_org.action.applications.components.action_deactivate }}**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для деактивации SAML-приложения:

     ```bash
     yc organization-manager idp application saml application suspend --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp application saml application suspend <идентификатор_приложения>
     ```

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: test-saml-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     status: SUSPENDED
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T11:28:09.167252Z"
     ```

- API {#api}

  Воспользуйтесь методом REST API [Application.Suspend](../../idp/application/saml/api-ref/Application/suspend.md) для ресурса [Application](../../idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Suspend](../../idp/application/saml/api-ref/grpc/Application/suspend.md).

{% endlist %}

В результате SAML-приложение будет деактивировано и перейдет в статус `Suspended`, а пользователи потеряют возможность аутентификации с его помощью в соответствующем внешнем приложении.

## Активируйте приложение {#reactivate}

Если вам требуется восстановить возможность аутентификации пользователей вашей организации во внешнем приложении с помощью SAML-стандарта единого входа, активируйте соответствующее SAML-приложение в {{ org-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. В строке с SAML-приложением, которое вы хотите активировать, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrows-rotate-right](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud_org.action.applications.components.action_activate }}**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для активации SAML-приложения:

     ```bash
     yc organization-manager idp application saml application reactivate --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp application saml application reactivate <идентификатор_приложения>
     ```

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: test-saml-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T11:28:09.167252Z"
     ```

- API {#api}

  Воспользуйтесь методом REST API [Application.Reactivate](../../idp/application/saml/api-ref/Application/reactivate.md) для ресурса [Application](../../idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Reactivate](../../idp/application/saml/api-ref/grpc/Application/reactivate.md).

{% endlist %}

В результате SAML-приложение будет активировано и перейдет в статус `Active`, а пользователи, добавленные в приложение, вновь получат возможность аутентификации с его помощью во внешнем приложении.

## Удалите приложение {#delete}

Чтобы удалить SAML-приложение:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. В строке с SAML-приложением, которое вы хотите удалить, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления SAML-приложения:

     ```bash
     yc organization-manager idp application saml application delete --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp application saml application delete <идентификатор_приложения>
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием SAML-приложения:

     Пример описания SAML-приложения в конфигурации {{ TF }}

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_application" "saml_app" {
       organization_id = "bpfd1n2bnoqr********"
       name            = "my-saml-app"

       service_provider = {
         entity_id = "https://example.com/saml/metadata"
         acs_urls       = [
           {
             url = "http://localhost"
           }
         ]
       }
     }
     ```

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить удаление ресурсов можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

  Воспользуйтесь методом REST API [Application.Delete](../../idp/application/saml/api-ref/Application/delete.md) для ресурса [Application](../../idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Delete](../../idp/application/saml/api-ref/grpc/Application/delete.md).

{% endlist %}

В результате SAML-приложение будет удалено, а пользователи навсегда потеряют возможность аутентификации с его помощью во внешнем приложении.

#### См. также {#see-also}

* [{#T}](./saml-create.md)
* [{#T}](./saml-update.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#saml)
* [{#T}](../manage-groups.md)
