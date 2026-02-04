---
title: Как получить информацию об OIDC-приложении в {{ org-full-name }}
description: Следуя данной инструкции, вы получите информацию об OIDC-приложении в {{ org-name }}.
---

# Получить информацию об OIDC-приложении в {{ org-full-name }}


{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. Нажмите на строку с [OIDC-приложением](../../concepts/applications.md#oidc), о котором вы хотите получить информацию.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации об [OIDC-приложении](../../concepts/applications.md#oidc):

     ```bash
     yc organization-manager idp application oauth application get --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp application oauth application get <идентификатор_приложения>
     ```

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-22T11:53:21.689383Z"
     ```

- API {#api}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_organizationmanager_idp_application_oauth_application" "app" {
       application_id = "<идентификатор_приложения>"
     }
     
     output "my_app_name" {
       value = data.yandex_organizationmanager_idp_application_oauth_application.app.name
     }
     
     output "my_app_status" {
       value = data.yandex_organizationmanager_idp_application_oauth_application.app.status
     }
     
     output "my_app_client_id" {
       value = data.yandex_organizationmanager_idp_application_oauth_application.app.client_grant.client_id
     }
     ```

     Где:

     * `data "yandex_organizationmanager_idp_application_oauth_application"` — описание OIDC-приложения в качестве источника данных:
       * `application_id` — идентификатор приложения.
     * `output` — выходные переменные, которые содержат информацию о приложении:
       * `value` — возвращаемое значение.

     Вместо указанных параметров вы можете выбрать любые другие для получения информации. Более подробно о параметрах источника данных `yandex_organizationmanager_idp_application_oauth_application` см. в [документации провайдера]({{ tf-provider-datasources-link }}/organizationmanager_idp_application_oauth_application).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

- API {#api}

  Воспользуйтесь методом REST API [Application.Get](../../idp/application/oauth/api-ref/Application/get.md) для ресурса [Application](../../idp/application/oauth/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Get](../../idp/application/oauth/api-ref/grpc/Application/get.md).

{% endlist %}