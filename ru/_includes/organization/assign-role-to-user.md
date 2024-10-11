1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.

1. Если у нужного пользователя уже есть хотя бы одна роль, в строке с этим пользователем нажмите значок ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

    Если нужного пользователя нет в списке, в правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud_org.entity.user.action.acl }}**. В открывшемся окне выберите пользователя из списка или воспользуйтесь строкой поиска.

1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.form.acl.edit.action.role.add }}** и выберите [роль](../../iam/concepts/access-control/roles.md), которую хотите назначить пользователю. Вы можете назначить несколько ролей.

    Описание доступных ролей можно найти в документации {{ iam-full-name }} в [справочнике ролей {{ yandex-cloud }}](../../iam/roles-reference.md).

1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.