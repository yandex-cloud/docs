[Документация Yandex Cloud](../../../index.md) > [Yandex Identity Hub](../../index.md) > [Пошаговые инструкции](../index.md) > Аутентификация > Управление MFA > Управлять исключениями политики MFA

# Управлять исключениями политики MFA

Исключения позволяют не применять [политику MFA](../../concepts/mfa.md#mfa-policies) к отдельным пользователям или [группам пользователей](../../concepts/groups.md), добавленным в целевую группу этой политики. Например, можно исключить роботов или группу администраторов, если политика назначена на всю организацию. Этим пользователям или группам не придется заново настраивать аутентификацию, если вы уберете их из списка исключений.

## Изменить список исключений {#update}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **Настройки безопасности**.
  1. Перейдите на вкладку **Политики MFA** и в списке политик выберите нужную. В открывшемся окне:

      1. Перейдите на вкладку **Исключения**.
      1. Чтобы добавить пользователя или группу пользователей в список исключений:

          1. Нажмите кнопку ![person-plus](../../../_assets/console-icons/person-plus.svg) **Добавить исключение**.
          1. В открывшемся окне выберите нужного пользователя или группу пользователей.
          1. Нажмите кнопку **Добавить**.
      1. Чтобы удалить пользователя или группу из списка исключений:
          1. В списке пользователей и групп в строке с нужным пользователем или группой нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
          1. Подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите список пользователей или групп, к которым применяется политика MFA:

     ```bash
     yc organization-manager mfa-enforcement list-audience \
       --id <идентификатор_политики>
     ```

  1. Посмотрите описание команды CLI для изменения списка исключений политики MFA:

     ```bash
     yc organization-manager mfa-enforcement update-excluded-audience --help
     ```

  1. Чтобы добавить пользователей или группы пользователей в список исключений политики MFA, выполните команду:

     ```bash
     yc organization-manager mfa-enforcement update-excluded-audience \
       --id <идентификатор_политики> \
       --audience-delta subject-id=<идентификатор_субъекта>,action=<действие>
     ```

     Где:

     * `--audience-delta` — параметр для изменения списка пользователей/групп в политике:
       * `subject-id` — идентификатор пользователя или группы.
       * `action` — действие: `action-add` — добавить, `action-remove` — удалить.

     Можно указать несколько параметров `--audience-delta` для одновременного добавления или удаления нескольких объектов.

     Результат:

      ```text
      mfa_enforcement_id: bpfjv8qeq4ii********
      effective_deltas:
        - action: ACTION_ADD
          subject_id: aje0j5mts02t********
      ```

- API {#api}

  Воспользуйтесь методом REST API [UpdateExcludedAudience](../../api-ref/MfaEnforcement/updateExcludedAudience.md) для ресурса [MfaEnforcement](../../api-ref/MfaEnforcement/index.md) или вызовом gRPC API [MfaEnforcementService/UpdateExcludedAudience](../../api-ref/grpc/MfaEnforcement/updateExcludedAudience.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Добавьте отдельный ресурс для каждого исключаемого пользователя или группы:

      ```hcl
      resource "yandex_organizationmanager_mfa_enforcement_excluded_audience" "exception" {
        mfa_enforcement_id = "<идентификатор_политики>"
        subject_id        = "<идентификатор_пользователя_или_группы>"
      }
      ```

      Подробная информация приведена в [документации провайдера](../../../terraform/resources/organizationmanager_mfa_enforcement_excluded_audience.md).

      Чтобы удалить управляемое этой конфигурацией исключение, удалите соответствующий блок ресурса. Саму политику MFA удалять не нужно.
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

{% endlist %}

## Посмотреть список исключений {#list}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **Настройки безопасности**.
  1. Перейдите на вкладку **Политики MFA** и в списке политик выберите нужную.
  1. В открывшемся окне перейдите на вкладку **Исключения** и просмотрите список пользователей и групп, исключенных из политики.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите список пользователей или групп, к которым применяется политика MFA:

     ```bash
     yc organization-manager mfa-enforcement list-excluded-audience \
       --id <идентификатор_политики>
     ```

     Результат:

      ```text
      +----------------------+---------------+
      |          ID          |     TYPE      |
      +----------------------+---------------+
      | aje0j5mts02t******** | federatedUser |
      +----------------------+---------------+
      ```

- API {#api}

  Воспользуйтесь методом REST API [ListExcludedAudience](../../api-ref/MfaEnforcement/listExcludedAudience.md) для ресурса [MfaEnforcement](../../api-ref/MfaEnforcement/index.md) или вызовом gRPC API [MfaEnforcementService/ListExcludedAudience](../../api-ref/grpc/MfaEnforcement/listExcludedAudience.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Применить политику MFA к пользователям](add-users.md)
* [Создать политику MFA](create-policy.md)
* [Изменить политику MFA](update-policy.md)
* [Активировать и деактивировать политику MFA](deactivate-reactivate-policy.md)
* [Удалить политику MFA](delete-policy.md)
* [Удалить MFA-фактор и сбросить дату верификации](manage-verification.md)
* [Многофакторная аутентификация в Yandex Identity Hub](../../concepts/mfa.md)