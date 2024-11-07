Чтобы подключиться к ВМ через {{ oslogin }} по SSH-сертификату с помощью стандартного SSH-клиента:

1. {% include [oslogin-connect-cert-enable-in-org](../../_includes/compute/oslogin-connect-cert-enable-in-org.md) %}
1. [Экспортируйте](../../compute/operations/vm-connect/os-login-export-certificate.md) SSH-сертификат на локальный компьютер.
1. {% include [os-login-cli-organization-list](../../_includes/organization/os-login-cli-organization-list.md) %}
1. {% include [os-login-cli-profile-list](../../_includes/organization/os-login-cli-profile-list.md) %}
1. {% include [oslogin-connect-instr-list-vms](../../_includes/compute/oslogin-connect-instr-list-vms.md) %}

    Сохраните публичный IP-адрес (значение поля `EXTERNAL IP`) виртуальной машины, к которой вы хотите подключиться.
1. Подключитесь к ВМ:

    ```bash
    ssh -i <путь_к_файлу_сертификата> \
      -l <логин_пользователя_или_сервисного_аккаунта> <публичный_IP-адрес_ВМ>
    ```

    Где:

    * `<путь_к_файлу_сертификата>` — путь к экспортированному ранее файлу `Identity` сертификата. Например: `/home/user1/.ssh/yc-cloud-id-b1gia87mbaom********-orgusername`.
    * `<логин_пользователя_или_сервисного_аккаунта>` — полученный ранее логин пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), заданный в профиле {{ oslogin }}.
    * `<публичный_IP-адрес_ВМ>` — сохраненный ранее публичный адрес виртуальной машины.

    Команду для подключения к ВМ вы также можете посмотреть в [консоли управления]({{ link-console-main }}) на странице **{{ ui-key.yacloud.compute.instance.overview.label_title }}** нужной ВМ в блоке **Подключение к виртуальной машине**: раскройте секцию **Подключиться с помощью SSH-клиента** и выберите вкладку **По сертификату**.

    При первом подключении к ВМ появится предупреждение о неизвестном хосте:

    ```text
    The authenticity of host '158.160.**.** (158.160.**.**)' can't be established.
    ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
    Are you sure you want to continue connecting (yes/no)?
    ```

    Введите в терминале слово `yes` и нажмите **Enter**.