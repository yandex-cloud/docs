1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
1. Выберите сервисный аккаунт и нажмите на строку с его именем. При необходимости [создайте](../../iam/operations/sa/create.md) новый сервисный аккаунт.
1. На панели сверху нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
1. Сохраните идентификатор и секретный ключ.

  {% note alert %}

  После закрытия диалога значение ключа будет недоступно.

  {% endnote %}