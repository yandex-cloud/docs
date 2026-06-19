# Получить информацию об SAML-приложении в Yandex Identity Hub


{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
  1. Нажмите на строку с [SAML-приложением](../../concepts/applications.md#saml), о котором вы хотите получить информацию.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации об [SAML-приложении](../../concepts/applications.md#saml):

     ```bash
     yc organization-manager idp application saml application get --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp application saml application get <идентификатор_приложения>
     ```

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: saml-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

     ```hcl
     data "yandex_organizationmanager_idp_application_saml_application" "saml_app" {
       application_id = "some_application_id"
     }
     
     output "my_saml_app.name" {
       value = data.yandex_organizationmanager_idp_application_saml_application.saml_app.name
     }
     
     output "my_saml_app.organization_id" {
       value = data.yandex_organizationmanager_idp_application_saml_application.saml_app.organization_id
     }
     
     output "my_saml_app.status" {
       value = data.yandex_organizationmanager_idp_application_saml_application.saml_app.status
     }
     ```

     Где:

     * `data "yandex_organizationmanager_idp_application_saml_application"` — описание SAML-приложения в качестве источника данных:
       * `application_id` — идентификатор приложения.
     * `output` — выходные переменные, которые содержат информацию о приложении:
       * `value` — возвращаемое значение.

     Вместо указанных параметров вы можете выбрать любые другие для получения информации. Подробнее о параметрах источника данных `yandex_organizationmanager_idp_application_saml_application` читайте в [документации провайдера](../../../terraform/data-sources/organizationmanager_idp_application_saml_application.md).

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Terraform создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

- API {#api}

  Воспользуйтесь методом REST API [Application.Get](../../idp/application/saml/api-ref/Application/get.md) для ресурса [Application](../../idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Get](../../idp/application/saml/api-ref/grpc/Application/get.md).

{% endlist %}