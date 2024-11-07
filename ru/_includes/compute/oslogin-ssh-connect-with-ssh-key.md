Чтобы подключиться к ВМ через {{ oslogin }} по SSH-ключу с помощью стандартного SSH-клиента:

1. {% include [oslogin-connect-key-enable-in-org](../../_includes/compute/oslogin-connect-key-enable-in-org.md) %}
1. {% include [oslogin-connect-instr-create-ssh-key](../../_includes/compute/oslogin-connect-instr-create-ssh-key.md) %}
1. {% include [os-login-cli-organization-list](../../_includes/organization/os-login-cli-organization-list.md) %}
1. {% include [os-login-cli-profile-list](../../_includes/organization/os-login-cli-profile-list.md) %}
1. {% include [oslogin-connect-instr-list-vms](../../_includes/compute/oslogin-connect-instr-list-vms.md) %}

    Сохраните публичный IP-адрес (значение поля `EXTERNAL IP`) виртуальной машины, к которой вы хотите подключиться.
1. Подключитесь к ВМ:

    ```bash
    ssh -i <путь_к_файлу_закрытого-SSH-ключа> \
      -l <логин_пользователя_или_сервисного_аккаунта> <публичный_IP-адрес_ВМ>
    ```

    Где:

    * `<путь_к_файлу_закрытого-SSH-ключа>` — путь к файлу, в котором сохранен закрытый SSH-ключ. Например: `/home/user1/.ssh/id_ed25519`. 
    * `<логин_пользователя_или_сервисного_аккаунта>` — полученный ранее логин пользователя или сервисного аккаунта, заданный в профиле {{ oslogin }}.
    * `<публичный_IP-адрес_ВМ>` — сохраненный ранее публичный адрес виртуальной машины.

    Команду для подключения к ВМ вы также можете посмотреть в [консоли управления]({{ link-console-main }}) на странице **{{ ui-key.yacloud.compute.instance.overview.label_title }}** нужной ВМ в блоке **Подключение к виртуальной машине**: раскройте секцию **Подключиться с помощью SSH-клиента** и выберите вкладку **По SSH-ключу**.

    При первом подключении к ВМ появится предупреждение о неизвестном хосте:

    ```text
    The authenticity of host '158.160.**.** (158.160.**.**)' can't be established.
    ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
    Are you sure you want to continue connecting (yes/no)?
    ```

    Введите в терминале слово `yes` и нажмите **Enter**.