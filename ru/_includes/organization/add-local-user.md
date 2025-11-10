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
       --username <логин_и_домен_пользователя> \
       --full-name <имя_и_фамилия_пользователя> \
       --given-name <имя_пользователя> \
       --family-name <фамилия_пользователя> \
       --email <электронная_почта_пользователя> \
       --phone-number <номер_телефона_пользователя> \
       --password <пароль_пользователя>
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

- API {#api}

  Воспользуйтесь методом REST API [User.Create](../../organization/idp/api-ref/User/create.md) для ресурса [User](../../organization/idp/api-ref/User/index.md) или вызовом gRPC API [UserService/Create](../../organization/idp/api-ref/grpc/User/create.md).

{% endlist %}