1. [Перейдите]({{ link-console-main }}/link/compute) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Выберите ВМ, к которой хотите подключиться.
1. Убедитесь, что ВМ находится в статусе `Running`. Если ВМ не запущена, в правом верхнем углу нажмите ![image](../../_assets/console-icons/play.svg) **{{ ui-key.yacloud.compute.instances.button_gr-action-start }}** и дождитесь перехода ВМ в статус `Running`.
1. Справа вверху нажмите ![image](../../_assets/console-icons/terminal.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-ssh }}**.
1. Введите логин пользователя. По умолчанию введен логин, указанный при создании ВМ.
1. Вставьте содержимое или загрузите файл закрытого SSH-ключа.
1. Нажмите **{{ ui-key.yacloud.compute.components.SshViaPrivateKeyDialog.connect-via-private-key_6DKKe }}**.

Внизу откроется терминал ![image](../../_assets/console-icons/terminal.svg) **{{ ui-key.yacloud.cloud-shell.label_service }}** с открытым подключением к ВМ по SSH.

Чтобы закрыть подключение, нажмите ![image](../../_assets/console-icons/xmark.svg) или используйте команду `exit`.