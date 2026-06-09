# Добавить пользователя

# Добавить пользователя в организацию

Добавьте пользователя в [организацию](../../overview/roles-and-resources.md) и [назначьте](../../iam/operations/roles/grant.md) ему подходящую [роль](../../iam/concepts/access-control/roles.md), чтобы предоставить доступ к ресурсам {{ yandex-cloud }}. Например, роли необходимы, чтобы пользователь мог создавать кластеры управляемой базы данных или следить за состоянием используемых виртуальных машин.

Добавить в организацию можно [пользователей с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport), [федеративных пользователей](../../iam/concepts/users/accounts.md#saml-federation) и [локальных пользователей](../../iam/concepts/users/accounts.md#local). В результате добавленные пользователи станут участниками организации, и вы сможете назначить им роли. Пока пользователю организации не назначены роли, он не имеет доступа к ресурсам в облаках этой организации. О том, как назначить пользователю роль, читайте в разделе [{#T}](../../iam/operations/roles/grant.md).

Чтобы добавлять пользователей в организацию, нужно быть администратором (роль `organization-manager.admin`) или владельцем (роль `organization-manager.organizations.owner`) этой организации, либо иметь роль администратора того типа пользовательских аккаунтов, которые требуется добавить.

{% note info %}

Для доступа пользователя к [консоли управления]({{ link-console-main }}), назначьте ему роль на [облако](../security/index.md#access-binding-cloud) или [организацию](../security/index.md#access-binding-organization). Для безопасности вы можете назначить одну из ролей с минимальными привилегиями, например `resource-manager.clouds.member`, но также можно назначить и другие роли, если вы знаете, какие права вы хотите предоставить приглашенным пользователям.

Чтобы дать эти права сразу всем пользователям в организации, назначьте роль [системной группе](../../iam/concepts/access-control/system-group.md#allOrganizationUsers) `All users in organization X`. При работе с CLI или API назначение дополнительных ролей не требуется.

{% endnote %}

## Пользователи с аккаунтом на Яндексе {#useraccount}

## Пользователи с аккаунтом на Яндексе {#useraccount}

Если у сотрудников компании есть аккаунты на Яндексе (например, `{{ login-example }}`), они могут использовать эти аккаунты для доступа к сервисам {{ yandex-cloud }}, подключенным к вашей организации.

Пользователя можно пригласить в организацию через консоль управления или интерфейс {{ cloud-center }}. Приглашение присоединиться к организации направляется пользователю на электронную почту.

Приглашать в организацию новых пользователей с аккаунтом на Яндексе и удалять такие приглашения могут пользователи с любой из следующих [ролей](../security/index.md): `organization-manager.passportUserAdmin`, `organization-manager.admin` или `organization-manager.organizations.owner`.

{% note info %}

Приглашение в организацию пользователей с аккаунтом на Яндексе может быть запрещено [политикой авторизации](../../iam/concepts/access-control/access-policies.md) `organization.denyMemberInvitation`, назначенной на [организацию](../concepts/organization.md).

{% endnote %}

### Отправьте приглашение {#send-invitation}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  
  1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.
  
  1. В правом верхнем углу экрана нажмите кнопку ![person-plus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.page.users.dropdown.button-text }}** и в выпадающем списке выберите ![person-planet-earth](../../_assets/console-icons/person-planet-earth.svg) **{{ ui-key.yacloud_org.page.users.action.invite-users }}**.
  
  1. Введите почтовые адреса пользователей, которых вы хотите пригласить в организацию (например, `{{ login-example }}`).
  
      Приглашения можно отправлять на любые адреса электронной почты. Приглашенный пользователь сможет выбрать нужный аккаунт на Яндексе, когда примет приглашение.
  
  1. Нажмите кнопку **{{ ui-key.yacloud_components.organization.action_send-invitation }}**.

- Консоль управления {#console}

    1. Войдите в [консоль управления]({{ link-console-main }}) с учетной записью администратора облака.

    1. На панели сверху нажмите ![image](../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../_assets/console-icons/chevron-down.svg) и выберите нужное облако.

    1. В правом верхнем углу экрана нажмите на значок ![icon-users](../../_assets/console-icons/ellipsis.svg) и выберите ![person-plus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud.common.resource-acl.button_invite-users }}**.

    1. Введите почтовые адреса пользователей, которых вы хотите пригласить в организацию (например, `{{ login-example }}`).

        Приглашения можно отправлять на любые адреса электронной почты. Приглашенный пользователь сможет выбрать нужный аккаунт на Яндексе, когда примет приглашение.

    1. Нажмите **{{ ui-key.yacloud_components.organization.action_send-invitation }}**.

{% endlist %}

Пользователь сможет войти в организацию, как только примет приглашение по ссылке из письма и выберет подходящий аккаунт для входа. Для доступа к сервисам, которые подключены к организации, приглашенным пользователям достаточно войти в свой аккаунт на Яндексе.

Удалить приглашение или отправить приглашение повторно можно только в сервисе {{ org-full-name }}.

### Удалите приглашение {#delete-invitation}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.

  1. В центральной части экрана выберите вкладку **{{ ui-key.yacloud_org.users.title_invitations }}**.

  1. В строке с нужным приглашением нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.entity.invitation.label_row-action-delete }}**.

  1. В открывшемся окне подтвердите удаление.

