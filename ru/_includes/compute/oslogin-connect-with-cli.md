Чтобы подключиться к ВМ через OS Login по SSH-сертификату с помощью YC CLI:

1. {% include [oslogin-connect-cert-enable-in-org](../../_includes/compute/oslogin-connect-cert-enable-in-org.md) %}
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
      --name <имя_ВМ>
      --login <логин_пользователя_или_сервисного_аккаунта>
      --internal-address
    ```

    Где:
    * `--name` — полученное ранее имя виртуальной машины. Вместо имени ВМ можно указать ее идентификатор, для этого используйте параметр `--id`.
    * `--login` — полученный ранее логин пользователя или сервисного аккаунта, заданный в профиле OS Login. Необязательный параметр. Если параметр не задан, для подключения будет использован SSH-сертификат пользователя или сервисного аккаунта, авторизованного в текущий момент в профиле YC CLI.
    * (опционально) `--internal-address` — для подключения по внутреннему IP-адресу.

    Команду для подключения к ВМ вы также можете посмотреть в [консоли управления]({{ link-console-main }}) на странице **{{ ui-key.yacloud.compute.instance.overview.label_title }}** нужной ВМ в блоке **Подключение к виртуальной машине**: раскройте секцию **Подключиться с помощью CLI-интерфейса {{ yandex-cloud }}** и выберите вкладку **По сертификату**.