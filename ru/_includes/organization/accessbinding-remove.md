
Чтобы отозвать у пользователя роль на группу:

{% list tabs %}

- Cloud Organization

    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора организации.

    1. Перейдите в сервис [{{org-full-name}}]({{ link-org-main }}).

    1. На панели слева выберите раздел **{{ ui-key.yacloud_org.pages.groups }}** ![icon-services](../../_assets/organization/icon-groups.svg) и нажмите строку с названием группы.

    1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-access }}**.

    1. Выберите пользователя в списке и нажмите ![image](../../_assets/options.svg) напротив имени пользователя.

    1. Нажмите **{{ ui-key.yacloud_org.entity.group.action_update-acl }}**.

    1. Нажмите ![image](../../_assets/cross.svg) напротив роли, которую хотите отозвать.

    1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

{% note tip %}

Чтобы открыть список пользователей, которым доступно управление группой на уровне [роли в организации](../../organization/security/index.md) (например, администратор или владелец организации), перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-access }}** и включите опцию **{{ ui-key.yacloud.common.resource-acl.label_inherited-bindings }}**.

{% endnote %}
