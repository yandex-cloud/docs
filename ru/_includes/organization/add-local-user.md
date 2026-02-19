{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![userpool](../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный [пул пользователей](../../organization/concepts/user-pools.md).
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.userpools.title_userpool_members }}** и нажмите кнопку ![person-plus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.userpools.action_create-user }}**.
  1. В поле **{{ ui-key.yacloud_org.organization.userpools.field_username }}** введите логин пользователя и выберите [домен](../../organization/concepts/domains.md) из списка. Логин должен быть уникальным для данного пула пользователей.
  
      Если нужного домена нет, [создайте новый](../../organization/operations/user-pools/add-domain.md).
  1. В поле **{{ ui-key.yacloud_org.organization.userpools.field_full-name }}** укажите имя и фамилию пользователя в произвольном формате.  
  1. (Опционально) Добавьте адрес электронной почты пользователя.
  1. В поле **{{ ui-key.yacloud_org.organization.userpools.field_password }}** вы можете посмотреть автоматически сгенерированный пароль пользователя и сгенерировать новый пароль.
  
      Пользователь должен будет изменить этот пароль при первом входе в {{ yandex-cloud }}.
  1. Включите опцию **{{ ui-key.yacloud_org.organization.userpools.field_active }}**, если нужно активировать пользователя сразу после добавления. Активированные пользователи получают доступ к ресурсам организации.
  1. (Опционально) Разверните блок **{{ ui-key.yacloud_org.organization.userpools.title_personal-info }}** и укажите имя, фамилию и номер телефона пользователя.
  1. Нажмите **{{ ui-key.yacloud_org.organization.userpools.action_create-user }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для добавления пользователя в [пул](../../organization/concepts/user-pools.md):

     ```bash
     yc organization-manager idp user create --help
     ```
  1. {% include [cli-list-userpools](./cli-list-userpools.md) %}
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

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}
 
  {% include [terraform-install](../terraform-install.md) %}
 
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
 
     * `userpool_id` — идентификатор [пула пользователей](../../organization/concepts/user-pools.md), в который нужно добавить нового пользователя.
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
 
     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
 
     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../cli/):
 
     ```bash
     yc organization-manager idp user list --userpool-id <идентификатор_пула>
     ```

- API {#api}

  Воспользуйтесь методом REST API [User.Create](../../organization/idp/api-ref/User/create.md) для ресурса [User](../../organization/idp/api-ref/User/index.md) или вызовом gRPC API [UserService/Create](../../organization/idp/api-ref/grpc/User/create.md).

{% endlist %}