{% endlist %}

### Отправьте приглашение повторно {#resend-invitation}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.

  1. В центральной части экрана выберите вкладку **{{ ui-key.yacloud_org.users.title_invitations }}**.

  1. В строке с нужным приглашением нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.entity.invitation.label_row-action-resend }}**.

  1. В открывшемся окне подтвердите повторную отправку приглашения.

{% endlist %}

{% note info %}

Чтобы усилить защиту ваших ресурсов от несанкционированного доступа:

1. Включите для своего аккаунта на Яндексе [двухфакторную аутентификацию](https://yandex.ru/support/passport/authorization/twofa.html).
1. Попросите всех пользователей, которых вы добавляете в организацию, также включить двухфакторную аутентификацию.
1. В настройках безопасности организации [включите требование двухфакторной аутентификации](enable-2fa-access.md). Это позволит предоставить доступ к ресурсам только для тех пользователей, у кого включена двухфакторная аутентификация.

{% endnote %}

## Федеративные пользователи {#user-sso}

## Федеративные пользователи {#user-sso}

Если при [настройке федерации](../concepts/add-federation.md#federation-usage) вы не включили опцию **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}**, федеративных пользователей нужно добавить в организацию вручную.

Для этого необходимо знать Name ID пользователей, который вместе с ответом об успешной аутентификации возвращает сервер поставщика удостоверений (IdP). Обычно это электронная почта пользователя. Чтобы узнать, что возвращается в качестве Name ID, обратитесь к администратору, который настраивал аутентификацию в вашей федерации.

При включенной опции **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** в федерацию будут добавлены только пользователи, которые впервые авторизуются в облаке. Если федеративный пользователь был удален, добавить его повторно можно только вручную.

Федеративных пользователей не нужно отдельно приглашать в организацию, они добавляются автоматически после первой аутентификации.

Добавлять в организацию федеративных пользователей и удалять их могут пользователи с любой из следующих [ролей](../security/index.md): `organization-manager.federations.userAdmin`, `organization-manager.federations.admin`, `organization-manager.admin` или `organization-manager.organizations.owner`.

### Добавьте федеративных пользователей {#add-user-sso}

### Добавьте федеративных пользователей {#add-user-sso}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    
    1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.
    
    1. В правом верхнем углу нажмите кнопку ![person-plus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.page.users.dropdown.button-text }}** и в выпадающем списке выберите ![key](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud_org.page.users.action.add-federated-users }}**.
    
    1. В поле **{{ ui-key.yacloud_org.form.users.federated.add.field.federation }}** выберите федерацию удостоверений, из которой необходимо добавить пользователей.
    
    1. В поле **{{ ui-key.yacloud_org.form.users.federated.add.field.users }}** перечислите Name ID пользователей, разделяя их пробелами или переносами строк.
    
    1. Нажмите **{{ ui-key.yacloud_components.organization.action.add }}**. Пользователи будут подключены к организации.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Посмотрите описание команды добавления пользователей:

        ```bash
        yc organization-manager federation saml add-user-accounts --help
        ```

    1. Добавьте пользователей, перечислив их Name ID через запятую:

        ```bash
        yc organization-manager federation saml add-user-accounts \
           --name <имя_федерации> \
           --name-ids <список_Name_ID_пользователей>
        ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_organizationmanager_saml_federation_user_account" "some_account" {
        federation_id = "<идентификатор_федерации>"
        name_id       = "<Name_ID_пользователя>"
      }
      ```

      Где:
      * `federation_id` — идентификатор федерации для добавления пользователя.
      * `name_id` — Name ID пользователя.

      Более подробную информацию о параметрах ресурса `yandex_organizationmanager_saml_federation_user_account` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_saml_federation_user_account).

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

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../cli/index.md):

      ```bash
      yc organization-manager federations saml \
        --organization-id <идентификатор_организации> list-user-accounts \
        --id <идентификатор_федерации>
      ```

