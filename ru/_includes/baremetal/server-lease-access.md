В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

1. Напротив поля **{{ ui-key.yacloud.baremetal.field_password }}** нажмите кнопку **Сгенерировать**, чтобы сгенерировать пароль для root-пользователя.  

    {% note warning %}

    Сохраните сгенерированный пароль в надежном месте: он не сохраняется в {{ yandex-cloud }}, и после заказа сервера вы не сможете посмотреть его.

    {% endnote %}

1. В поле **{{ ui-key.yacloud.baremetal.field_ssh-public-key }}** вставьте содержимое файла открытого ключа. Пару ключей для подключения по SSH необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.