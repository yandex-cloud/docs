# Активировать и деактивировать политику MFA

## Активируйте политику MFA {#reactivate-policy}

Чтобы активировать неактивную [политику MFA](../../concepts/mfa.md#mfa-policies):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}**.
  1. В списке политик MFA в строке с нужной политикой нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrows-rotate-right](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud_org.organization.security-settings.mfa-overview-action-activate }}**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для активации политики MFA:

     ```bash
     yc organization-manager mfa-enforcement activate --help
     ```

  1. Чтобы активировать политику MFA, выполните команду:

     ```bash
     yc organization-manager mfa-enforcement activate \
       --id <идентификатор_политики>
     ```

     Где `--id` — идентификатор политики MFA, которую нужно активировать.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте конфигурационный файл {{ TF }} и измените параметр `status` ресурса `yandex_organizationmanager_mfa_enforcement`:

     ```hcl
     resource "yandex_organizationmanager_mfa_enforcement" "example_mfa_policy" {
       name            = "<имя_политики>"
       organization_id = "<идентификатор_организации>"
       acr_id          = "<тип_фактора_аутентификации>"
       ttl             = "<время_жизни>"
       status          = "MFA_ENFORCEMENT_STATUS_ACTIVE"
       apply_at        = "<время_активации>"
       enroll_window   = "<срок_создания>"
       description     = "<описание_политики>"
     }
     ```

     Где `status` — статус политики: `MFA_ENFORCEMENT_STATUS_ACTIVE` для активации политики. Необязательный параметр.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_mfa_enforcement` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_mfa_enforcement).

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     {{ TF }} активирует политику MFA. Проверить изменение статуса политики MFA можно в интерфейсе [{{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc organization-manager mfa-enforcement get <идентификатор_политики>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Activate](../../api-ref/MfaEnforcement/activate.md) для ресурса [MfaEnforcement](../../api-ref/MfaEnforcement/index.md) или вызовом gRPC API [MfaEnforcementService/Activate](../../api-ref/grpc/MfaEnforcement/activate.md).

{% endlist %}

В результате политика MFA будет активирована и перейдет в статус `Active`, а к учетным записям пользователей, добавленных в целевые группы политики, начнут применяться требования этой политики по использованию дополнительного фактора аутентификации.

## Деактивируйте политику MFA {#deactivate-policy}

Чтобы временно деактивировать [политику MFA](../../concepts/mfa.md#mfa-policies):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_mfa_policies_m8oE3 }}**.
  1. В списке политик MFA в строке с нужной политикой нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pause](../../../_assets/console-icons/pause.svg) **{{ ui-key.yacloud_org.organization.security-settings.mfa-overview-action-suspend }}**.
  1. В открывшемся окне подтвердите действие.

- CLI {#cli}

  1. Посмотрите описание команды CLI для деактивации политики MFA:

     ```bash
     yc organization-manager mfa-enforcement deactivate --help
     ```

  1. Чтобы деактивировать политику MFA, выполните команду:

     ```bash
     yc organization-manager mfa-enforcement deactivate \
       --id <идентификатор_политики>
     ```

     Где `--id` — идентификатор политики MFA, которую нужно деактивировать.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте конфигурационный файл {{ TF }} и измените параметр `status` ресурса `yandex_organizationmanager_mfa_enforcement`:

     ```hcl
     resource "yandex_organizationmanager_mfa_enforcement" "example_mfa_policy" {
       name            = "<имя_политики>"
       organization_id = "<идентификатор_организации>"
       acr_id          = "<тип_фактора_аутентификации>"
       ttl             = "<время_жизни>"
       status          = "MFA_ENFORCEMENT_STATUS_INACTIVE"
       apply_at        = "<время_активации>"
       enroll_window   = "<срок_создания>"
       description     = "<описание_политики>"
     }
     ```

     Где `status` — статус политики: `MFA_ENFORCEMENT_STATUS_INACTIVE` для деактивации политики. Необязательный параметр.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_mfa_enforcement` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_mfa_enforcement).

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     {{ TF }} деактивирует политику MFA. Проверить изменение статуса политики MFA можно в интерфейсе [{{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc organization-manager mfa-enforcement get <идентификатор_политики>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Deactivate](../../api-ref/MfaEnforcement/deactivate.md) для ресурса [MfaEnforcement](../../api-ref/MfaEnforcement/index.md) или вызовом gRPC API [MfaEnforcementService/Deactivate](../../api-ref/grpc/MfaEnforcement/deactivate.md).

{% endlist %}

В результате политика MFA будет деактивирована и перейдет в статус `Inactive`, а к учетным записям пользователей, добавленных в целевые группы политики, перестанут применяться требования этой политики по использованию дополнительного фактора аутентификации.

Если требуется временно вывести из-под действия политики только отдельных пользователей или группы, не деактивируя политику целиком, воспользуйтесь [исключениями политики MFA](excluded-audience.md).

#### См. также {#see-also}

* [{#T}](create-policy.md)
* [{#T}](update-policy.md)
* [{#T}](add-users.md)
* [{#T}](excluded-audience.md)
* [{#T}](delete-policy.md)
* [{#T}](manage-verification.md)
* [{#T}](../../concepts/mfa.md)