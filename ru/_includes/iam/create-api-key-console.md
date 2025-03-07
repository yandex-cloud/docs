1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
1. Выберите сервисный аккаунт, для которого вы хотите создать API-ключ. При необходимости [создайте](../../iam/operations/sa/create.md) новый сервисный аккаунт.
1. На панели сверху нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
1. Выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}**. Подробнее про области действия см. в разделе [{#T}](../../iam/concepts/authorization/api-key.md#scoped-api-keys).
1. (Опционально) Укажите **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-expires-at }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
1. Сохраните идентификатор и секретный ключ.

  {% note alert %}

  После закрытия диалога значение ключа будет недоступно.

  {% endnote %}