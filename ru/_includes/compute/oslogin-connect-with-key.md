Чтобы подключиться к ВМ через {{ oslogin }} по SSH-ключу с помощью {{ yandex-cloud }} CLI:

1. {% include [oslogin-connect-key-enable-in-org](../../_includes/compute/oslogin-connect-key-enable-in-org.md) %}
1. {% include [oslogin-connect-instr-create-ssh-key](../../_includes/compute/oslogin-connect-instr-create-ssh-key.md) %}
1. Посмотрите описание команды CLI для подключения к ВМ:

    ```bash
    yc compute ssh --help
    ```
1. {% include [os-login-cli-organization-list](../../_includes/organization/os-login-cli-organization-list.md) %}
1. {% include [os-login-cli-profile-list](../../_includes/organization/os-login-cli-profile-list.md) %}
1. {% include [oslogin-connect-instr-list-vms](../../_includes/compute/oslogin-connect-instr-list-vms.md) %}
1. Подключитесь к ВМ:

    ```bash
    yc compute ssh \
      --name <имя_ВМ> \
      --identity-file <путь_к_файлу_закрытого_SSH_ключа> \
      --login <логин_пользователя_или_сервисного_аккаунта> \
      --internal-address
    ```

    Где:
    * `--name` — полученное ранее имя виртуальной машины. Вместо имени ВМ можно указать ее идентификатор, для этого используйте параметр `--id`.
    * `--identity-file` — путь к файлу закрытого SSH-ключа. Например: `/home/user1/.ssh/id_ed25519`.
    * `--login` — полученный ранее логин пользователя или сервисного аккаунта, заданный в профиле {{ oslogin }}. Необязательный параметр. Если параметр не задан, для подключения будет использован логин, который указан в [профиле {{ oslogin }}](../../organization/concepts/os-login.md#os-login-profiles) по умолчанию для пользователя или сервисного аккаунта, авторизованного в текущий момент в профиле {{ yandex-cloud }} CLI.
    * `--internal-address` — для подключения по внутреннему IP-адресу. Необязательный параметр.

    Команду для подключения к ВМ вы также можете посмотреть в [консоли управления]({{ link-console-main }}) на странице **{{ ui-key.yacloud.compute.instance.overview.label_title }}** нужной ВМ в блоке **Подключение к виртуальной машине**: раскройте секцию **Подключиться с помощью CLI-интерфейса {{ yandex-cloud }}** и выберите вкладку **По SSH-ключу**.
