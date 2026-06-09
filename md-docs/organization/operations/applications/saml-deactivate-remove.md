# Деактивировать и удалить SAML-приложение в Yandex Identity Hub


Управлять SAML-приложениями может пользователь, которому назначена [роль](../../security/index.md#organization-manager-samlApplications-admin) `organization-manager.samlApplications.admin` или выше.

## Деактивируйте приложение {#deactivate}

Если вам требуется временно отключить возможность аутентификации пользователей вашей [организации](../../concepts/organization.md) во внешнем приложении с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), деактивируйте соответствующее [SAML-приложение](../../concepts/applications.md#saml) в Yandex Identity Hub:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
  1. В строке с SAML-приложением, которое вы хотите деактивировать, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pause](../../../_assets/console-icons/pause.svg) **Деактивировать**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

Если вам требуется восстановить возможность аутентификации пользователей вашей организации во внешнем приложении с помощью SAML-стандарта единого входа, активируйте соответствующее SAML-приложение в Yandex Identity Hub:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
  1. В строке с SAML-приложением, которое вы хотите активировать, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrows-rotate-right](../../../_assets/console-icons/arrows-rotate-right.svg) **Активировать**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
  1. В строке с SAML-приложением, которое вы хотите удалить, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления SAML-приложения:

     ```bash
     yc organization-manager idp application saml application delete --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp application saml application delete <идентификатор_приложения>
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием SAML-приложения:

     Пример описания SAML-приложения в конфигурации Terraform

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

     Проверить удаление ресурсов можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization).

- API {#api}

  Воспользуйтесь методом REST API [Application.Delete](../../idp/application/saml/api-ref/Application/delete.md) для ресурса [Application](../../idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Delete](../../idp/application/saml/api-ref/grpc/Application/delete.md).

{% endlist %}

В результате SAML-приложение будет удалено, а пользователи навсегда потеряют возможность аутентификации с его помощью во внешнем приложении.

#### См. также {#see-also}

* [Создать SAML-приложение в Yandex Identity Hub](saml-create.md)
* [Изменить SAML-приложение в Yandex Identity Hub](saml-update.md)
* [Добавить пользователя](../add-account.md)
* [SAML-приложения](../../concepts/applications.md#saml)
* [Управление группами пользователей](../manage-groups.md)