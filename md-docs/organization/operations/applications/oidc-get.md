# Получить информацию об OIDC-приложении в {{ org-full-name }}


{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. Нажмите на строку с [OIDC-приложением](../../concepts/applications.md#oidc), о котором вы хотите получить информацию.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

- API {#api}

  Воспользуйтесь методом REST API [Application.Get](../../idp/application/oauth/api-ref/Application/get.md) для ресурса [Application](../../idp/application/oauth/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Get](../../idp/application/oauth/api-ref/grpc/Application/get.md).

{% endlist %}