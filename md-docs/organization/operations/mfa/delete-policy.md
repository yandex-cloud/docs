# Удалить политику MFA

Чтобы удалить [политику MFA](../../concepts/mfa.md#mfa-policies):

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **Настройки безопасности**.
  1. Перейдите на вкладку **Политики MFA**.
  1. В списке политик MFA в строке с нужной политикой нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте конфигурационный файл Terraform и удалите фрагмент с описанием политики MFA:

     ```hcl
     resource "yandex_organizationmanager_mfa_enforcement" "example_mfa_policy" {
       name            = "<имя_политики>"
       organization_id = "<идентификатор_организации>"
       acr_id          = "<тип_фактора_аутентификации>"
       ttl             = "<время_жизни>"
       status          = "<статус_политики>"
       apply_at        = "<время_активации>"
       enroll_window   = "<срок_создания>"
       description     = "<описание_политики>"
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_mfa_enforcement` см. в [документации провайдера](../../../terraform/resources/organizationmanager_mfa_enforcement.md).

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

     Terraform удалит политику MFA. Проверить удаление политики MFA можно в интерфейсе [Cloud Center](https://center.yandex.cloud/organization) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc organization-manager mfa-enforcement list --organization-id <идентификатор_организации>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Delete](../../api-ref/MfaEnforcement/delete.md) для ресурса [MfaEnforcement](../../api-ref/MfaEnforcement/index.md) или вызовом gRPC API [MfaEnforcementService/Delete](../../api-ref/grpc/MfaEnforcement/delete.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Создать политику MFA](create-policy.md)
* [Изменить политику MFA](update-policy.md)
* [Применить политику MFA к пользователям](add-users.md)
* [Управлять исключениями политики MFA](excluded-audience.md)
* [Активировать и деактивировать политику MFA](deactivate-reactivate-policy.md)
* [Удалить MFA-фактор и сбросить дату верификации](manage-verification.md)
* [Многофакторная аутентификация в Yandex Identity Hub](../../concepts/mfa.md)