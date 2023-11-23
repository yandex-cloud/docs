Вы можете назначить роль на группу как на ресурс. Роль можно выдать пользователям и группам из вашей организации.

Например, разрешите пользователю просматривать информацию о группе и управлять составом участников:

{% list tabs %}

- Cloud Organization

    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора организации.

    1. Перейдите в сервис [{{org-full-name}}]({{ link-org-main }}).

    1. На панели слева выберите раздел **{{ ui-key.yacloud_org.pages.groups }}** ![icon-services](../../_assets/console-icons/persons.svg) и нажмите строку с названием группы.

    1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-access }}**.

    1. Нажмите **{{ ui-key.yacloud_org.entity.group.action_add-acl }}**.

    1. Нажмите **{{ ui-key.yacloud.component.acl.update-dialog.button_select-subject }}**.

    1. Выберите пользователя или группу из списка или воспользуйтесь поиском.

    1. Нажмите **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** и выберите `organization-manager.groups.memberAdmin`.

    1. Нажмите **{{ ui-key.yacloud.common.save }}**.

    Пользователь отобразится в списке прав доступа к группе.

{% endlist %}
