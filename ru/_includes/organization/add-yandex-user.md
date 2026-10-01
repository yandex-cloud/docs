1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.

1. В правом верхнем углу экрана нажмите кнопку ![person-plus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.page.users.dropdown.button-text }}** и в выпадающем списке выберите ![person-planet-earth](../../_assets/console-icons/person-planet-earth.svg) **{{ ui-key.yacloud_org.page.users.action.invite-users }}**.

1. Введите почтовые адреса пользователей, которых вы хотите пригласить в организацию (например, `{{ login-example }}`).

    {% include [send-invitation](./send-invitation.md) %}

1. Для отправки приглашений нажмите кнопку **{{ ui-key.yacloud_components.organization.action_next }}**. Откроется окно для назначения ролей и добавления пользователей в группу.

1. {% include [assign-roles-on-invite](../organization/assign-roles-on-invite.md) %}

    Назначать роли можно на [организацию](../../organization/concepts/organization.md), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на вложенные ресурсы.

1. {% include [add-to-group-on-invite](../organization/add-to-group-on-invite.md) %}
