# Применить политику MFA к пользователям

Чтобы [политика MFA](../../concepts/mfa.md#mfa-policies) применялась в отношении учетных записей пользователей, в целевые группы этой политики требуется явно добавить нужных пользователей или [группы](../../concepts/groups.md), в которые эти пользователи входят.

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **Настройки безопасности**.
  1. Перейдите на вкладку **Политики MFA** и в списке политик выберите нужную. В открывшемся окне:

      1. Перейдите на вкладку **Пользователи и группы**.
      1. Чтобы добавить в целевые группы политики нового пользователя или группу:

          1. Нажмите кнопку ![person-plus](../../../_assets/console-icons/person-plus.svg) **Добавить пользователей**.
          1. В открывшемся окне выберите нужного пользователя или группу пользователей.
          1. Нажмите кнопку **Добавить**.
      1. Чтобы удалить из политики пользователя или группу:
          1. В списке пользователей и групп в строке с нужным пользователем или группой нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
          1. Подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите список пользователей или групп, к которым применяется политика MFA:

     ```bash
     yc organization-manager mfa-enforcement list-audience \
       --id <идентификатор_политики>
     ```

  1. Посмотрите описание команды CLI для изменения списка пользователей или групп, к которым применяется политика MFA:

     ```bash
     yc organization-manager mfa-enforcement update-audience --help
     ```

  1. Чтобы добавить пользователей или группы в политику MFA или удалить их из политики, выполните команду:

     ```bash
     yc organization-manager mfa-enforcement update-audience \
       --id <идентификатор_политики> \
       --audience-delta subject-id=<идентификатор_субъекта>,action=<действие>
     ```

     Где:

     * `--audience-delta` — параметр для изменения списка пользователей/групп в политике:
       * `subject-id` — идентификатор пользователя или группы.
       * `action` — действие: `action-add` — добавить, `action-remove` — удалить.

     Можно указать несколько параметров `--audience-delta` для одновременного изменения нескольких объектов.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Чтобы добавить пользователя или группу в политику MFA, опишите в конфигурационном файле параметры ресурса `yandex_organizationmanager_mfa_enforcement_audience`:

     ```hcl
     resource "yandex_organizationmanager_mfa_enforcement_audience" "example_mfa_audience" {
       mfa_enforcement_id = "<идентификатор_политики_MFA>"
       subject_id         = "<идентификатор_пользователя_или_группы>"
     }
     ```

     Где:

     * `mfa_enforcement_id` — идентификатор политики MFA, к которой нужно добавить пользователя или группу. Обязательный параметр.
     * `subject_id` — идентификатор пользователя или группы, которые нужно добавить в политику MFA. Обязательный параметр.

     Чтобы добавить несколько пользователей или групп, создайте отдельный ресурс `yandex_organizationmanager_mfa_enforcement_audience` для каждого из них.

     Подробнее о параметрах ресурса `yandex_organizationmanager_mfa_enforcement_audience` читайте в [документации провайдера](../../../terraform/resources/organizationmanager_mfa_enforcement_audience.md).

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

     Terraform создаст все требуемые ресурсы. Проверить добавление пользователей в политику MFA можно в интерфейсе [Cloud Center](https://center.yandex.cloud/organization) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc organization-manager mfa-enforcement list-audience --id <идентификатор_политики>
     ```

  1. Чтобы удалить пользователя или группу из политики MFA, удалите соответствующий ресурс `yandex_organizationmanager_mfa_enforcement_audience` из конфигурационного файла и примените изменения.

- API {#api}

  Воспользуйтесь методом REST API [UpdateAudience](../../api-ref/MfaEnforcement/updateAudience.md) для ресурса [MfaEnforcement](../../api-ref/MfaEnforcement/index.md) или вызовом gRPC API [MfaEnforcementService/UpdateAudience](../../api-ref/grpc/MfaEnforcement/updateAudience.md).

{% endlist %}

Если удалить пользователя или группу из политики MFA, то в случае повторного добавления им придется заново настраивать аутентификацию. Вместо этого вы можете добавить пользователя или группу в [исключения политики](excluded-audience.md).

{% note info %}

В целевые группы политики MFA вы можете добавлять [пользовательские аккаунты](../../../iam/concepts/users/accounts.md) любого типа, но применяться политика будет только к [федеративным](../../../iam/concepts/users/accounts.md#saml-federation) и [локальным](../../../iam/concepts/users/accounts.md#local) аккаунтам пользователей.

Если участниками группы, добавленной в политику MFA, являются пользователи с аккаунтами различных типов, эта политика будет применяться только к пользователям с федеративными и локальными аккаунтами.

{% endnote %}

#### Полезные ссылки {#see-also}

* [Управлять исключениями политики MFA](excluded-audience.md)
* [Создать политику MFA](create-policy.md)
* [Изменить политику MFA](update-policy.md)
* [Активировать и деактивировать политику MFA](deactivate-reactivate-policy.md)
* [Удалить политику MFA](delete-policy.md)
* [Удалить MFA-фактор и сбросить дату верификации](manage-verification.md)
* [Многофакторная аутентификация в Yandex Identity Hub](../../concepts/mfa.md)