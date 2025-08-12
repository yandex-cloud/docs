Чтобы обеспечить доступ из Nextcloud к бакету {{ objstorage-name }}, создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) и [статический ключ доступа](../../../iam/concepts/authorization/access-key.md).

1. Создайте сервисный аккаунт:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Укажите имя сервисного аккаунта — `nextcloud-sa`.
      1. Нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите [роль](../../../iam/roles-reference.md#editor) `editor`.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

    {% endlist %}

1. Создайте статический ключ доступа:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** и выберите созданный ранее сервисный аккаунт `nextcloud-sa`.
      1. На панели сверху нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
      1. Сохраните идентификатор и секретный ключ.

          {% note alert %}

          После закрытия диалога значение ключа будет недоступно.

          {% endnote %}

    {% endlist %}