{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный [пул пользователей](../../organization/concepts/user-pools.md).
  1. На вкладке **{{ ui-key.yacloud_org.organization.userpools.title_userpool_members }}** нажмите **{{ ui-key.yacloud_org.organization.userpools.action_create-user }}**.
  1. Введите логин пользователя и выберите [домен](../../organization/concepts/domains.md) из списка. Логин должен быть уникальным для данного пула пользователей.
  
      Если нужного домена нет, [добавьте новый](../../organization/operations/user-pools/add-domain.md).
  1. В поле **{{ ui-key.yacloud_org.organization.userpools.field_full-name }}** укажите имя и фамилию пользователя в произвольном формате.  
  1. (Опционально) Добавьте электронную почту пользователя.
  1. В поле **{{ ui-key.yacloud_org.organization.userpools.field_password }}** вы можете посмотреть автоматически сгенерированный пароль пользователя и сгенерировать новый пароль.
  
      Пользователь должен будет изменить этот пароль при первом входе в {{ yandex-cloud }}.
  1. Включите опцию **{{ ui-key.yacloud_org.organization.userpools.field_active }}**, если нужно активировать пользователя сразу после добавления. Активированные пользователи получают доступ к ресурсам организации.
  1. (Опционально) В блоке **{{ ui-key.yacloud_org.organization.userpools.title_personal-info }}** укажите имя, фамилию и номер телефона пользователя.
  1. Нажмите **{{ ui-key.yacloud_org.organization.userpools.action_create-user }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для добавления пользователя в [пул](../../organization/concepts/user-pools.md):

     ```bash
     yc organization-manager idp user create --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp user create \
       --userpool-id <идентификатор_пула> \
       --username <логин_и_домен_пользователя> \
       --full-name <имя_и_фамилия_пользователя> \
       --given-name <имя_пользователя> \
       --family-name <фамилия_пользователя> \
       --email <электронная_почта_пользователя> \
       --phone-number <номер_телефона_пользователя> \
       --password <пароль_пользователя> \
       --is-active false
     ```

     Где:
     
     * `--userpool-id` — идентификатор пула пользователей, в который нужно добавить пользователя.
     * `--username` — логин и домен пользователя в формате `логин@домен`. Логин должен быть уникальным для данного пула пользователей.
     * `--full-name` — имя и фамилия пользователя в произвольном формате.
     * `--given-name` — имя пользователя. Необязательный параметр.
     * `--family-name` — фамилия пользователя. Необязательный параметр.
     * `--email` — электронная почта пользователя. Необязательный параметр.
     * `--phone-number` — номер телефона пользователя. Необязательный параметр.
     * `--password` — пароль пользователя. Если пароль не задан, он сгенерируется автоматически. Пользователь должен будет изменить этот пароль при первом входе в {{ yandex-cloud }}.
     * `--is-active` — параметр, который активирует пользователя. Укажите `true`, если нужно активировать пользователя сразу после добавления. Активированные пользователи получают доступ к ресурсам организации.

{% endlist %}