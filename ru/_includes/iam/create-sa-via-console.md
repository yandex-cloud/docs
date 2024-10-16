1. Войдите в [консоль управления]({{ link-console-main }}).
1. В левой части экрана нажмите на строку с именем каталога, в котором вы хотите создать сервисный аккаунт.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
1. Введите имя сервисного аккаунта.

   Требования к формату имени:

   {% include [name-format](../name-format.md) %}

   {% include [sa-uniq-name](sa-uniq-name.md) %}

1. Чтобы назначить сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) на текущий каталог, нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль, например `editor`.

   Чтобы назначить роль на другой ресурс, воспользуйтесь CLI или API по инструкции [{#T}](../../iam/operations/sa/assign-role-for-sa.md).

1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
