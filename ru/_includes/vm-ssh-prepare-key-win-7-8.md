Создайте ключи с помощью приложения PuTTY:

1. [Скачайте](https://www.putty.org) и установите PuTTY.
1. Добавьте папку с PuTTY в переменную `PATH`:

    {% include [windows-environment-vars](windows-environment-vars.md) %}

1. Запустите приложение PuTTYgen.
1. В качестве типа генерируемой пары выберите **EdDSA**. Нажмите **Generate** и поводите курсором в поле выше до тех пор, пока не закончится создание ключа.

    ![ssh_generate_key](../_assets/compute/ssh-putty/ssh_generate_key.png)

1. В поле **Key passphrase** введите надежный пароль. Повторно введите его в поле ниже.
1. Нажмите кнопку **Save private key** и сохраните закрытый ключ. Никому не сообщайте ключевую фразу от него.
1. Нажмите кнопку **Save public key** и сохраните открытый ключ в файле `<имя_ключа>.pub`.