1. В [консоли управления]({{link-console-main}}) выберите каталог, которому принадлежит виртуальная машина.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Выберите нужную ВМ.
1. Справа вверху нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.compute.instances.button_action-password-reset }}**.

    {% note info %}

    Если в открывшемся окне вы видите сообщение о том, что на ВМ не работает агент для сброса паролей, проверьте, что он установлен, и посмотрите логи его работы. Подробнее см. в разделе [{#T}](../../compute/operations/vm-guest-agent/check.md).

    {% endnote %}

1. Укажите имя пользователя, для которого нужно сбросить пароль. Если на ВМ не существует пользователя с таким именем, он будет создан с правами администратора.

    Чтобы сбросить пароль администратора, укажите `Administrator`.

1. Нажмите **{{ ui-key.yacloud.compute.instance.popup-confirm_button_password-reset }}**.