- API {#api}

  Воспользуйтесь методом REST API [addUserAccounts](../saml/api-ref/Federation/addUserAccounts.md) для ресурса [Federation](../saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/AddUserAccounts](../saml/api-ref/grpc/Federation/addUserAccounts.md) и передайте в запросе:

  * Идентификатор федерации в параметре `federationId`.
  * Список Name ID пользователей в параметре `nameIds`.

{% endlist %}

{% note info %}

[Атрибуты](setup-federation.md#claims-mapping) федеративного пользователя загружаются в его профиль в [организации](../concepts/organization.md) {{ org-full-name }} после первой аутентификации этого пользователя в {{ yandex-cloud }}.

{% endnote %}

## Локальные пользователи {#local-users}

## Локальные пользователи {#local-users}

[Локальных пользователей](../../iam/concepts/users/accounts.md#local) необходимо добавлять в организацию вручную. При этом каждому пользователю присваивается имя пользователя, уникальное для выбранного [пула пользователей](../concepts/user-pools.md).

Добавлять в организацию локальных пользователей и удалять их могут пользователи с любой из следующих [ролей](../security/index.md): `organization-manager.userpools.userAdmin`, `organization-manager.userpools.admin`, `organization-manager.admin` или `organization-manager.organizations.owner`.

### Добавьте локальных пользователей {#add-local-user}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![userpool](../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный [пул пользователей](../concepts/user-pools.md).
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.userpools.title_userpool_members }}** и нажмите кнопку ![person-plus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.userpools.action_create-user }}**.
  1. В поле **{{ ui-key.yacloud_org.organization.userpools.field_username }}** введите логин пользователя и выберите [домен](../concepts/domains.md) из списка. Логин должен быть уникальным для данного пула пользователей.
  
      Если нужного домена нет, [создайте новый](user-pools/add-domain.md).
  1. В поле **{{ ui-key.yacloud_org.organization.userpools.field_full-name }}** укажите имя и фамилию пользователя в произвольном формате.  
  1. (Опционально) Добавьте адрес электронной почты пользователя.
  1. В поле **{{ ui-key.yacloud_org.organization.userpools.field_password }}** вы можете посмотреть автоматически сгенерированный пароль пользователя и сгенерировать новый пароль.
  
      Пользователь должен будет изменить этот пароль при первом входе в {{ yandex-cloud }}.
  1. Включите опцию **{{ ui-key.yacloud_org.organization.userpools.field_active }}**, если нужно активировать пользователя сразу после добавления. Активированные пользователи получают доступ к ресурсам организации.
  1. (Опционально) Разверните блок **{{ ui-key.yacloud_org.organization.userpools.title_personal-info }}** и укажите имя, фамилию и номер телефона пользователя.
  1. (Опционально) Разверните блок **Организационная информация** и укажите название компании, подразделение, должность и табельный номер пользователя.
  1. Нажмите **{{ ui-key.yacloud_org.organization.userpools.action_create-user }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для добавления пользователя в [пул](../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user create --help
     ```
  1. Чтобы получить список пулов в организации, передайте ее [идентификатор](organization-get-id.md) в команде:
     
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
  1. Чтобы создать нового пользователя, выполните команду:

     ```bash
     yc organization-manager idp user create \
       --userpool-id <идентификатор_пула> \
       --username <логин_и_домен> \
       --full-name <имя_и_фамилия> \
       --given-name <имя> \
       --family-name <фамилия> \
       --email <электронная_почта> \
       --phone-number <номер_телефона> \
       --password <пароль>
     ```

     Где:
     
     * `--userpool-id` — идентификатор пула пользователей, в который нужно добавить пользователя.
     * `--username` — логин и домен пользователя в формате `логин@домен`. Логин должен быть уникальным для данного пула пользователей.
     * `--full-name` — имя и фамилия пользователя в произвольном формате.
     * `--given-name` — имя пользователя. Необязательный параметр.
     * `--family-name` — фамилия пользователя. Необязательный параметр.
     * `--email` — электронная почта пользователя. Необязательный параметр.
     * `--phone-number` — номер телефона пользователя. Необязательный параметр.
     * `--password` — пароль пользователя. Необязательный параметр. Если пароль не задан, он сгенерируется автоматически. Пользователь должен будет изменить этот пароль при первом входе в {{ yandex-cloud }}.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).
 
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.
 
  1. Опишите в конфигурационном файле параметры пользователя:
 
     ```hcl
     resource "yandex_organizationmanager_idp_user" "example_user" {
       userpool_id  = <идентификатор_пула>
       username     = "<логин_и_домен>"
       full_name    = "<имя_и_фамилия>"
       given_name   = "<имя>"
       family_name  = "<фамилия>"
       email        = "<электронная_почта>"
       phone_number = "<номер_телефона>"
       is_active    = true
       password_spec = {
         password = "<пароль>"
       }
     }
     ```
 
     Где:
 
     * `userpool_id` — идентификатор [пула пользователей](../concepts/user-pools.md), в который нужно добавить нового пользователя.
     * `username` — логин и домен пользователя в формате `логин@домен`. Логин должен быть уникальным для данного пула пользователей.
     * `full_name` — имя и фамилия пользователя в произвольном формате.
     * `given_name` — имя пользователя. Необязательный параметр.
     * `family_name` — фамилия пользователя. Необязательный параметр.
     * `email` — электронная почта пользователя. Необязательный параметр.
     * `phone_number` — номер телефона пользователя. Необязательный параметр.
     * `password` — пароль пользователя. Необязательный параметр. Если пароль не задан, он сгенерируется автоматически. Пользователь должен будет изменить этот пароль при первом входе в {{ yandex-cloud }}.
     * `is_active` — флаг активации. Установите `true`, чтобы активировать пользователя.
 
     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_user` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_user).
 
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
 
     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../cli/index.md):
 
     ```bash
     yc organization-manager idp user list --userpool-id <идентификатор_пула>
     ```

- API {#api}

  Воспользуйтесь методом REST API [User.Create](../idp/api-ref/User/create.md) для ресурса [User](../idp/api-ref/User/index.md) или вызовом gRPC API [UserService/Create](../idp/api-ref/grpc/User/create.md).

{% endlist %}

#### Что дальше {#what-is-next}

* [Назначьте роли добавленным пользователям](../../iam/operations/roles/grant.md).