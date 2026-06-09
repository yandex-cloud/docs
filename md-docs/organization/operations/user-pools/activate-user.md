# Активировать пользователя

Вы можете активировать пользователей, которые ранее были [деактивированы](deactivate-user.md). После активации пользователи вновь получают доступ к тем ресурсам организации, на которые им назначены [права доступа](../../../iam/concepts/access-control/roles.md).

{% note info %}

Вы можете активировать и деактивировать только [федеративных](../../../iam/concepts/users/accounts.md#saml-federation) и [локальных](../../../iam/concepts/users/accounts.md#local) пользователей. Пользователей с [аккаунтом на Яндексе](../../../iam/concepts/users/accounts.md#passport) активировать и деактивировать нельзя.

{% endnote %}

## Активировать федеративного пользователя {#activate-federated}

Чтобы активировать аккаунт федеративного пользователя:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![icon-users](../../../_assets/console-icons/person.svg) **Пользователи** и найдите нужного федеративного или локального пользователя.
  
      При необходимости воспользуйтесь строкой поиска или фильтром вверху страницы.
  1. В строке с нужным пользователем нажмите значок ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) и выберите ![face-smile](../../../_assets/console-icons/face-smile.svg) **Активировать**.
  1. В появившемся окне подтвердите активацию.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для активации федеративных пользователей:

     ```bash
     yc organization-manager federation saml reactivate-user-accounts --help
     ```

  1. Получите список федераций в организации:

     ```bash
     yc organization-manager federation saml list \
       --organization-id <идентификатор_организации>
     ```

     Где `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно получить список федераций.

  1. Получите список деактивированных пользователей федерации:

     ```bash
     yc organization-manager federation saml list-user-accounts <идентификатор_федерации> \
       --organization-id <идентификатор_организации> \
       --filter active=false
     ```

     Где:

     * `<идентификатор_федерации>` — идентификатор федерации, в которой нужно получить список пользователей.
     * `--organization-id` — идентификатор организации, в которой находится федерация.
     * `--filter active=false` — фильтр для получения только деактивированных пользователей.

  1. Чтобы активировать пользователей, передайте их идентификаторы в команде:

     ```bash
     yc organization-manager federation saml reactivate-user-accounts <идентификатор_федерации> \
       --subject-ids <идентификатор_пользователя_1>,<идентификатор_пользователя_2>,...,<идентификатор_пользователя_N> \
       --organization-id <идентификатор_организации>
     ```

     Где:
     
     * `<идентификатор_федерации>` — идентификатор федерации, в которой нужно активировать пользователей.
     * `--subject-ids` — список идентификаторов пользователей, которых необходимо активировать.
     * `--organization-id` — идентификатор организации, в которой находится федерация.

- API {#api}

  Воспользуйтесь методом REST API [Federation.Reactivate](../../saml/api-ref/Federation/reactivateUserAccounts.md) для ресурса [Federation](../../saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/Reactivate](../../saml/api-ref/grpc/Federation/reactivateUserAccounts.md).

{% endlist %}


## Активировать локального пользователя {#activate-local}


Чтобы активировать аккаунт локального пользователя:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![icon-users](../../../_assets/console-icons/person.svg) **Пользователи** и найдите нужного федеративного или локального пользователя.
  
      При необходимости воспользуйтесь строкой поиска или фильтром вверху страницы.
  1. В строке с нужным пользователем нажмите значок ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) и выберите ![face-smile](../../../_assets/console-icons/face-smile.svg) **Активировать**.
  1. В появившемся окне подтвердите активацию.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для активации пользователя [пула](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user reactivate --help
     ```
  1. Чтобы получить список пулов в организации, передайте ее [идентификатор](../organization-get-id.md) в команде:
     
     ```bash
     yc organization-manager idp userpool list \
       --organization-id <идентификатор_организации>
     ```
     
     Результат:
     
     ```text
     +----------------------+--------------+-------------+----------------------+---------------------+
     |          ID          |     NAME     | DESCRIPTION |   ORGANIZATION ID    |     CREATED AT      |
     +----------------------+--------------+-------------+----------------------+---------------------+
     | ek0o6g0irskn******** | sample-pool1 |             | bpf2c65rqcl8******** | 2025-05-17 10:01:04 |
     | ek03mf01jr4z******** | sample-pool2 |             | bpf2c65rqcl8******** | 2025-06-28 16:30:23 |
     +----------------------+--------------+-------------+----------------------+---------------------+
     ```
  1. Чтобы получить идентификаторы и другую информацию о пользователях пула, передайте его идентификатор в команде:
     
     ```bash
     yc organization-manager idp user list \
       --userpool-id <идентификатор_пула_пользователей>
     ```
     
     Результат:
     
     ```text
     +----------------------+----------------------------------------+-----------+----------------------+-----------+---------------------+
     |          ID          |                USERNAME                | FULL NAME |     USERPOOL ID      | IS ACTIVE |     CREATED AT      |
     +----------------------+----------------------------------------+-----------+----------------------+-----------+---------------------+
     | aje3i1gq49n3******** | test-user1@test.ru.idp.yandexcloud.net | User 1    | ek0o6g0irskn******** | true      | 2025-10-07 10:41:54 |
     | aje0j5mts02t******** | test-user2@test.ru.idp.yandexcloud.net | User 2    | ek0o6g0irskn******** | false     | 2025-07-16 11:18:57 |
     +----------------------+----------------------------------------+-----------+----------------------+-----------+---------------------+
     ```
  1. Чтобы активировать пользователя, передайте его идентификатор в команде:

     ```bash
     yc organization-manager idp user reactivate <идентификатор_пользователя>
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры пользователя:

     ```hcl
     resource "yandex_organizationmanager_idp_user" "example_user" {
       userpool_id = "<идентификатор_пула>"
       username    = "<имя_пользователя>"
       full_name   = "<полное_имя_пользователя>"
       is_active   = true
     }
     ```

     Где:
     
     * `userpool_id` — идентификатор пула, в котором находится нужный пользователь.
     * `username` — имя нужного пользователя.
     * `full_name` — полное имя нужного пользователя.
     * `is_active` — флаг активации. Укажите `true`, чтобы активировать пользователя.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_user` см. в [документации провайдера](../../../terraform/resources/organizationmanager_idp_user.md).

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

     Terraform создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc organization-manager idp user get <идентификатор_пользователя>
     ```

- API {#api}

  Воспользуйтесь методом REST API [User.Reactivate](../../idp/api-ref/User/reactivate.md) для ресурса [User](../../idp/api-ref/User/index.md) или вызовом gRPC API [UserService/Reactivate](../../idp/api-ref/grpc/User/reactivate.md).

{% endlist %}

#### См. также {#see-also}

* [Деактивировать пользователя](deactivate-user.md)