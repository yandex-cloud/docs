1. В [консоли управления]({{ link-console-main }}) на панели слева нажмите ![image](../../_assets/console-icons/dots-9.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** или найдите его с помощью строки поиска на дашборде.
1. Перейдите в ВМ, к которой хотите подключиться.
1. Справа вверху нажмите ![image](../../_assets/console-icons/terminal.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-ssh }}**.
1. Введите логин пользователя. По умолчанию введен логин, указанный при создании ВМ.
1. Вставьте содержимое или загрузите файл закрытого SSH-ключа.
1. Нажмите **{{ ui-key.yacloud.compute.components.SshViaPrivateKeyDialog.connect-via-private-key_6DKKe }}**.

Внизу откроется терминал ![image](../../_assets/console-icons/terminal.svg) **{{ ui-key.yacloud.cloud-shell.label_service }}** с открытым подключением к ВМ по SSH.

Чтобы закрыть подключение, нажмите ![image](../../_assets/console-icons/xmark.svg) или используйте команду `exit`.