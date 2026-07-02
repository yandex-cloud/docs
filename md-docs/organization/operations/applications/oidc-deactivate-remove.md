[Документация Yandex Cloud](../../../index.md) > [Yandex Identity Hub](../../index.md) > [Пошаговые инструкции](../index.md) > Управление приложениями (SSO) > OIDC-приложения > Деактивировать и удалить приложение

# Деактивировать и удалить OIDC-приложение в Yandex Identity Hub


Управлять OIDC-приложениями может пользователь, которому назначена [роль](../../security/index.md#organization-manager-oauthApplications-admin) `organization-manager.oauthApplications.admin` или выше.

## Деактивируйте приложение {#deactivate}

Если вам требуется временно отключить возможность аутентификации пользователей вашей [организации](../../concepts/organization.md) во внешнем приложении с помощью технологии единого входа по стандарту [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC), деактивируйте соответствующее [OIDC-приложение](../../concepts/applications/oidc.md) в Yandex Identity Hub:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
  1. В строке с OIDC-приложением, которое вы хотите деактивировать, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pause](../../../_assets/console-icons/pause.svg) **Деактивировать**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

Если вам требуется восстановить возможность аутентификации пользователей вашей организации во внешнем приложении с помощью стандарта единого входа OIDC, активируйте соответствующее OIDC-приложение в Yandex Identity Hub:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
  1. В строке с OIDC-приложением, которое вы хотите активировать, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrows-rotate-right](../../../_assets/console-icons/arrows-rotate-right.svg) **Активировать**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
  1. В строке с OIDC-приложением, которое вы хотите удалить, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления OIDC-приложения:

     ```bash
     yc organization-manager idp application oauth application delete --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp application oauth application delete <идентификатор_приложения>
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Чтобы удалить OIDC-приложение, удалите соответствующий ресурс из конфигурационного файла Terraform:

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

     Подробнее о параметрах ресурса `yandex_organizationmanager_idp_application_oauth_application` читайте в [документации провайдера](../../../terraform/resources/organizationmanager_idp_application_oauth_application.md).

  1. Примените изменения:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Terraform удалит ресурс OIDC-приложения. Проверить удаление ресурса можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc organization-manager idp application oauth application list --organization-id <идентификатор_организации>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Application.Delete](../../idp/application/oauth/api-ref/Application/delete.md) для ресурса [Application](../../idp/application/oauth/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Delete](../../idp/application/oauth/api-ref/grpc/Application/delete.md).

{% endlist %}

В результате OIDC-приложение будет удалено, а пользователи навсегда потеряют возможность аутентификации с его помощью во внешнем приложении.

#### Полезные ссылки {#see-also}

* [Создать OIDC-приложение в Yandex Identity Hub](oidc-create.md)
* [Изменить OIDC-приложение в Yandex Identity Hub](oidc-update.md)
* [Добавить пользователя](../add-account.md)
* [OIDC-приложения](../../concepts/applications/oidc.md)
* [Управление группами пользователей](../manage-groups.md)