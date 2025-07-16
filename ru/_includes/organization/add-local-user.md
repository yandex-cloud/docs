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

{% endlist %}