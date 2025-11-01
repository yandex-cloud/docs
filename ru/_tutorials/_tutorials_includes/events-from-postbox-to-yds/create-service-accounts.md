1. Создайте сервисный аккаунт `yds-functions`:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}** и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** укажите имя `yds-functions`.
      1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роли](../../../iam/concepts/access-control/roles.md) `yds.editor` и `{{ roles-functions-invoker }}`.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

    {% endlist %}

1. Аналогичным образом создайте сервисный аккаунт `postbox-user` и назначьте ему [роль](../../../postbox/security/index.md#postbox-sender) `postbox.sender`.